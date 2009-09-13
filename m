From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] sony-laptop: Don't unregister the SPIC driver if it wasn't
 registered
Date: Sun, 13 Sep 2009 10:38:31 +0100
Message-ID: <4AACBD97.6000509@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:40040 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbZIMJia (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Sep 2009 05:38:30 -0400
Received: by ewy2 with SMTP id 2so2186641ewy.17
        for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2009 02:38:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux acpi <linux-acpi@vger.kernel.org>

This fixes a warning when the module is unloaded on machines without SPIC.

------------[ cut here ]------------
WARNING: at drivers/base/driver.c:261 driver_unregister+0x6e/0x80()
Hardware name: OEM
Unexpected driver unregister!
Modules linked in: sony_laptop(-) rfkill af_packet i915
 drm i2c_algo_bit cfbcopyarea i2c_core cfbimgblt cfbfillrect binfmt_misc
 ipv6 kvm_intel kvm acpi_cpufreq cpufreq_userspace cpufreq_powersave
 cpufreq_stats acpi_pad ac video output battery pci_slot sbs sbshc
 container iptable_filter ip_tables x_tables ext2 fuse
 snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm_oss
 snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi_event
 snd_seq snd_timer snd_seq_device snd fan sg serio_raw sr_mod cdrom
 soundcore button thermal processor thermal_sys floppy snd_page_alloc
 pcspkr intel_agp evdev [last unloaded: asus_atk0110]
Pid: 8136, comm: modprobe Not tainted 2.6.31-rc8debug #50
Call Trace:
[<ffffffff8121ec7e>] ? driver_unregister+0x6e/0x80
[<ffffffff81047577>] warn_slowpath_common+0x87/0xb0
[<ffffffff81047624>] warn_slowpath_fmt+0x64/0x70
[<ffffffff8119a360>] ? kobject_release+0x0/0x1f0
[<ffffffff8119a267>] ? kobject_put+0x27/0x60
[<ffffffff8121d346>] ? bus_put+0x16/0x20
[<ffffffff8121d406>] ? bus_remove_driver+0xb6/0xf0
[<ffffffff8121ec7e>] driver_unregister+0x6e/0x80
[<ffffffff811cab50>] acpi_bus_unregister_driver+0x10/0x12
[<ffffffffa035e86c>] sony_laptop_exit+0x2c/0x2e [sony_laptop]
[<ffffffff8107ddc6>] sys_delete_module+0x176/0x230
[<ffffffff8107186d>] ? trace_hardirqs_on_caller+0x14d/0x1a0
[<ffffffff81350a04>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[<ffffffff8100bdab>] system_call_fastpath+0x16/0x1b
---[ end trace f638b6a59b19703e ]---

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/sony-laptop.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index f9f68e0..81538da 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1418,6 +1418,8 @@ static struct sony_pic_dev spic_dev = {
 	.ioports	= LIST_HEAD_INIT(spic_dev.ioports),
 };
 
+static int spic_drv_registered;
+
 /* Event masks */
 #define SONYPI_JOGGER_MASK			0x00000001
 #define SONYPI_CAPTURE_MASK			0x00000002
@@ -2940,6 +2942,7 @@ static int __init sony_laptop_init(void)
 					"Unable to register SPIC driver.");
 			goto out;
 		}
+		spic_drv_registered = 1;
 	}
 
 	result = acpi_bus_register_driver(&sony_nc_driver);
@@ -2951,7 +2954,7 @@ static int __init sony_laptop_init(void)
 	return 0;
 
 out_unregister_pic:
-	if (!no_spic)
+	if (spic_drv_registered)
 		acpi_bus_unregister_driver(&sony_pic_driver);
 out:
 	return result;
@@ -2960,7 +2963,7 @@ out:
 static void __exit sony_laptop_exit(void)
 {
 	acpi_bus_unregister_driver(&sony_nc_driver);
-	if (!no_spic)
+	if (spic_drv_registered)
 		acpi_bus_unregister_driver(&sony_pic_driver);
 }
 
-- 
1.6.3.2



