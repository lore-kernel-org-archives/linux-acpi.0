From: Petr Vandrovec <petr@vmware.com>
Subject: [PATCH] pnpacpi: Call acpi_register_gsi for possible resources too
Date: Tue, 3 Jan 2012 00:07:15 -0800
Message-ID: <20120103080715.GA26099@petr-dev3.eng.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:59399 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985Ab2ACIHQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jan 2012 03:07:16 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
  while extending our platform to allow for non-ISA interrupts on
serial ports I've found that after boot-up device is properly enabled
at I/O base 0x500, and assigned IRQ 16, but IRQ 16 is not listed in
/proc/interrupts, and attempts to open serial port (/dev/ttyS4) fail
with EIO error.  After system is soft-rebooted, kernel finds that
device is already enabled (because we do not reprogram device configuration
on soft reboot), reuses base 0x500 and IRQ 16, and /dev/ttyS4 works.

  Inspection of pnpacpi revealed that nobody will call acpi_register_gsi
if device is disabled when discovered by the kernel, but kernel will
then happilly try to assign IRQ 16-23 to the device - and if interrupt
happens to be not used by any other (PCI) device, nobody will call
acpi_register_gsi, and register_irq(16) from serial port driver will
fail :-(

  Diff below fixes issue - with patch serial ports work even immediately
after hard reboot.  Resources for the port as reported by the kernel
are in the attachment - allocated resources were decided by the kernel,
possible are reported by the ACPI's _PRS.

  I have no system which would use non 1:1 mapping for GSI<->IRQ
(except 0/2 which is already blacklisted in pnpacpi), so I have no
idea whether adding it to non-extended IRQ descriptor handling breaks
something somewhere or not.  But given that translation happens
in _CRS it seems more correct to me to do acpi_register_gsi always.

There are two more problems I've discovered during testing:

1. I had to restrict I/O base to 0x500-0xBF8 (from original
0x100-0xFFFF), as otherwise kernel happilly enables one of serial ports
at 0x170, although IDE already occupied that port - it seems that resources
occupied by IDE are reported only after libata loads, and as libata loads
after serial port driver, pnpacpi does not seem to notice that 0x170 is
in use, rather than available for allocation, enables device there,
and then system gets very confused.

2. pnpacpi lacks support for both hot-add and hot-remove.  So serial
ports cannot be neither added nor removed while system runs.  I guess
that's the next task.

					Thanks,
						Petr Vandrovec



From: Petr Vandrovec <petr@vmware.com>

Convert interrupt numbers from GSI to IRQ for _PRS

pnpacpi calls acpi_register_gsi only when interrupt resource is read
via _CRS method - either when device is discovered (if it was already
enabled when pnpacpi initializes), or when someone calls 'get' method
on the device.  What is missing from this list is invoking acpi_register_gsi
when someone issues _SRS method to enable device.  And if nobody
issues acpi_register_gsi, then device may not work if it is only device
using GSI selected by the kernel.

As whole kernel thinks in terms of IRQs, rather than GSIs, it seems that
correct place where to call acpi_register_gsi is when possible resources
are retrieved from _PRS, rather than just before _SRS invocation, so
that is what I did.

I've enabled checking to make sure we are not selecting mismatching
level/edge configuration (with dev_warn, same way _CRS warns).  But it
may be too noisy, as on almost all systems I could check we get warnings
that IRQ 9 is used by ACPI as level/low, while resource descriptors
list it as edge/high (together with other IRQs in 3-15 range).

Signed-off-by: Petr Vandrovec <petr@vmware.com>

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 5be4a39..3243bf4 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -518,6 +518,47 @@ static __init void pnpacpi_parse_dma_option(struct pnp_dev *dev,
 	pnp_register_dma_resource(dev, option_flags, map, flags);
 }
 
+static __init void pnpacpi_gsi_option_to_irq(struct pnp_dev *dev,
+					     pnp_irq_mask_t *map,
+					     u32 gsi,
+					     int triggering,
+					     int polarity)
+{
+	int p, t;
+	int irq;
+
+	/* GSI 0 is ignored. */
+	if (!gsi)
+		return;
+
+	/*
+	 * In IO-APIC mode, accept interrupt only if its trigger/polarity
+	 * matches with one already selected.
+	 */
+	if (!acpi_get_override_irq(gsi, &t, &p)) {
+		t = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		p = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
+		if (triggering != t || polarity != p) {
+			dev_warn(&dev->dev, "IRQ %d status %s, %s does not match override %s, %s\n",
+				 gsi, triggering ? "edge" : "level",
+				 polarity ? "low" : "high",
+				 t ? "edge":"level", p ? "low":"high");
+			return;
+		}
+	}
+	irq = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
+	if (irq < 0)
+		dev_err(&dev->dev, "ignoring IRQ %d option "
+				   "(cannot be mapped to platform IRQ)\n",
+				   gsi);
+	else if (irq < PNP_IRQ_NR)
+		__set_bit(irq, map->bits);
+	else
+		dev_err(&dev->dev, "ignoring IRQ %d (GSI %d) option "
+				   "(too large for %d entry bitmap)\n",
+				   irq, gsi, PNP_IRQ_NR);
+}
+					    
 static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 					    unsigned int option_flags,
 					    struct acpi_resource_irq *p)
@@ -528,8 +569,8 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 
 	bitmap_zero(map.bits, PNP_IRQ_NR);
 	for (i = 0; i < p->interrupt_count; i++)
-		if (p->interrupts[i])
-			__set_bit(p->interrupts[i], map.bits);
+		pnpacpi_gsi_option_to_irq(dev, &map, p->interrupts[i],
+					  p->triggering, p->polarity);
 
 	flags = irq_flags(p->triggering, p->polarity, p->sharable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
@@ -544,16 +585,9 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 	unsigned char flags;
 
 	bitmap_zero(map.bits, PNP_IRQ_NR);
-	for (i = 0; i < p->interrupt_count; i++) {
-		if (p->interrupts[i]) {
-			if (p->interrupts[i] < PNP_IRQ_NR)
-				__set_bit(p->interrupts[i], map.bits);
-			else
-				dev_err(&dev->dev, "ignoring IRQ %d option "
-					"(too large for %d entry bitmap)\n",
-					p->interrupts[i], PNP_IRQ_NR);
-		}
-	}
+	for (i = 0; i < p->interrupt_count; i++)
+		pnpacpi_gsi_option_to_irq(dev, &map, p->interrupts[i],
+					  p->triggering, p->polarity);
 
 	flags = irq_flags(p->triggering, p->polarity, p->sharable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="comport.txt"

00:0b PNP0501 16550A-compatible serial port
    state = active
    allocated resources:
	io 0x500-0x507
	irq 16
    possible resources:
	Dependent: 00 - Priority acceptable
	  port 0x500-0xbf8, align 0x7, size 0x8, 16-bit address decoding
	  irq 16,17,18,19,20,21,22,23 Low-Level
	Dependent: 01 - Priority functional
	  port 0xd00-0x4558, align 0x7, size 0x8, 16-bit address decoding
	  irq 16,17,18,19,20,21,22,23 Low-Level
	Dependent: 02 - Priority functional
	  port 0x5680-0xfdf8, align 0x7, size 0x8, 16-bit address decoding
	  irq 16,17,18,19,20,21,22,23 Low-Level
	Dependent: 03 - Priority acceptable
	  port 0x500-0xbf8, align 0x7, size 0x8, 16-bit address decoding
	  irq 3,4,5,6,7,10,11,12,14,15 High-Edge
	Dependent: 04 - Priority functional
	  port 0xd00-0x4558, align 0x7, size 0x8, 16-bit address decoding
	  irq 3,4,5,6,7,10,11,12,14,15 High-Edge
	Dependent: 05 - Priority functional
	  port 0x5680-0xfdf8, align 0x7, size 0x8, 16-bit address decoding
	  irq 3,4,5,6,7,10,11,12,14,15 High-Edge

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

[    3.203174] pnp 00:09: [io  0x03e8-0x03ef]
[    3.203407] pnp 00:09: [irq 4]
[    3.203443] pnp 00:09: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.203620] pnp 00:0a: [io  0x02e8-0x02ef]
[    3.203852] pnp 00:0a: [irq 3]
[    3.203886] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.204098] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204169] pnp 00:0c: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204268] pnp 00:0d: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204366] pnp 00:0e: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204437] pnp 00:0f: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204535] pnp 00:10: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204606] pnp 00:11: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204675] pnp 00:12: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204774] pnp 00:13: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.204875] pnp 00:14: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205147] pnp 00:15: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205247] pnp 00:16: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205319] pnp 00:17: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205390] pnp 00:18: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205490] pnp 00:19: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205562] pnp 00:1a: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205689] pnp 00:1b: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205762] pnp 00:1c: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205834] pnp 00:1d: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.205934] pnp 00:1e: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206018] pnp 00:1f: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206091] pnp 00:20: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206193] pnp 00:21: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206306] pnp 00:22: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206412] pnp 00:23: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206487] pnp 00:24: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206561] pnp 00:25: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.206741] pnp 00:26: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    3.218505] pnp 00:27: [io  0x0378-0x037f]
[    3.218522] pnp 00:27: [irq 7]
[    3.221718] pnp 00:27: Plug and Play ACPI device, IDs PNP0400 (active)
[    3.232376] pnp 00:28: [io  0x03f8-0x03ff]
[    3.232378] pnp 00:28: [irq 4]
[    3.235096] pnp 00:28: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.243778] pnp 00:29: [io  0x02f8-0x02ff]
[    3.243781] pnp 00:29: [irq 3]
[    3.246648] pnp 00:29: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.260120] pnp 00:2a: [io  0x03f0-0x03f5]
[    3.260122] pnp 00:2a: [io  0x03f7]
[    3.260177] pnp 00:2a: [irq 6]
[    3.260179] pnp 00:2a: [dma 2]
[    3.262958] pnp 00:2a: Plug and Play ACPI device, IDs PNP0700 (active)
[    3.263213] pnp 00:2b: [mem 0xe0000000-0xefffffff]
[    3.263216] pnp 00:2b: [io  0x1060-0x107f]
[    3.263217] pnp 00:2b: [mem 0xd0200000-0xd03fffff]
[    3.263319] system 00:2b: [io  0x1060-0x107f] has been reserved
[    3.263574] system 00:2b: [mem 0xe0000000-0xefffffff] has been reserved
[    3.263832] system 00:2b: [mem 0xd0200000-0xd03fffff] has been reserved
[    3.264142] system 00:2b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.364026] pnp: PnP ACPI: found 44 devices
[    3.364286] ACPI: ACPI bus type pnp unregistered
...
[    3.760590] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.796769] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.834878] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    3.870887] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    3.907029] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[    4.055106] 00:09: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    4.091062] 00:0a: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[    4.091500] serial 00:0b: [io  0x0500-0x0507]
[    4.091502] serial 00:0b: [irq 16]
[    4.093172] serial 00:0b: activated
[    4.129193] 00:0b: ttyS4 at I/O 0x500 (irq = 16) is a 16550A
[    4.131560] serial 00:0c: [io  0x0508-0x050f]
[    4.131564] serial 00:0c: [irq 16]
[    4.134258] serial 00:0c: activated
[    4.171465] 00:0c: ttyS5 at I/O 0x508 (irq = 16) is a 16550A
[    4.171863] serial 00:0d: [io  0x0510-0x0517]
[    4.171866] serial 00:0d: [irq 16]
[    4.172874] serial 00:0d: activated
[    4.208069] 00:0d: ttyS6 at I/O 0x510 (irq = 16) is a 16550A
[    4.211506] serial 00:0e: [io  0x0518-0x051f]
[    4.211509] serial 00:0e: [irq 16]
[    4.212381] serial 00:0e: activated
[    4.247520] 00:0e: ttyS7 at I/O 0x518 (irq = 16) is a 16550A
[    4.251484] serial 00:0f: [io  0x0520-0x0527]
[    4.251487] serial 00:0f: [irq 16]
[    4.252861] serial 00:0f: activated
[    4.288562] 00:0f: ttyS8 at I/O 0x520 (irq = 16) is a 16550A
[    4.291464] serial 00:10: [io  0x0528-0x052f]
[    4.291468] serial 00:10: [irq 16]
[    4.292372] serial 00:10: activated
[    4.328276] 00:10: ttyS9 at I/O 0x528 (irq = 16) is a 16550A
[    4.331437] serial 00:11: [io  0x0530-0x0537]
[    4.331440] serial 00:11: [irq 16]
[    4.332872] serial 00:11: activated
[    4.368472] 00:11: ttyS10 at I/O 0x530 (irq = 16) is a 16550A
[    4.371417] serial 00:12: [io  0x0538-0x053f]
[    4.371421] serial 00:12: [irq 16]
[    4.372341] serial 00:12: activated
[    4.407535] 00:12: ttyS11 at I/O 0x538 (irq = 16) is a 16550A
[    4.411396] serial 00:13: [io  0x0540-0x0547]
[    4.411399] serial 00:13: [irq 16]
[    4.412450] serial 00:13: activated
[    4.447610] 00:13: ttyS12 at I/O 0x540 (irq = 16) is a 16550A
[    4.451374] serial 00:14: [io  0x0548-0x054f]
[    4.451377] serial 00:14: [irq 16]
[    4.452862] serial 00:14: activated
[    4.488531] 00:14: ttyS13 at I/O 0x548 (irq = 16) is a 16550A
[    4.488870] serial 00:15: [io  0x0550-0x0557]
[    4.488872] serial 00:15: [irq 16]
[    4.489764] serial 00:15: activated
[    4.524757] 00:15: ttyS14 at I/O 0x550 (irq = 16) is a 16550A
[    4.527308] serial 00:16: [io  0x0558-0x055f]
[    4.527317] serial 00:16: [irq 16]
[    4.528355] serial 00:16: activated
[    4.563582] 00:16: ttyS15 at I/O 0x558 (irq = 16) is a 16550A
[    4.567290] serial 00:17: [io  0x0560-0x0567]
[    4.567293] serial 00:17: [irq 16]
[    4.568244] serial 00:17: activated
[    4.603384] 00:17: ttyS16 at I/O 0x560 (irq = 16) is a 16550A
[    4.607265] serial 00:18: [io  0x0568-0x056f]
[    4.607269] serial 00:18: [irq 16]
[    4.608248] serial 00:18: activated
[    4.643357] 00:18: ttyS17 at I/O 0x568 (irq = 16) is a 16550A
[    4.647248] serial 00:19: [io  0x0570-0x0577]
[    4.647251] serial 00:19: [irq 16]
[    4.648232] serial 00:19: activated
[    4.683824] 00:19: ttyS18 at I/O 0x570 (irq = 16) is a 16550A
[    4.687226] serial 00:1a: [io  0x0578-0x057f]
[    4.687229] serial 00:1a: [irq 16]
[    4.688242] serial 00:1a: activated
[    4.723181] 00:1a: ttyS19 at I/O 0x578 (irq = 16) is a 16550A
[    4.727204] serial 00:1b: [io  0x0580-0x0587]
[    4.727207] serial 00:1b: [irq 16]
[    4.728205] serial 00:1b: activated
[    4.763833] 00:1b: ttyS20 at I/O 0x580 (irq = 16) is a 16550A
[    4.767182] serial 00:1c: [io  0x0588-0x058f]
[    4.767185] serial 00:1c: [irq 16]
[    4.768285] serial 00:1c: activated
[    4.804636] 00:1c: ttyS21 at I/O 0x588 (irq = 16) is a 16550A
[    4.807171] serial 00:1d: [io  0x0590-0x0597]
[    4.807175] serial 00:1d: [irq 16]
[    4.808155] serial 00:1d: activated
[    4.844006] 00:1d: ttyS22 at I/O 0x590 (irq = 16) is a 16550A
[    4.847158] serial 00:1e: [io  0x0598-0x059f]
[    4.847162] serial 00:1e: [irq 16]
[    4.848172] serial 00:1e: activated
[    4.883544] 00:1e: ttyS23 at I/O 0x598 (irq = 16) is a 16550A
[    4.887160] serial 00:1f: [io  0x05a0-0x05a7]
[    4.887163] serial 00:1f: [irq 16]
[    4.888167] serial 00:1f: activated
[    4.923172] 00:1f: ttyS24 at I/O 0x5a0 (irq = 16) is a 16550A
[    4.927094] serial 00:20: [io  0x05a8-0x05af]
[    4.927097] serial 00:20: [irq 16]
[    4.928141] serial 00:20: activated
[    4.963413] 00:20: ttyS25 at I/O 0x5a8 (irq = 16) is a 16550A
[    4.967090] serial 00:21: [io  0x05b0-0x05b7]
[    4.967093] serial 00:21: [irq 16]
[    4.968149] serial 00:21: activated
[    5.003849] 00:21: ttyS26 at I/O 0x5b0 (irq = 16) is a 16550A
[    5.007034] serial 00:22: [io  0x05b8-0x05bf]
[    5.007036] serial 00:22: [irq 16]
[    5.008338] serial 00:22: activated
[    5.043447] 00:22: ttyS27 at I/O 0x5b8 (irq = 16) is a 16550A
[    5.047046] serial 00:23: [io  0x05c0-0x05c7]
[    5.047049] serial 00:23: [irq 16]
[    5.048136] serial 00:23: activated
[    5.083139] 00:23: ttyS28 at I/O 0x5c0 (irq = 16) is a 16550A
[    5.087020] serial 00:24: [io  0x05c8-0x05cf]
[    5.087059] serial 00:24: [irq 16]
[    5.088072] serial 00:24: activated
[    5.123729] 00:24: ttyS29 at I/O 0x5c8 (irq = 16) is a 16550A
[    5.127021] serial 00:25: [io  0x05d0-0x05d7]
[    5.127024] serial 00:25: [irq 16]
[    5.128499] serial 00:25: activated
[    5.163772] 00:25: ttyS30 at I/O 0x5d0 (irq = 16) is a 16550A
[    5.167196] serial 00:26: [io  0x05d8-0x05df]
[    5.167198] serial 00:26: [irq 16]
[    5.168223] serial 00:26: activated
[    5.203803] 00:26: ttyS31 at I/O 0x5d8 (irq = 16) is a 16550A
[    5.242964] 00:28: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    5.282406] 00:29: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpiregistergsi.txt"

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 5be4a39..3243bf4 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -518,6 +518,47 @@ static __init void pnpacpi_parse_dma_option(struct pnp_dev *dev,
 	pnp_register_dma_resource(dev, option_flags, map, flags);
 }
 
+static __init void pnpacpi_gsi_option_to_irq(struct pnp_dev *dev,
+					     pnp_irq_mask_t *map,
+					     u32 gsi,
+					     int triggering,
+					     int polarity)
+{
+	int p, t;
+	int irq;
+
+	/* GSI 0 is ignored. */
+	if (!gsi)
+		return;
+
+	/*
+	 * In IO-APIC mode, accept interrupt only if its trigger/polarity
+	 * matches with one already selected.
+	 */
+	if (!acpi_get_override_irq(gsi, &t, &p)) {
+		t = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		p = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
+		if (triggering != t || polarity != p) {
+			dev_warn(&dev->dev, "IRQ %d status %s, %s does not match override %s, %s\n",
+				 gsi, triggering ? "edge" : "level",
+				 polarity ? "low" : "high",
+				 t ? "edge":"level", p ? "low":"high");
+			return;
+		}
+	}
+	irq = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
+	if (irq < 0)
+		dev_err(&dev->dev, "ignoring IRQ %d option "
+				   "(cannot be mapped to platform IRQ)\n",
+				   gsi);
+	else if (irq < PNP_IRQ_NR)
+		__set_bit(irq, map->bits);
+	else
+		dev_err(&dev->dev, "ignoring IRQ %d (GSI %d) option "
+				   "(too large for %d entry bitmap)\n",
+				   irq, gsi, PNP_IRQ_NR);
+}
+					    
 static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 					    unsigned int option_flags,
 					    struct acpi_resource_irq *p)
@@ -528,8 +569,8 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 
 	bitmap_zero(map.bits, PNP_IRQ_NR);
 	for (i = 0; i < p->interrupt_count; i++)
-		if (p->interrupts[i])
-			__set_bit(p->interrupts[i], map.bits);
+		pnpacpi_gsi_option_to_irq(dev, &map, p->interrupts[i],
+					  p->triggering, p->polarity);
 
 	flags = irq_flags(p->triggering, p->polarity, p->sharable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
@@ -544,16 +585,9 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 	unsigned char flags;
 
 	bitmap_zero(map.bits, PNP_IRQ_NR);
-	for (i = 0; i < p->interrupt_count; i++) {
-		if (p->interrupts[i]) {
-			if (p->interrupts[i] < PNP_IRQ_NR)
-				__set_bit(p->interrupts[i], map.bits);
-			else
-				dev_err(&dev->dev, "ignoring IRQ %d option "
-					"(too large for %d entry bitmap)\n",
-					p->interrupts[i], PNP_IRQ_NR);
-		}
-	}
+	for (i = 0; i < p->interrupt_count; i++)
+		pnpacpi_gsi_option_to_irq(dev, &map, p->interrupts[i],
+					  p->triggering, p->polarity);
 
 	flags = irq_flags(p->triggering, p->polarity, p->sharable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);

--ibTvN161/egqYuK8--
