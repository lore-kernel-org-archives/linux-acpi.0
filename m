From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: linux pnp bug - report
Date: Fri, 30 Apr 2010 22:03:03 -0600
Message-ID: <1272686583.28149.53.camel@dc7800.home>
References: <1269373637.3113.12.camel@goldenfish.development.local>
	 <201003251611.41000.bjorn.helgaas@hp.com>
	 <1269716956.2355.5.camel@goldenfish.development.local>
	 <201004281457.59128.bjorn.helgaas@hp.com>
	 <1272655284.3607.6.camel@goldenfish.development.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:37531 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0EAEE2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 May 2010 00:04:28 -0400
In-Reply-To: <1272655284.3607.6.camel@goldenfish.development.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Kysilka <goldenfish@linuxsoft.cz>
Cc: linux-acpi@vger.kernel.org

Pavel wrote:
> i am playing with old PIII computer (HP Vectra VE) and ISA soundcards.
> Soundcars are PNP(yamaha,opti,ess,...) and no PNP (multisound).
> Machine
> is old, but ACPI compilant - old BIOS.
> 
> Computer booting OK. PNP0 devices allocate resources OK, but PNP1
> devices (one ISA slot) not. PNP soundcard driver is not correctly
> loaded
> - soundcard device not created.

I think this is a regression, i.e., 2.6.33 worked, but 2.6.34-rc6 does
not.  Right?  Even worse, I think it's my fault :-(  If this is a
regression, we should open a bugzilla at http://bugzilla.kernel.org and
assign it to me.

Here's the problem (I think):

  pnp 00:01: parse allocated resources
  pnp 00:01:   add [bus 00-ff flags 0x1000]
  pnp 00:01:   add [io  0x0000-0x0cf7 flags 0x200101]
  pnp 00:01: Plug and Play ACPI device, IDs PNP0a03 (active)

This PNP0a03 PCI host bridge has a window [io  0x0000-0x0cf7] that is
forwarded to the PCI bridge.  This is perfectly normal, but in 2.6.33,
PNPACPI ignored that window, so it didn't appear as a PNP resource of
the bridge.

  cmi8330 01:01.00: pnp_assign_resources, try dependent set 0
  cmi8330 01:01.00: trying to assign [??? 0x00000530-0x00000537 flags 0x40000001]
  cmi8330 01:01.00: check whether [??? 0x00000530-0x00000537 flags 0x40000001] is available
  cmi8330 01:01.00: conflict with 00:01 resource 1 [io  0x0000-0x0cf7 flags 0x200101]
  cmi8330 01:01.00:   couldn't assign io 0 (min 0x530 max 0x530)

Now we come along and try to assign [io  0x0530-0x0537] to the cmi8330
device.  The last piece of pnp_check_port() checks it against all
resources of other PNP devices, including the PNP0a03 host bridge
window.  We should ignore windows, because the bridge doesn't *consume*
that range, it only *forwards* it, so it's still available for devices
to use.

I'd like to rework PNP resource management to make it more similar to
PCI's, or even integrate them somehow.  But we only have time for the
most minimal fix for 2.6.34.  Can you try the patch below, please?

Bjorn


diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 2e54e6a..e3446ab 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -211,6 +211,8 @@ int pnp_check_port(struct pnp_dev *dev, struct resource *res)
 			if (tres->flags & IORESOURCE_IO) {
 				if (cannot_compare(tres->flags))
 					continue;
+				if (tres->flags & IORESOURCE_WINDOW)
+					continue;
 				tport = &tres->start;
 				tend = &tres->end;
 				if (ranged_conflict(port, end, tport, tend))
@@ -271,6 +273,8 @@ int pnp_check_mem(struct pnp_dev *dev, struct resource *res)
 			if (tres->flags & IORESOURCE_MEM) {
 				if (cannot_compare(tres->flags))
 					continue;
+				if (tres->flags & IORESOURCE_WINDOW)
+					continue;
 				taddr = &tres->start;
 				tend = &tres->end;
 				if (ranged_conflict(addr, end, taddr, tend))


