
  let lastIndex = document.querySelector('#locationsTable tbody').children.length;

  function createRow() {
      let row = document.querySelector('#templateRow').cloneNode(true);
      row.removeAttribute('hidden');
      row.setAttribute('id', 'valueRow');
      row.innerHTML = row.innerHTML.replaceAll('{{index}}', getUniqueIndex())
      return row;
  }

  function removeRow(event) {
    let row = event.target.closest('tr');
    row.remove();
  }

  function addRow(event) {
      let table = document.getElementById('locationsTable');
      table.children[0].appendChild(createRow());
  }

  function getUniqueIndex() {
      return ++lastIndex;
  }
