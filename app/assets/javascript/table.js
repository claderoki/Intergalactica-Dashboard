
  let lastIndex = document.querySelector('#itemsTable tbody').children.length;

  function createRow(table) {
      let row = document.querySelector('#templateRow').cloneNode(true);
      // let row = table.closest('#templateRow').cloneNode(true);
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
      // let table = event.target.closest('#itemsTable');
      let table = document.getElementById('itemsTable');
      table.children[0].appendChild(createRow(table));
  }

  function getUniqueIndex() {
      return ++lastIndex;
  }
