var dateStr = "02/01/25 - 05/28/25";
var machineList = "cca-emu(144LDs), ccd-emu(144LDs), cch-emu(72LDs)";
var defaultSystem = ['cca-emu'];
var defaultMonth = ['2025/2'];
var numSystem = 3;
var numUser = 28;
var user = [
"xinhengh",
"wesleyweng",
"uwardhan",
"traspadini",
"taoluwork",
"sureshbala",
"sramanan",
"sinchanamakam",
"simerjit",
"sharmishthap",
"root",
"rampenugonda",
"ramanj",
"quangd",
"nishantsingla",
"micray",
"maduwant",
"kinchiu",
"khullarp",
"jithinsankar",
"jarlagad",
"huat",
"eda-build-deepsea",
"dpapp",
"chulc",
"antaraconnects",
"alokmistry",
"achitrod",
];
var rowData = [
['2/1-2/1', 'cca-emu', '2025/2', 2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['2/2-2/8', 'cca-emu', '2025/2', 50, 0, 0, 0, 0, 0, 8, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 20, 0, 0, 0, 0, 0, 2, 0],
['2/9-2/15', 'cca-emu', '2025/2', 10, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0],
['2/16-2/22', 'cca-emu', '2025/2', 24, 0, 0, 10, 0, 0, 14, 0, 0, 0, 2, 0, 0, 0, 4, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 22],
['2/23-3/1', 'cca-emu', '2025/2', 32, 0, 0, 0, 0, 0, 20, 0, 0, 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6],
['2/23-3/1', 'cca-emu', '2025/3', 32, 0, 0, 0, 0, 0, 20, 0, 0, 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6],
['3/2-3/8', 'cca-emu', '2025/3', 22, 0, 0, 0, 0, 0, 4, 34, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4],
['3/9-3/15', 'cca-emu', '2025/3', 20, 0, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0],
['3/16-3/22', 'cca-emu', '2025/3', 28, 0, 0, 0, 0, 0, 0, 6, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['3/23-3/29', 'cca-emu', '2025/3', 46, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0],
['3/30-4/5', 'cca-emu', '2025/3', 56, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 6, 0, 0, 0, 0],
['3/30-4/5', 'cca-emu', '2025/4', 56, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 6, 0, 0, 0, 0],
['4/6-4/12', 'cca-emu', '2025/4', 36, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8],
['4/13-4/19', 'cca-emu', '2025/4', 30, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 10],
['4/20-4/26', 'cca-emu', '2025/4', 34, 0, 0, 0, 0, 0, 0, 16, 0, 0, 90, 0, 0, 0, 2, 0, 6, 0, 2, 0, 2, 0, 0, 0, 2, 0, 0, 12],
['4/27-5/3', 'cca-emu', '2025/4', 16, 0, 18, 0, 0, 0, 0, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 6],
['4/27-5/3', 'cca-emu', '2025/5', 16, 0, 18, 0, 0, 0, 0, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 6],
['5/4-5/10', 'cca-emu', '2025/5', 40, 24, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 4, 8],
['5/11-5/17', 'cca-emu', '2025/5', 6, 0, 2, 0, 0, 0, 2, 0, 0, 0, 58, 0, 0, 8, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0],
['5/18-5/24', 'cca-emu', '2025/5', 34, 0, 6, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 6, 0],
['5/25-5/28', 'cca-emu', '2025/5', 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 4],
['2/1-2/1', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['2/2-2/8', 'ccd-emu', '2025/2', 10, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 8, 0, 0, 4, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 6, 0],
['2/9-2/15', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['2/16-2/22', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'ccd-emu', '2025/2', 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 2, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2],
['2/23-3/1', 'ccd-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 2, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2],
['3/2-3/8', 'ccd-emu', '2025/3', 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0],
['3/9-3/15', 'ccd-emu', '2025/3', 48, 22, 0, 0, 0, 0, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 4, 4],
['3/16-3/22', 'ccd-emu', '2025/3', 20, 56, 0, 0, 0, 0, 0, 18, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 8, 4, 0, 0, 0, 0, 0, 0, 0],
['3/23-3/29', 'ccd-emu', '2025/3', 4, 70, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 12, 0, 0, 0, 20, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'ccd-emu', '2025/3', 18, 50, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 10, 0, 4, 2, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'ccd-emu', '2025/4', 18, 50, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 10, 0, 4, 2, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0],
['4/6-4/12', 'ccd-emu', '2025/4', 0, 28, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 2, 0, 18, 0, 0, 0, 24, 0, 0, 2, 0, 0, 0, 6],
['4/13-4/19', 'ccd-emu', '2025/4', 0, 32, 0, 0, 0, 0, 0, 6, 0, 0, 8, 0, 0, 0, 0, 0, 40, 0, 0, 0, 18, 0, 0, 0, 0, 0, 4, 0],
['4/20-4/26', 'ccd-emu', '2025/4', 0, 56, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0],
['4/27-5/3', 'ccd-emu', '2025/4', 6, 66, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 4, 8, 0, 0, 6, 0, 0, 0, 0],
['4/27-5/3', 'ccd-emu', '2025/5', 6, 66, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 4, 8, 0, 0, 6, 0, 0, 0, 0],
['5/4-5/10', 'ccd-emu', '2025/5', 18, 24, 6, 0, 0, 0, 0, 14, 0, 0, 26, 0, 0, 2, 10, 0, 52, 0, 0, 2, 4, 0, 0, 0, 0, 0, 0, 0],
['5/11-5/17', 'ccd-emu', '2025/5', 8, 68, 10, 0, 0, 0, 10, 0, 0, 0, 14, 0, 0, 4, 6, 20, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0],
['5/18-5/24', 'ccd-emu', '2025/5', 20, 74, 14, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 8, 0, 0, 0, 0, 0, 6, 8],
['5/25-5/28', 'ccd-emu', '2025/5', 2, 52, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0],
['2/1-2/1', 'cch-emu', '2025/2', 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['2/2-2/8', 'cch-emu', '2025/2', 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 112, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0],
['2/9-2/15', 'cch-emu', '2025/2', 14, 0, 0, 0, 0, 0, 0, 32, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['2/16-2/22', 'cch-emu', '2025/2', 6, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0],
['2/23-3/1', 'cch-emu', '2025/2', 6, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['2/23-3/1', 'cch-emu', '2025/3', 6, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 92, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['3/2-3/8', 'cch-emu', '2025/3', 14, 0, 0, 0, 0, 0, 0, 6, 30, 0, 4, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
['3/9-3/15', 'cch-emu', '2025/3', 6, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2, 0, 0, 0, 0, 6],
['3/16-3/22', 'cch-emu', '2025/3', 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 14, 0, 0, 0, 0, 0, 0, 4],
['3/23-3/29', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 10],
['3/30-4/5', 'cch-emu', '2025/3', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 10, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0],
['3/30-4/5', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 10, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0],
['4/6-4/12', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 42, 0, 0, 12, 0, 0, 0, 2, 0, 0, 28],
['4/13-4/19', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0],
['4/20-4/26', 'cch-emu', '2025/4', 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 12, 0, 0, 2],
['4/27-5/3', 'cch-emu', '2025/4', 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 2],
['4/27-5/3', 'cch-emu', '2025/5', 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 2],
['5/4-5/10', 'cch-emu', '2025/5', 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 12, 0, 0, 2, 4, 0, 0, 0, 0, 0, 0, 6],
['5/11-5/17', 'cch-emu', '2025/5', 12, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0],
['5/18-5/24', 'cch-emu', '2025/5', 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 6, 0, 12, 0, 0, 0, 0, 0, 0, 2, 0, 6, 2, 14],
['5/25-5/28', 'cch-emu', '2025/5', 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2]
];
