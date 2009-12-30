From: Len Brown <lenb@kernel.org>
Subject: Re: another discrete nvidia switch on/off for an assortment of laptops
Date: Wed, 30 Dec 2009 00:44:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912300027270.15839@localhost.localdomain>
References: <358f4d650912291430u5e266764jd98a814621659c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:42808 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbZL3FpD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 00:45:03 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG001LDAMNV1A0@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 29 Dec 2009 23:44:52 -0600 (CST)
In-reply-to: <358f4d650912291430u5e266764jd98a814621659c1@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Albert Vilella <avilella@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 29 Dec 2009, Albert Vilella wrote:

> Hi again,
> 
> In this occasion not providing a working module, but just a grep to
> show 5 different laptop
> models that use an almost identical ACPI call to report on the
> discrete nvidia graphics switch:
> 
> All DSDT.dsl files are available here:
> https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/312756
> grep -e NVIF *.dsl
> 
> Acer_Aspire_7530G_nv.dsl:                Name (_UID, "NVIF")
> Acer_Aspire_7530G_nv.dsl:                        Return
> (\_SB.PCI0.IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
> Acer_Aspire_7530G_nv.dsl:                    Method (NVIF, 3, NotSerialized)
> Dell_Studio_XPS_13_nv.dsl:                Name (_UID, "NVIF")
> Dell_Studio_XPS_13_nv.dsl:                        Return
> (\_SB.PCI0.IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
> Dell_Studio_XPS_13_nv.dsl:                    Method (NVIF, 3, NotSerialized)
> Elitegroup_GF8100VM_nv.dsl:                            Name (_UID, "NVIF")
> Elitegroup_GF8100VM_nv.dsl:                                    Return
> (^^IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
> Elitegroup_GF8100VM_nv.dsl:                    Method (NVIF, 3, NotSerialized)
> MSI_EX630-034US.dsl:                            Name (_UID, "NVIF")
> MSI_EX630-034US.dsl:                                    Return
> (^^IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
> MSI_EX630-034US.dsl:                    Method (NVIF, 3, NotSerialized)
> MSI_EX630_nv.dsl:                            Name (_UID, "NVIF")
> MSI_EX630_nv.dsl:                                    Return
> (^^IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
> MSI_EX630_nv.dsl:                    Method (NVIF, 3, NotSerialized)
> Toshiba_Qosmio_X305_nv.dsl:                Name (_UID, "NVIF")
> Toshiba_Qosmio_X305_nv.dsl:                        Return
> (\_SB.PCI0.IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
> Toshiba_Qosmio_X305_nv.dsl:                    Method (NVIF, 3, NotSerialized)

There are about 50 DSDTs in that ubuntu feature request.
A sub-set of them include a WMI device
that calls itself "NVIF":

            Device (WMI0)
            {
                Name (_HID, "*pnp0c14")
                Name (_UID, "NVIF")
                Name (_WDG, Buffer (0xC8)
                {

Likely that name is the result of it appearing in some
nvidia reference AML/WMI code someplace; for use with
the associated Windows WMI driver.  Not immediately clear
what the capabilities of that WMI device are...

I happen to have a Sony VGN-Z540 with a stamina/speed switch.
It's BIOS does not supply a WMI device with this name.

-Len Brown
Intel Open Source Technology Center

