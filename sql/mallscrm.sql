-- --------------------------------------------------------
-- 商场（主数据）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `malls`;
CREATE TABLE `malls`
(
    `id`          int(10) unsigned     NOT NULL AUTO_INCREMENT COMMENT '商场ID',
    `title`       varchar(100)         NOT NULL DEFAULT '' COMMENT '名称',
    `code`        varchar(32)          NOT NULL DEFAULT '' COMMENT '编码',
    `logo`        varchar(255)         NOT NULL DEFAULT '' COMMENT 'Logo',
    `address`     varchar(255)         NOT NULL DEFAULT '' COMMENT '地址',
    `contact`     varchar(20)          NOT NULL DEFAULT '' COMMENT '联系方式',
    `description` varchar(500)         NOT NULL DEFAULT '' COMMENT '简介',
    `content`     text                 NOT NULL COMMENT '图文详情',
    `sort`        smallint(5) unsigned NOT NULL DEFAULT 0 COMMENT '排序值',
    `state`       tinyint(3) unsigned  NOT NULL DEFAULT 1 COMMENT '状态：1-启用，2-停用',
    `created_at`  datetime             NOT NULL COMMENT '创建时间',
    `updated_at`  datetime             NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='商场（主数据）';

-- --------------------------------------------------------
-- 楼层（商场子实体）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `floors`;
CREATE TABLE `floors`
(
    `id`         int(10) unsigned     NOT NULL AUTO_INCREMENT COMMENT '楼层ID',
    `mall_id`    int(10) unsigned     NOT NULL COMMENT '商场ID',
    `title`      varchar(50)          NOT NULL DEFAULT '' COMMENT '楼层名称',
    `sort`       smallint(5) unsigned NOT NULL DEFAULT 0 COMMENT '排序值',
    `state`      tinyint(3) unsigned  NOT NULL DEFAULT 1 COMMENT '状态：1-启用，2-停用',
    `created_at` datetime             NOT NULL COMMENT '创建时间',
    `updated_at` datetime             NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_mall_id` (`mall_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='楼层（商场子实体）';

-- --------------------------------------------------------
-- 业态（分类体系）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `commercial_types`;
CREATE TABLE `commercial_types`
(
    `id`              int(10) unsigned     NOT NULL AUTO_INCREMENT COMMENT '业态ID',
    `parent_id`       int(10) unsigned     NOT NULL DEFAULT 0 COMMENT '父级ID',
    `title`           varchar(50)          NOT NULL DEFAULT '' COMMENT '业态名称',
    `level`           tinyint(3) unsigned  NOT NULL DEFAULT 1 COMMENT '层级：1-一级，2-二级',
    `enable_integral` tinyint(1) unsigned  NOT NULL DEFAULT 0 COMMENT '是否启用积分：0-否，1-是',
    `integral_ratio`  varchar(10)          NOT NULL DEFAULT '' COMMENT '积分比例（如 10:1）',
    `sort`            smallint(5) unsigned NOT NULL DEFAULT 0 COMMENT '排序值',
    `state`           tinyint(3) unsigned  NOT NULL DEFAULT 1 COMMENT '状态：1-启用，2-停用',
    `created_at`      datetime             NOT NULL COMMENT '创建时间',
    `updated_at`      datetime             NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_parent_id` (`parent_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='业态（分类体系）';

-- --------------------------------------------------------
-- 品牌（主数据）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`
(
    `id`          int(10) unsigned    NOT NULL AUTO_INCREMENT COMMENT '品牌ID',
    `title`       varchar(100)        NOT NULL DEFAULT '' COMMENT '品牌名称',
    `code`        varchar(32)         NOT NULL DEFAULT '' COMMENT '品牌编码',
    `logo`        varchar(255)        NOT NULL DEFAULT '' COMMENT 'Logo',
    `description` varchar(500)        NOT NULL DEFAULT '' COMMENT '品牌介绍',
    `state`       tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态：1-启用，2-停用',
    `created_at`  datetime            NOT NULL COMMENT '创建时间',
    `updated_at`  datetime            NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`),
    KEY `idx_title` (`title`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='品牌（主数据）';

-- --------------------------------------------------------
-- 商户（商场内经营主体）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `merchants`;
CREATE TABLE `merchants`
(
    `id`                     int(10) unsigned    NOT NULL AUTO_INCREMENT COMMENT '商户ID',
    `mall_id`                int(10) unsigned    NOT NULL COMMENT '商场ID',
    `code`                   varchar(32)         NOT NULL DEFAULT '' COMMENT '编码',
    `title`                  varchar(120)        NOT NULL DEFAULT '' COMMENT '名称',
    `pinyin`                 varchar(150)        NOT NULL DEFAULT '' COMMENT '拼音',
    `brand_id`               int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '品牌ID',
    `commercial_type_id`     int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '一级业态ID',
    `sub_commercial_type_id` int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '二级业态ID',
    `floor_id`               int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '楼层ID',
    `door_no`                varchar(50)         NOT NULL DEFAULT '' COMMENT '铺位号',
    `logo`                   varchar(255)        NOT NULL DEFAULT '' COMMENT 'Logo',
    `images`                 text                NOT NULL DEFAULT '' COMMENT '门店图集（JSON）',
    `is_new`                 tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否新店：0-否，1-是',
    `operation_state`        tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '运营状态：1-营业中，2-装修中，3-暂停营业，4-已退场',
    `contacts`               text                NOT NULL DEFAULT '' COMMENT '联系方式（JSON）',
    `description`            varchar(500)        NOT NULL DEFAULT '' COMMENT '简介',
    `rating`                 decimal(2, 1)       NOT NULL DEFAULT 0.0 COMMENT '评分（0.0~5.0）',
    `like_count`             int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '点赞数',
    `favorite_count`         int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '收藏数',
    `business_hours`         varchar(100)        NOT NULL DEFAULT '' COMMENT '营业时间（如 10:00-22:00）',
    `enable_integral`        tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否启用积分：0-否，1-是',
    `integral_ratio`         varchar(10)         NOT NULL DEFAULT '' COMMENT '积分比例（如 10:1）',
    `state`                  tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态：1-正常，2-封禁',
    `created_at`             datetime            NOT NULL COMMENT '创建时间',
    `updated_at`             datetime            NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`),
    KEY `idx_mall_id` (`mall_id`),
    KEY `idx_floor_id` (`floor_id`),
    KEY `idx_commercial` (`commercial_type_id`, `sub_commercial_type_id`),
    KEY `idx_brand_id` (`brand_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='商户（商场内经营主体）';

-- --------------------------------------------------------
-- 会员等级（可配置等级体系）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `member_levels`;
CREATE TABLE `member_levels`
(
    `id`            int(10) unsigned     NOT NULL AUTO_INCREMENT COMMENT '等级ID',
    `title`         varchar(50)          NOT NULL DEFAULT '' COMMENT '等级名称（如 普通会员、黄金会员）',
    `code`          varchar(32)          NOT NULL DEFAULT '' COMMENT '等级编码',
    `discount_rate` decimal(3, 2)        NOT NULL DEFAULT 1.00 COMMENT '折扣率（1.00 表示无折扣）',
    `description`   varchar(200)         NOT NULL DEFAULT '' COMMENT '等级说明',
    `sort`          smallint(5) unsigned NOT NULL DEFAULT 0 COMMENT '排序值',
    `state`         tinyint(3) unsigned  NOT NULL DEFAULT 1 COMMENT '状态：1-启用，2-停用',
    `created_at`    datetime             NOT NULL COMMENT '创建时间',
    `updated_at`    datetime             NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='会员等级（可配置等级体系）';

-- --------------------------------------------------------
-- 会员等级规则（升降级条件）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `member_level_rules`;
CREATE TABLE `member_level_rules`
(
    `id`              int(10) unsigned     NOT NULL AUTO_INCREMENT COMMENT '规则ID',
    `level_id`        int(10) unsigned     NOT NULL COMMENT '目标等级ID',
    `title`           varchar(100)         NOT NULL DEFAULT '' COMMENT '规则标题（如：年消费满1万元升黄金会员）',
    `rule_type`       tinyint(3) unsigned  NOT NULL COMMENT '规则类型：1-升级，2-降级',
    `period_type`     tinyint(3) unsigned  NOT NULL COMMENT '周期类型：1-年，2-月，3-日，4-自定义天数，5-指定时间区间',
    `period_days`     int(10) unsigned     NOT NULL DEFAULT 0 COMMENT '自定义天数（period_type=4时生效）',
    `start_time`      datetime                      DEFAULT NULL COMMENT '有效开始时间（period_type=5时必填）',
    `end_time`        datetime                      DEFAULT NULL COMMENT '有效结束时间（period_type=5时必填）',
    `min_consumption` bigint(20)           NOT NULL DEFAULT 0 COMMENT '最低消费金额（单位：分）',
    `description`     varchar(200)         NOT NULL DEFAULT '' COMMENT '详细说明',
    `sort`            smallint(5) unsigned NOT NULL DEFAULT 0 COMMENT '排序值，越小优先级越高',
    `created_at`      datetime             NOT NULL COMMENT '创建时间',
    `updated_at`      datetime             NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_level_id` (`level_id`),
    KEY `idx_time_range` (`start_time`, `end_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='会员等级规则（升降级条件）';

-- --------------------------------------------------------
-- 会员（用户主数据）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `members`;
CREATE TABLE `members`
(
    `id`                    int(10) unsigned    NOT NULL AUTO_INCREMENT COMMENT '会员ID',
    `mobile`                varchar(20)         NOT NULL DEFAULT '' COMMENT '手机号',
    `nickname`              varchar(64)         NOT NULL DEFAULT '' COMMENT '昵称',
    `avatar`                varchar(255)        NOT NULL DEFAULT '' COMMENT '头像URL',
    `gender`                tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
    `level_id`              int(10) unsigned    NOT NULL DEFAULT 1 COMMENT '当前等级ID',
    `level_assigned_at`     datetime            NOT NULL COMMENT '等级生效时间',
    `level_expires_at`      datetime                     DEFAULT NULL COMMENT '等级过期时间（NULL表示永久）',
    `points_balance`        int(11)             NOT NULL DEFAULT 0 COMMENT '积分余额',
    `last_points_change_at` datetime                     DEFAULT NULL COMMENT '最后积分变动时间',
    `total_consumption`     bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '累计消费金额（分）',
    `last_consumption_at`   datetime                     DEFAULT NULL COMMENT '最后消费时间',
    `registered_at`         datetime            NOT NULL COMMENT '注册时间',
    `state`                 tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态：1-正常，2-冻结',
    `created_at`            datetime            NOT NULL COMMENT '创建时间',
    `updated_at`            datetime            NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_mobile` (`mobile`),
    KEY `idx_level_id` (`level_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='会员（用户主数据）';

-- --------------------------------------------------------
-- 用户身份绑定（用于多平台登录）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `user_identities`;
CREATE TABLE `user_identities`
(
    `id`            int(10) unsigned    NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `member_id`     int(10) unsigned    NOT NULL COMMENT '会员ID',
    `platform_type` tinyint(3) unsigned NOT NULL COMMENT '平台类型：1-wechat，2-alipay',
    `app_id`        varchar(64)         NOT NULL COMMENT 'AppID',
    `open_id`       varchar(128)        NOT NULL DEFAULT '' COMMENT 'OpenID',
    `union_id`      varchar(128)        NOT NULL DEFAULT '' COMMENT 'UnionID',
    `created_at`    datetime            NOT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_platform_openid` (`platform_type`, `open_id`),
    KEY `idx_member_id` (`member_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='用户身份绑定（用于多平台登录）';

-- --------------------------------------------------------
-- 会员积分流水记录（核心账务表）
-- --------------------------------------------------------
DROP TABLE IF EXISTS `member_point_records`;
CREATE TABLE `member_point_records`
(
    `id`              bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `member_id`       int(10) unsigned    NOT NULL COMMENT '会员ID',
    `mall_id`         int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '商场ID（0表示平台级）',
    `change_type`     tinyint(3) unsigned NOT NULL COMMENT '变动方向：1-增加，2-减少',
    `event_type`      tinyint(3) unsigned NOT NULL COMMENT '事件类型：1-消费获得，2-订单退款，3-人工调整，4-活动奖励，5-系统发放，6-积分兑换',
    `points_amount`   int(11)             NOT NULL DEFAULT 0 COMMENT '积分变动值（始终为正数）',
    `balance_before`  int(11)             NOT NULL DEFAULT 0 COMMENT '变动前余额',
    `balance_after`   int(11)             NOT NULL DEFAULT 0 COMMENT '变动后余额',
    `business_id`     varchar(64)         NOT NULL DEFAULT '' COMMENT '主业务ID（如订单号、活动ID）',
    `business_sub_id` varchar(64)         NOT NULL DEFAULT '' COMMENT '子业务ID（可选）',
    `trade_no`        varchar(30)         NOT NULL COMMENT '本系统积分交易流水号（唯一）',
    `description`     varchar(200)        NOT NULL DEFAULT '' COMMENT '备注说明',
    `operator`        varchar(50)         NOT NULL DEFAULT '' COMMENT '操作者标识（用于展示）',
    `operator_id`     int(10) unsigned    NOT NULL DEFAULT 0 COMMENT '操作人ID（0=系统，>0=管理员/用户ID）',
    `change_time`     datetime            NOT NULL COMMENT '积分实际变动时间（业务发生时间）',
    `created_at`      datetime            NOT NULL COMMENT '记录创建时间',
    `updated_at`      datetime            NOT NULL COMMENT '记录更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_trade_no` (`trade_no`),
    KEY `idx_member_id` (`member_id`),
    KEY `idx_mall_id` (`mall_id`),
    KEY `idx_event_business` (`event_type`, `business_id`),
    KEY `idx_operator_id` (`operator_id`),
    KEY `idx_change_time` (`change_time`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='会员积分流水记录（核心账务表）';