var dateStr = "02/01/25 - 04/30/25";
var machineList = "cca-emu(144LDs), ccd-emu(144LDs), cch-emu(72LDs), ccl-emu(144LDs)";
var defaultSystem = ['cca-emu'];
var defaultMonth = ['2025/2'];
var rowData = [
['2/1-2/1', 'cca-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/2-2/8', 'cca-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/9-2/15', 'cca-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/16-2/22', 'cca-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'cca-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'cca-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/2-3/8', 'cca-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/9-3/15', 'cca-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/16-3/22', 'cca-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/23-3/29', 'cca-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'cca-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'cca-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/6-4/12', 'cca-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/13-4/19', 'cca-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/20-4/26', 'cca-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/27-4/30', 'cca-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['2/1-2/1', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/2-2/8', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/9-2/15', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/16-2/22', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'ccd-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/2-3/8', 'ccd-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/9-3/15', 'ccd-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/16-3/22', 'ccd-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/23-3/29', 'ccd-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'ccd-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'ccd-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/6-4/12', 'ccd-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/13-4/19', 'ccd-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/20-4/26', 'ccd-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/27-4/30', 'ccd-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['2/1-2/1', 'cch-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/2-2/8', 'cch-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/9-2/15', 'cch-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/16-2/22', 'cch-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'cch-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/2-3/8', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/9-3/15', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/16-3/22', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/23-3/29', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/6-4/12', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/13-4/19', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/20-4/26', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/27-4/30', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['2/1-2/1', 'ccl-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/2-2/8', 'ccl-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/9-2/15', 'ccl-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/16-2/22', 'ccl-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'ccl-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'ccl-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/2-3/8', 'ccl-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/9-3/15', 'ccl-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/16-3/22', 'ccl-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/23-3/29', 'ccl-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'ccl-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'ccl-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/6-4/12', 'ccl-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/13-4/19', 'ccl-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/20-4/26', 'ccl-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0],
['4/27-4/30', 'ccl-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0]
];
