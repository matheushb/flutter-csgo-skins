abstract class Service<E> {
  Future<List<E>> find();

  Future<E> findOne(String id);

  Future<E> create(Object body);

  Future<void> delete(String id);

  Future<E> update(String id, Object body);
}
