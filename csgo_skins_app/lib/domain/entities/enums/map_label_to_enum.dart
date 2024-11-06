String mapCategoryToQuery(String category) {
  switch (category) {
    case 'Todas':
      return '';
    case 'Facas':
      return 'knife';
    case 'Luvas':
      return 'gloves';
    case 'Rifles':
      return 'rifle';
    case 'Pistolas':
      return 'pistol';
    case 'Smg':
      return 'smg';
    case 'Pesadas':
      return 'heavy';
    case 'outras':
      return '';
    default:
      return '';
  }
}
