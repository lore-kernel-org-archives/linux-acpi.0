From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] PNP: increase number of devices supported per protocol
Date: Thu, 10 Apr 2008 12:15:55 -0600
Message-ID: <200804101215.55507.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:33904 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbYDJSQA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Apr 2008 14:16:00 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adam Belay <ambx1@neo.rr.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Chen, Justin" <justin.chen@hp.com>

Increase the PNP "number of devices" limit.  We currently use an
unsigned char, which limits us to 256 devices per protocol.  This
patch changes that to an unsigned int.

Not all backends can take advantage of this: we limit ISAPNP to 10
devices in isapnp_cfg_begin(), and PNPBIOS is limited to 256 devices
because the BIOS interfaces use a one-byte device node number.

But there is no limit on the number of PNPACPI devices we may have.
Large HP Integrity machines have more than 256, which causes the
current "unsigned char number" to wrap around.  This causes errors
like this:

    pnp: PnP ACPI init
    kobject_add failed for 00:00 with -EEXIST, don't try to register things with the same name in the same directory.

    Call Trace:
     [<a000000100010720>] show_stack+0x40/0xa0
     [<a0000001000107b0>] dump_stack+0x30/0x60
     [<a0000001001dbdf0>] kobject_add+0x290/0x2c0
     [<a0000001002bfd40>] device_add+0x160/0x860
     [<a0000001002c0470>] device_register+0x30/0x60
     [<a00000010026ba70>] __pnp_add_device+0x130/0x180
     [<a00000010026bb70>] pnp_add_device+0xb0/0xe0
     [<a0000001007f2730>] pnpacpi_add_device+0x510/0x5a0
     [<a0000001007f2810>] pnpacpi_add_device_handler+0x50/0x80

This patch increases the limit to fix this PNPACPI problem.  It
should not have any adverse effect on ISAPNP or PNPBIOS because
their limits are still enforced in the backends.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work8/include/linux/pnp.h
===================================================================
--- work8.orig/include/linux/pnp.h	2008-04-04 10:40:37.000000000 -0600
+++ work8/include/linux/pnp.h	2008-04-04 10:41:17.000000000 -0600
@@ -175,7 +175,7 @@
 struct pnp_dev {
 	struct device dev;		/* Driver Model device interface */
 	u64 dma_mask;
-	unsigned char number;		/* used as an index, must be unique */
+	unsigned int number;		/* used as an index, must be unique */
 	int status;
 
 	struct list_head global_list;	/* node in global list of devices */
