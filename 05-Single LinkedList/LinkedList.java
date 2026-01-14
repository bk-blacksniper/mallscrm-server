
public class LinkedList<E> {
  private int size;
  private Node<E> head;
  private Node<E> tail;

  public LinkedList(){
    this.size = 0;
  }

  public int size(){
    return size;
  } 

  public boolean isEmpty(){
    return this.head == null && this.tail == null;
  }

  public void addFirst(E data){
    if(isEmpty()){

      this.head = new Node<E>(data);
      this.tail = this.head;
    
    }else{
    
      Node<E> newNode = new Node<E>(data);
      newNode.next = this.head;
      this.head = newNode;
    
    }

    size++;      
  }

  public void addLast(E data){
    if(isEmpty()){
    
      this.head = new Node<E>(data);
      this.tail = head;
    
    }else{

      tail.next = new Node<E>(data);
      tail = tail.next;

    }

    size++;
  }


  public void add(E data){
    addLast(data);
  }

  public void add(int index, E data){
    if(index == 0){
      addFirst(data);
    }else if(index == size - 1){
      addLast(data);
    }else if(index > 0 && index < size - 1){
      Node<E> current = head;
      Node<E> previus = null;

      int i = 0;
      while(i <= index){
        if(i == index - 1){
          previus = current;
        }

        if(i == index){
          previus.next = new Node<E>(data);
          previus.next.next = current;
          size++;
          break;
        }
        current = current.next;
        i++;
      }

    }else{
      throw new IndexOutOfBoundsException("invalid index");
    }
  }

  public void deleteFirst(){
    if (size == 1){
        head = null;
        tail = null;
    }else{
        head = head.next;
    }
    size--;
  }

  public void deleteLast(){
    if (size == 1){
        head = null;
        tail = null;
        size--;
    }else{
        Node<E> current = head;
        for (int i = 0 ; i< size ; i++){
            if (i == size - 2){
                current.next = null;
                tail = current;
                size--;
            }
            current = current.next;
        }
    }
  }

  public void delete(int index){
      if (index == 0){
          deleteFirst();
      }else if(index == size-1){
          deleteLast();
      }else{
          Node<E> current = head;
          for (int i = 0; i < size; i++) {
              if (index - 1 == i){
                  current.next = current.next.next;
                  size--;
                  break;
              }
              current = current.next;
          }
      }
  }

  public E get(int index){
    if(index == 0){
      return head.data;
    }else if(index == size - 1){
      return tail.data;
    }else if(index > 0 && index < size - 1){
      Node<E> current = head;
      for(int i = 0; i < size; i++){
        if(i == index){
          return current.data;
        }
        current = current.next;
      }
    }else{
      throw new IndexOutOfBoundsException("invalid index");
    }

    return null;
  }

  class Node<T>{
    private T data;
    private Node<T> next;

    public Node(T data){
      this.data = data;
    }

    public T getData(){
      return this.data;
    }

    public Node<T> getNext(){
      return this.next;
    }
  }

}