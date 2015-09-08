From: Mike Mestnik <cheako@mikemestnik.net>
Subject: dmi_check_system: null pointer?
Date: Tue, 8 Sep 2015 16:27:33 -0500
Message-ID: <CAF8px54+PuhXEvVkHAHtZCaqVfUywpOUzWsLPtaQMD1y2=DW6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34425 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbIHV1g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2015 17:27:36 -0400
Received: by lbbmp1 with SMTP id mp1so61058817lbb.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2015 14:27:34 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

http://pastebin.com/M3cAxZsG

https://launchpad.net/~cheako/+archive/ubuntu/t300chi/+sourcepub/5375734/+listing-archive-extra

[    4.111798] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000001
[    4.111837] IP: [<ffffffffa04aa020>] 0xffffffffa04aa020
[    4.111866] PGD d9d88067 PUD 0
[    4.111884] Oops: 0002 [#1] SMP
[    4.111902] Modules linked in: nls_utf8 nls_cp437 vfat fat
efi_pstore pcspkr efivars serio_raw uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_core v4l2_common i2c_i801(+) hid_multitouch
videodev media btusb btbcm btintel bluetooth rfkill lpc_ich(+)
mei_me(+) crc16 mfd_core shpchp(+) mei snd_hda_intel(+)
int3403_thermal snd_hda_controller snd_hda_codec snd_hda_core
snd_hwdep snd_pcm battery snd_timer snd dw_dmac soundcore dw_dmac_core
snd_soc_sst_acpi i2c_designware_platform(+) i2c_designware_core
processor_thermal_device int3400_thermal ac int3402_thermal processor
acpi_pad int340x_thermal_zone acpi_thermal_rel evdev inv_mpu6050
industrialio_triggered_buffer kfifo_buf industrialio i2c_mux coretemp
fuse parport_pc ppdev lp parport autofs4 btrfs xor raid6_pq dm_mod sg
sd_mod usbhid uas usb_storage
[    4.112401]  ahci crc32c_intel libahci libata xhci_pci scsi_mod
xhci_hcd i915 usbcore usb_common i2c_algo_bit drm_kms_helper drm fan
thermal wmi video thermal_sys i2c_hid sdhci_acpi hid sdhci mmc_core
button
[    4.112578] CPU: 3 PID: 267 Comm: systemd-udevd Not tainted
4.1.0-1-amd64 #1 Debian 4.1.3-1~2t300chi002
[    4.112615] Hardware name: ASUSTeK COMPUTER INC. T300CHI/T300CHI,
BIOS T300CHI.205 02/12/2015
[    4.112648] task: ffff8800d7a855f0 ti: ffff8800d9d98000 task.ti:
ffff8800d9d98000
[    4.112676] RIP: 0010:[<ffffffffa04aa020>]  [<ffffffffa04aa020>]
0xffffffffa04aa020
[    4.112714] RSP: 0018:ffff8800d9d9b760  EFLAGS: 00010282
[    4.112736] RAX: 0000000000000001 RBX: ffffffffa0396858 RCX: 0000000000000030
[    4.112770] RDX: ffffffffa04aa020 RSI: ffffffffa0396909 RDI: ffffffffa0396858
[    4.112797] RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000000031
[    4.112823] R10: 0000000000000082 R11: 0000000000000006 R12: ffff8800d9d9b7b0
[    4.112851] R13: 0000000000000000 R14: ffff88003564b020 R15: ffff8800d9f7dcc0
[    4.112878] FS:  0000000000000000(0000) GS:ffff88011ed80000(0063)
knlGS:00000000f744f7c0
[    4.112909] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[    4.112931] CR2: 0000000000000001 CR3: 00000000d9d87000 CR4: 00000000003407e0
[    4.112965] Stack:
[    4.112976]  ffffffff814470ac ffff8800d9d9b7b8 ffff8800d9f7d800
ffff88003564b000
[    4.113011]  ffffffffa039591e ffff8801191d5810 ffff8800d9f7dcc0
ffff8800d1d89e50
[    4.113047]  00000000000023be ffff880118abf000 0000000000000000
0000000000000000
[    4.113082] Call Trace:
[    4.113098]  [<ffffffff814470ac>] ? dmi_check_system+0x3c/0x60
[    4.113127]  [<ffffffffa039591e>] ?
inv_mpu_acpi_create_mux_client+0x9e/0x2d0 [inv_mpu6050]
[    4.113183]  [<ffffffffa039510c>] ? inv_mpu_probe+0x3dc/0x430 [inv_mpu6050]
[    4.113213]  [<ffffffffa0394150>] ?
inv_mpu6050_deselect_bypass+0x80/0x80 [inv_mpu6050]
[    4.113262]  [<ffffffffa03940d0>] ?
inv_mpu6050_write_reg_unlocked+0x60/0x60 [inv_mpu6050]
[    4.113323]  [<ffffffffa0394d30>] ?
inv_mpu6050_fifo_rate_store+0x220/0x220 [inv_mpu6050]
[    4.113381]  [<ffffffff81433f29>] ? i2c_device_probe+0xc9/0x140
[    4.113424]  [<ffffffff813fb4fa>] ? driver_sysfs_add+0x7a/0xb0
[    4.113461]  [<ffffffff813fbd51>] ? driver_probe_device+0x201/0x4b0
[    4.113486]  [<ffffffff813fc000>] ? driver_probe_device+0x4b0/0x4b0
[    4.113510]  [<ffffffff813f9b2b>] ? bus_for_each_drv+0x5b/0x90
[    4.115013]  [<ffffffff813fbac8>] ? device_attach+0x98/0xc0
[    4.116639]  [<ffffffff813faeb8>] ? bus_probe_device+0x98/0xd0
[    4.116874] Bluetooth: hci0: Intel Bluetooth firmware patch
completed and activated
[    4.120598]  [<ffffffff813f8bc7>] ? device_add+0x4c7/0x6a0
[    4.122119]  [<ffffffff81437580>] ? i2c_new_device+0x180/0x250
[    4.124129]  [<ffffffff81437b4e>] ? acpi_i2c_add_device+0xfe/0x150
[    4.126757]  [<ffffffff81379a66>] ? acpi_ns_walk_namespace+0xce/0x19e
[    4.126763]  [<ffffffff81437a50>] ? i2c_sysfs_new_device+0x250/0x250
[    4.126766]  [<ffffffff81437a50>] ? i2c_sysfs_new_device+0x250/0x250
[    4.126768]  [<ffffffff81379f5c>] ? acpi_walk_namespace+0x9b/0xcd
[    4.126771]  [<ffffffff81437f5b>] ? i2c_register_adapter+0x3bb/0x4c0
[    4.126782]  [<ffffffffa04e439b>] ? dw_i2c_probe+0x1eb/0x410
[i2c_designware_platform]
[    4.126784]  [<ffffffff8135a6d1>] ? acpi_dev_pm_attach+0x1b/0x83
[    4.126790]  [<ffffffff813fde9d>] ? platform_drv_probe+0x2d/0xa0
[    4.126793]  [<ffffffff81418987>] ? pinctrl_bind_pins+0xb7/0x240
[    4.126797]  [<ffffffff813fbd51>] ? driver_probe_device+0x201/0x4b0
[    4.126799]  [<ffffffff813fc050>] ? __device_attach+0x50/0x50
[    4.126802]  [<ffffffff813fc0db>] ? __driver_attach+0x8b/0x90
[    4.126805]  [<ffffffff813fc050>] ? __device_attach+0x50/0x50
[    4.126806]  [<ffffffff813f9a73>] ? bus_for_each_dev+0x63/0xa0
[    4.126809]  [<ffffffff813fb1f0>] ? bus_add_driver+0x180/0x250
[    4.126821]  [<ffffffffa02bf000>] ? 0xffffffffa02bf000
[    4.126823]  [<ffffffff813fc863>] ? driver_register+0x63/0xf0
[    4.126826]  [<ffffffff81002148>] ? do_one_initcall+0xd8/0x210
[    4.126830]  [<ffffffff8156fbc4>] ? do_init_module+0x5a/0x1c2
[    4.126834]  [<ffffffff810f11c6>] ? load_module+0x1ff6/0x24b0
[    4.126836]  [<ffffffff810ecd40>] ? store_uevent+0x40/0x40
[    4.126842]  [<ffffffff810ed985>] ? copy_module_from_fd.isra.45+0xb5/0x140
[    4.126845]  [<ffffffff810f184d>] ? SyS_finit_module+0x7d/0xa0
[    4.126848]  [<ffffffff81578bd5>] ? sysenter_dispatch+0x7/0x21
[    4.126860] Code: <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00
[    4.126864] RIP  [<ffffffffa04aa020>] 0xffffffffa04aa020
[    4.126865]  RSP <ffff8800d9d9b760>
[    4.126866] CR2: 0000000000000001
[    4.126868] ---[ end trace 09adcbac85a4c7c2 ]---



cheako@debian:~/src/linux-4.1.3$ cat
debian/patches/features/all/iio-imu-inv-mpu-acpi-t300chi.patch
Index: linux-4.1.3/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
===================================================================
--- linux-4.1.3.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ linux-4.1.3/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -23,27 +23,44 @@
 enum inv_mpu_product_name {
        INV_MPU_NOT_MATCHED,
        INV_MPU_ASUS_T100TA,
+       INV_MPU_ASUS_T300CHI,
 };

 static enum inv_mpu_product_name matched_product_name;

-static int __init asus_t100_matched(const struct dmi_system_id *d)
+static int __init asus_t100ta_matched(const struct dmi_system_id *d)
 {
        matched_product_name = INV_MPU_ASUS_T100TA;

        return 0;
 }

+static int __init asus_t300chi_matched(const struct dmi_system_id *d)
+{
+       matched_product_name = INV_MPU_ASUS_T300CHI;
+
+       return 0;
+}
+
 static const struct dmi_system_id inv_mpu_dev_list[] = {
        {
-       .callback = asus_t100_matched,
-       .ident = "Asus Transformer Book T100",
+       .callback = asus_t100ta_matched,
+       .ident = "Asus Transformer Book T100TA",
                .matches = {
                        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC"),
                        DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
                        DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
                },
        },
+       {
+       .callback = asus_t300chi_matched,
+       .ident = "Asus Transformer Book T300CHI",
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC"),
+                       DMI_MATCH(DMI_PRODUCT_NAME, "T300CHI"),
+                       DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
+               },
+       },
        /* Add more matching tables here..*/
        {}
 };
@@ -154,6 +171,7 @@ int inv_mpu_acpi_create_mux_client(struc
                dmi_check_system(inv_mpu_dev_list);
                switch (matched_product_name) {
                case INV_MPU_ASUS_T100TA:
+               case INV_MPU_ASUS_T300CHI:
                        ret = asus_acpi_get_sensor_info(adev, st->client,
                                                        &info);
                        break;
