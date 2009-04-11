From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control
 brightness with hotkeys
Date: Sat, 11 Apr 2009 15:05:55 -0700
Message-ID: <20090411150555.8b13ed18.akpm@linux-foundation.org>
References: <49E10684.5090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53889 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751024AbZDKWIy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Apr 2009 18:08:54 -0400
In-Reply-To: <49E10684.5090101@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Niel Lambrechts <niel.lambrechts@gmail.com>
Cc: "linux.kernel" <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

(cc's added)

On Sat, 11 Apr 2009 23:07:16 +0200 Niel Lambrechts <niel.lambrechts@gmail.com> wrote:

> Hi there,
> 
> With latest git kernel, I'm no longer able to control my Thinkpad (W500)
> brightness, although I can still control the backlight, bluetooth etc.

So 2.6.29 was OK?

> I originally got some errors (below), but I was able to get around them
> by changing /etc/modprobe.d/thinkpad_acpi
> from the (default OPENSUSE)
> options thinkpad_acpi experimental=1 hotkey=enable,0xffffff
> to
> options thinkpad_acpi experimental=1
> 
> Any ideas on how I can regain control over the brightness gas-pedal?
> 
> Niel
> 
> dmesg:
> thinkpad_acpi: ThinkPad ACPI Extras v0.22
> thinkpad_acpi: http://ibm-acpi.sf.net/
> thinkpad_acpi: ThinkPad BIOS 6FET50WW (1.20 ), EC 7VHT12WW-1.01
> thinkpad_acpi: Lenovo ThinkPad W500, model 40622XG
> thinkpad_acpi: radio switch found; radios are enabled
> thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness
> control, supported by the ACPI video driver
> thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
> thinkpad_acpi: procfs hotkey enable/disable: access by process with PID 890
> WARNING: at drivers/platform/x86/thinkpad_acpi.c:2954
> hotkey_enabledisable_warn+0x3e/0x43 [thinkpad_acpi]()
> thinkpad_acpi: hotkey enable/disable functionality has been removed from
> the driver. Hotkeys are always enabled.
> Modules linked in: thinkpad_acpi(+) snd_hda_intel(+) rfkill
> snd_hda_codec rtc_cmos snd_hwdep mac80211 video i2c_i801 rtc_core
> snd_pcm ohci1394 led_class battery ac output snd_timer snd soundcore
> snd_page_alloc e1000e intel_agp button joydev wmi i2c_core sr_mod
> rtc_lib cfg80211 sg ieee1394 iTCO_wdt agpgart cdrom nvram
> iTCO_vendor_support sd_mod ehci_hcd uhci_hcd usbcore ext4 jbd2 crc16 edd
> ext3 mbcache jbd fan ahci libata scsi_mod thermal processor
>  [<f81a3f7c>] hotkey_enabledisable_warn+0x3e/0x43 [thinkpad_acpi]
>  [<f81a5234>] hotkey_write+0x68/0x162 [thinkpad_acpi]
>  [<f7c63f62>] thinkpad_acpi_module_init+0x742/0x839 [thinkpad_acpi]
>  [<f7c63820>] ? thinkpad_acpi_module_init+0x0/0x839 [thinkpad_acpi]
> Registered led device: tpacpi::thinklight
> thinkpad_acpi: Standard ACPI backlight interface available, not loading
> native one.
> 

