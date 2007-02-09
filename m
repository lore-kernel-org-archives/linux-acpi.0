From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Bad libata resume behaviour due to ACPICA change (in acpi-test)
Date: Fri, 09 Feb 2007 18:10:32 +0300
Message-ID: <45CC8EE8.2080107@linux.intel.com>
References: <20070203004140.GB619@khazad-dum.debian.net> <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411> <20070208153025.GA466@khazad-dum.debian.net> <45CB62EE.8020300@linux.intel.com> <20070209025910.GA12298@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050804080005090704010606"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43195 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946516AbXBIPLD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 10:11:03 -0500
In-Reply-To: <20070209025910.GA12298@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Brown, Len" <len.brown@intel.com>
Cc: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050804080005090704010606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here is the patch

Regards,
    Alex.

Henrique de Moraes Holschuh wrote:
> On Thu, 08 Feb 2007, Alexey Starikovskiy wrote:
>   
>> first thing to check is timing of acpi_hw_disable_all_gpes() at 
>> drivers/acpi/events/evgpe.c:647,
>> printk() around it should be good.
>>     
>
> Done, and the thing is looping like heck, and wasting time:
>
> Feb  9 00:23:44 thorin kernel: Stopping tasks ... done.
> Feb  9 00:23:44 thorin kernel: Suspending console(s)
> Feb  9 00:23:44 thorin kernel: pnp: Device 00:09 disabled.
> Feb  9 00:23:44 thorin kernel: ACPI: PCI interrupt for device 0000:00:1e.2 disabled
> Feb  9 00:23:44 thorin kernel: ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> Feb  9 00:23:44 thorin kernel: ACPI: PCI interrupt for device 0000:00:1d.3 disabled
> Feb  9 00:23:44 thorin kernel: ACPI: PCI interrupt for device 0000:00:1d.2 disabled
> Feb  9 00:23:44 thorin kernel: ACPI: PCI interrupt for device 0000:00:1d.1 disabled
> Feb  9 00:23:44 thorin kernel: ACPI: PCI interrupt for device 0000:00:1d.0 disabled
> Feb  9 00:23:44 thorin kernel:  hwsleep-0315 [03] enter_sleep_state     : Entering sleep state [S3]
> Feb  9 00:23:44 thorin kernel: Intel machine check architecture supported.
> Feb  9 00:23:44 thorin kernel: Intel machine check reporting enabled on CPU#0.
> Feb  9 00:23:44 thorin kernel: Back to C!
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:01.0 at offset 7 (was 20002020, writing 2020)
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1c.0 at offset 7 (was f0, writing 200000f0)
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 17
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 18
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1c.2 to 64
> Feb  9 00:23:44 thorin kernel: PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.0 at offset f (was 100, writing 10b)
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.0 at offset 8 (was 1, writing 1801)
> Feb  9 00:23:44 thorin kernel: usb usb2: root hub lost power or was reset
> Feb  9 00:23:44 thorin kernel: PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 20
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.1 at offset f (was 200, writing 20b)
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.1 at offset 8 (was 1, writing 1821)
> Feb  9 00:23:44 thorin kernel: usb usb3: root hub lost power or was reset
> Feb  9 00:23:44 thorin kernel: PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.2 at offset f (was 300, writing 30b)
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.2 at offset 8 (was 1, writing 1841)
> Feb  9 00:23:44 thorin kernel: usb usb4: root hub lost power or was reset
> Feb  9 00:23:44 thorin kernel: PCI: Enabling device 0000:00:1d.3 (0000 -> 0001)
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.3 at offset f (was 400, writing 40b)
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.3 at offset 8 (was 1, writing 1861)
> Feb  9 00:23:44 thorin kernel: usb usb5: root hub lost power or was reset
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 19
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.7 at offset f (was 400, writing 40b)
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.7 at offset 4 (was 0, writing b0000000)
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1d.7 at offset 1 (was 2900006, writing 2900106)
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 18
> Feb  9 00:23:44 thorin kernel: i810_audio: Primary codec has ID 0
> Feb  9 00:23:44 thorin kernel: ac97_codec: AC97 Audio codec, id: ADS116 (Analog Devices AD1981B)
> Feb  9 00:23:44 thorin kernel: PM: Writing back config space on device 0000:00:1f.2 at offset 1 (was 2b00005, writing 2b80005)
> Feb  9 00:23:44 thorin kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
> Feb  9 00:23:44 thorin kernel: ACPI: PCI Interrupt 0000:0b:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> Feb  9 00:23:44 thorin kernel: pnp: Device 00:07 does not support activation.
> Feb  9 00:23:44 thorin kernel: pnp: Device 00:08 does not support activation.
> Feb  9 00:23:44 thorin kernel: pnp: Device 00:09 activated.
> Feb  9 00:23:44 thorin kernel: ata2.00: configured for UDMA/33
> Feb  9 00:23:44 thorin kernel: ata1.00: configured for UDMA/100
> Feb  9 00:23:44 thorin kernel: SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
> Feb  9 00:23:44 thorin kernel: sda: Write Protect is off
> Feb  9 00:23:44 thorin kernel: sda: Mode Sense: 00 3a 00 00
> Feb  9 00:23:44 thorin kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Feb  9 00:23:44 thorin kernel: Restarting tasks ... done.
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:44 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:45 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:45 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:46 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:46 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:47 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:47 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:48 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:48 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:49 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:49 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:49 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:49 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:50 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:50 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:51 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:51 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:52 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:52 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:52 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:52 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:53 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:53 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:53 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:53 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:54 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:54 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:55 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:55 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:55 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:55 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:56 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:56 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:57 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:57 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:57 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:57 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:58 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:58 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:23:59 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:23:59 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:24:00 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:24:00 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:24:00 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:24:00 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:24:01 thorin kernel: ACPI-DEBUG: before acpi_hw_disable_all_gpes()
> Feb  9 00:24:01 thorin kernel: ACPI-DEBUG: after acpi_hw_disable_all_gpes()
> Feb  9 00:24:24 thorin kernel: Kernel logging (proc) stopped.
>
>   


--------------050804080005090704010606
Content-Type: text/plain;
 name="fix-disable_all_wake_gpes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-disable_all_wake_gpes.patch"

Disable wake GPEs only once.

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>


---

 drivers/acpi/events/evgpe.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index dfac3ec..263a001 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -644,6 +644,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		 * 1) We must disable this particular wake GPE so it won't fire again
 		 * 2) We want to disable all wake GPEs, since we are now awake
 		 */
+		acpi_gbl_system_awake_and_running = TRUE;
 		(void)acpi_hw_disable_all_gpes();
 	}
 

--------------050804080005090704010606--
