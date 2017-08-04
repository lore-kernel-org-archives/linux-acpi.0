From: David Renz <David.Renz@ruhr-uni-bochum.de>
Subject: Corrupted BIOS on an Acer X541UJ compromising Linux
Date: Fri, 04 Aug 2017 09:33:24 +0200
Message-ID: <258b0d0a375dcda1357a49aa8ca47073@ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.mail.ruhr-uni-bochum.de ([134.147.53.149]:39476 "EHLO
        out1.mail.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751864AbdHDHjl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2017 03:39:41 -0400
Received: from mx1.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by out1.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 3xNzDs4D5Vz4y51
        for <linux-acpi@vger.kernel.org>; Fri,  4 Aug 2017 09:33:33 +0200 (CEST)
Received: from mx1.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by mx1.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 3xNzDs3Xdxz4yFk
        for <linux-acpi@vger.kernel.org>; Fri,  4 Aug 2017 09:33:33 +0200 (CEST)
Received: from mail1.mail.ruhr-uni-bochum.de (mail1.mail.ruhr-uni-bochum.de [134.147.42.227])
        by mx1.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTP id 3xNzDs2NhWz4y51
        for <linux-acpi@vger.kernel.org>; Fri,  4 Aug 2017 09:33:33 +0200 (CEST)
Received: from mpx2.rz.ruhr-uni-bochum.de (vmrz0224.rz.ruhr-uni-bochum.de [134.147.64.15])
        by mail1.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 3xNzDj0WtgzyT6
        for <linux-acpi@vger.kernel.org>; Fri,  4 Aug 2017 09:33:25 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

unfortunately my notebook (an Asus R541UJ) is infected by an obviously 
highly-sophisticated firmware-based rootkit, which compromises any Linux 
or Windows system through the execution of its manipulated ACPI code. 
Performing a BIOS flash doesn't override this ACPI code.


When testing the firmware components using FirmwareTestSuiteLive, it 
reports various error messages, most of them related to the ACPI tables:

High failures: 6
klog: HIGH Kernel message: [    0.024112] ACPI Error: [PRT0] Namespace 
lookup failure, AE_ALREADY_EXISTS (20150930/dswload-378)
klog: HIGH Kernel message: [    0.024116] ACPI Exception: 
AE_ALREADY_EXISTS, During name lookup/catalog (20150930/psobject-227)
klog: HIGH Kernel message: [    0.024181] ACPI Exception: 
AE_ALREADY_EXISTS, (SSDT:SataTabl) while loading table 
(20150930/tbxfload-193)
klog: HIGH Kernel message: [    0.036857] ACPI Error: 1 table load 
failures, 8 successful (20150930/tbxfload-214)
klog: HIGH Kernel message: [    3.159686] ACPI Warning: 
\_SB_.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI 
requires [Package] (20150930/nsarguments-95)
klog: HIGH Kernel message: [    3.159739] ACPI Warning: 
\_SB_.PCI0.RP01.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], 
ACPI requires [Package] (20150930/nsarguments-95)

Medium failures: 16
mtrr: Memory range 0xc0000000 to 0xcfffffff (0000:00:02.0) has incorrect 
attribute Uncached.
mtrr: Memory range 0xd0000000 to 0xdfffffff (0000:01:00.0) has incorrect 
attribute Uncached.
mtrr: Memory range 0xe0000000 to 0xe1ffffff (0000:01:00.0) has incorrect 
attribute Uncached.
mtrr: Memory range 0xe2100000 to 0xe2103fff (0000:02:00.2) has incorrect 
attribute Uncached.
method: \_SB_.PCI0.SPI1.FPNT._HID returned a string 'FPNT_DIS' but it 
was not a valid PNP ID or a valid ACPI ID.
method: \_SB_.PCI0.B0D4._TSD should return package of 1 element, got 2 
elements instead.
method: \_SB_.PCI0.B0D4._TSS sub-package 0 element 0was expected to have 
value 1..100, instead was 0.
method: \_SB_.PCI0.B0D4._TSS sub-package 1 element 0was expected to have 
value 1..100, instead was 0.
madt: MADT revision is not in sync with the FADT revision;
MADT 3 expects FADT 6.0 but found 6.1 instead.
fan: Fan present but has no cur_state present.
fadt: FADT first reserved field is not zero: 0x01
fadt: FADT PM1A_EVT_BLK has both a 32-bit and a 64-bit address set; only 
one should be used.
fadt: FADT PM1A_CNT_BLK field has both the 32-bit and the 64-bit field 
set.
fadt: FADT PM2_CNT_BLK field has both the 32-bit and the 64-bit field 
set.
fadt: FADT PM_TMR_BLK field has both the 32-bit and the 64-bit field 
set.
ecdt: Failed to evaluate ECDT UID \_SB.PCI0.LPCB.EC0._UID, cannot check 
UID


I posted the full scan result on pastebin.com:
https://pastebin.com/UbhNCV4n


The execution of this ACPI code leads to the manipulation of any Linux 
system (which I was able to detect by performing a thorough analysis) by 
interfering with the IRQ interrupting and by remapping the memory, which 
is visible in the kernel output of Ubuntu and Alpine Linux e. g.:

[    0.160156] ACPI : EC: EC description table is found, configuring 
boot EC
[    0.160173] ACPI : EC: EC started
[    0.164583] ACPI: Executed 34 blocks of module-level executable AML 
code
[    0.171071] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.176182] ACPI: Dynamic OEM Table Load:
[    0.176188] ACPI: SSDT 0xFFFF880360262000 0006B4 (v02 PmRef  Cpu0Ist  
00003000 INTL 20160422)
[    0.177081] ACPI: Executed 1 blocks of module-level executable AML 
code
[    0.177137] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.178196] ACPI: Dynamic OEM Table Load:
[    0.178201] ACPI: SSDT 0xFFFF88035FD94800 0003FF (v02 PmRef  Cpu0Cst  
00003001 INTL 20160422)
[    0.179077] ACPI: Executed 1 blocks of module-level executable AML 
code
[    0.179373] ACPI: Dynamic OEM Table Load:
[    0.179378] ACPI: SSDT 0xFFFF880360262800 00065C (v02 PmRef  ApIst    
00003000 INTL 20160422)
[    0.180429] ACPI: Executed 1 blocks of module-level executable AML 
code
[    0.180541] ACPI: Dynamic OEM Table Load:
[    0.180544] ACPI: SSDT 0xFFFF88035FD98000 00018A (v02 PmRef  ApCst    
00003000 INTL 20160422)
[    0.181430] ACPI: Executed 1 blocks of module-level executable AML 
code
[    0.182638] ACPI: Interpreter enabled
[    0.182668] ACPI: (supports S0 S3 S4 S5)
[    0.182669] ACPI: Using IOAPIC for interrupt routing
[    0.182699] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug


[    9.844078] WARNING: CPU: 3 PID: 2049 at 
/home/buildozer/aports/main/linux-hardened/src/linux-4.9/kernel/memremap.c:85 
memremap+0x7d/0x1b2
[    9.844081] memremap attempted on mixed range 0x0000000000000000 
size: 0x0
[    9.844083] Modules linked in: joydev hid_multitouch snd_soc_skl(+) 
snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core 
snd_soc_sst_match snd_soc_core snd_compress i2c_designware_platform 
snd_hda_core i2c_designware_core snd_pcm snd_timer snd soundcore idma64 
virt_dma iTCO_wdt intel_lpss_pci iTCO_vendor_support mei_me mei 
intel_pch_thermal i2c_i801 fbcon i2c_smbus bitblit shpchp fbcon_rotate 
fbcon_ccw fbcon_ud fbcon_cw softcursor font tileblit i915 intel_gtt 
processor_thermal_device intel_soc_dts_iosf arc4 rtl8723be btcoexist 
rtl8723_common rtl_pci rtlwifi mac80211 cfg80211 r8169 mii nouveau ttm 
drm_kms_helper asus_nb_wmi asus_wmi drm sparse_keymap hwmon mxm_wmi 
agpgart i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt 
input_leds mousedev wmi battery tpm_crb video thermal button
[    9.844159]  tpm_tis tpm_tis_core tpm pinctrl_sunrisepoint 
pinctrl_intel intel_lpss_acpi intel_lpss int3403_thermal 
int340x_thermal_zone int3400_thermal acpi_thermal_rel hci_uart btbcm 
btqca btintel bluetooth rfkill fjes i2c_hid evdev i2c_core asus_wireless 
ac isofs uas ext4 crc16 jbd2 mbcache nls_utf8 nls_cp437 vfat fat 
hid_generic usbhid hid rtsx_pci_sdmmc mmc_core sr_mod cdrom crc32_pclmul 
crc32c_intel rtsx_pci mfd_core ahci libahci libata xhci_pci xhci_hcd 
usb_storage sd_mod scsi_mod squashfs lz4_decompress loop
[    9.844219] CPU: 3 PID: 2049 Comm: modprobe Not tainted 
4.9.32-0-hardened #1-Alpine
[    9.844221] Hardware name: ASUSTeK COMPUTER INC. X541UJ/X541UJ, BIOS 
X541UJ.302 03/30/2017
[    9.844225]  ffffc9000310fa00 ffffffff813034ae ffffffff81119d37 
9efedbfba3eec2b0
[    9.844231]  ffffc9000310fa50 ffffffff81957ef9 ffffc9000310fa40 
ffffffff8107b854
[    9.844236]  000000550310fac0 0000000000000001 0000000000000000 
0000000000000002
[    9.844242] Call Trace:
[    9.844250]  [<ffffffff813034ae>] dump_stack+0xaf/0x111
[    9.844256]  [<ffffffff81119d37>] ? print_modules+0xd2/0x109
[    9.844262]  [<ffffffff8107b854>] __warn+0x129/0x17c
[    9.844300]  [<ffffffffa12b9b80>] ? skl_ids+0x40/0x80 [snd_soc_skl]
[    9.844306]  [<ffffffff8107b909>] warn_slowpath_fmt+0x62/0x9c
[    9.844311]  [<ffffffff813cf655>] ? acpi_ns_get_node+0x6f/0x98
[    9.844315]  [<ffffffff81082493>] ? region_intersects+0x32/0x114
[    9.844320]  [<ffffffff8115be59>] memremap+0x7d/0x1b2
[    9.844354]  [<ffffffffa12b505a>] skl_nhlt_init+0xbd/0x135 
[snd_soc_skl]
[    9.844381]  [<ffffffffa12b20f5>] ? skl_enable_miscbdcge+0x32/0x52 
[snd_soc_skl]
[    9.844406]  [<ffffffffa12b2e79>] skl_probe+0x598/0xab2 [snd_soc_skl]
[    9.844433]  [<ffffffffa12b9b80>] ? skl_ids+0x40/0x80 [snd_soc_skl]
[    9.844439]  [<ffffffff8135eabc>] pci_device_probe+0xe3/0x1a0
[    9.844444]  [<ffffffff8147b5a0>] driver_probe_device+0x1df/0x4a5
[    9.844448]  [<ffffffff8147b93a>] __driver_attach+0xd4/0x134
[    9.844452]  [<ffffffff8147b866>] ? driver_probe_device+0x4a5/0x4a5
[    9.844458]  [<ffffffff81478429>] bus_for_each_dev+0xbc/0x127
[    9.844461]  [<ffffffff8147ac53>] driver_attach+0x26/0x46
[    9.844464]  [<ffffffff8147a460>] bus_add_driver+0x151/0x303
[    9.844468]  [<ffffffff8147c85f>] driver_register+0xb7/0x133
[    9.844491]  [<ffffffffa12be008>] ? skl_tplg_widget_ops+0x3f08/0x3f08 
[snd_soc_skl]
[    9.844496]  [<ffffffff8135c52f>] __pci_register_driver+0x6f/0xa3
[    9.844518]  [<ffffffffa12be033>] skl_driver_init+0x2b/0x10ee0 
[snd_soc_skl]
[    9.844522]  [<ffffffff810022f2>] do_one_initcall+0x11e/0x1e8
[    9.844527]  [<ffffffff8115cc83>] do_init_module+0x8d/0x30f
[    9.844532]  [<ffffffff81118bd7>] load_module+0x2576/0x2b81
[    9.844552]  [<ffffffffa12be050>] ? skl_driver_init+0x48/0x10ee0 
[snd_soc_skl]
[    9.844557]  [<ffffffff81114902>] ? show_coresize+0x52/0x52
[    9.844563]  [<ffffffff811194cb>] sys_finit_module+0xc8/0x107
[    9.844566]  [<ffffffff811194cb>] ? sys_finit_module+0xc8/0x107
[    9.844571]  [<ffffffff81119520>] rap_sys_finit_module+0x16/0x36
[    9.844577]  [<ffffffff8166d78e>] 
entry_SYSCALL_64_fastpath+0x31/0xe5[/code]


I was able to verify the manipulations of any Linux distro using tools 
from the Volatility framework, but even chkroot is able to discover 
rootkit activity, e. g. it reports:
"wlp3s0: PACKET SNIFFER(/sbin/wpa_supplicant[1035], 
/sbin/wpa_supplicant[1035], /sbin/dhclient[4947])"


wpa_supplicant is a binary actually, but when taking a look at the 
readable strings it contains (and searching for these) one can easily 
understand why chkrootkit classified it as a "PACKET SNIFFER":

dot11RSNAPreauthenticationImplemented=%s
dot11RSNAEnabled=%s
dot11RSNAPreauthenticationEnabled=%s
dot11RSNAConfigVersion=%u
dot11RSNAConfigPairwiseKeysSupported=9999
dot11RSNAConfigGroupRekeyStrict=%u
dot11RSNAConfigGroupUpdateCount=%u
dot11RSNAConfigPairwiseUpdateCount=%u
dot11RSNAConfigGroupCipherSize=%u
dot11RSNAConfigPMKLifetime=%u
dot11RSNAConfigPMKReauthThreshold=%u
dot11RSNAConfigNumberOfPTKSAReplayCounters=0
dot11RSNAConfigSATimeout=%u
dot11RSNAAuthenticationSuiteSelected=%02x-%02x-%02x-%d
dot11RSNAPairwiseCipherSelected=%02x-%02x-%02x-%d
dot11RSNAGroupCipherSelected=%02x-%02x-%02x-%d
dot11RSNAPMKIDUsed=%s
dot11RSNAAuthenticationSuiteRequested=%02x-%02x-%02x-%d
dot11RSNAPairwiseCipherRequested=%02x-%02x-%02x-%d
dot11RSNAGroupCipherRequested=%02x-%02x-%02x-%d
dot11RSNATKIPCounterMeasuresInvoked=%u
dot11RSNA4WayHandshakeFailures=%u
dot11RSNAConfigNumberOfGTKSAReplayCounters=0
dot11RSNAStatsSTAAddress=%02x:%02x:%02x:%02x:%02x:%02x
dot11RSNAStatsVersion=1
dot11RSNAStatsSelectedPairwiseCipher=%02x-%02x-%02x-%d
dot11RSNAStatsTKIPLocalMICFailures=%u
dot11RSNAStatsTKIPRemoteMICFailures=%u
hostapdWPAPTKState=%d
hostapdWPAPTKGroupState=%d

[I didn't download anything before performing the check.]


I uploaded some more results of the analysis I carried through so far on 
Google Drive, where one can also find the extracted and disassembled 
ACPI tables of my system:
https://drive.google.com/open?id=0B62Y5Qk_rdbWdlBMc0pOUEJMUjA


Is there anyone, who could take a closer look at how this works in 
detail by analyzing the disassembled ACPI tables (I can also post them 
on pastebin.com if someone doesn't want to open the link to my shared 
Google Drive folder, or someone who could forward this issue to an ACPI 
developer at Intel e.g.?


Thanks in advance and kind regards

David Renz
