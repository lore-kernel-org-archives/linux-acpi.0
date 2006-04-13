From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Failed resuming IDE from S3 on Abit NF7 (nForce2)
Date: Thu, 13 Apr 2006 14:18:14 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1222C85@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42136 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964786AbWDMGTH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2006 02:19:07 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org

I'm wondering if http://bugzilla.kernel.org/show_bug.cgi?id=3D5604  is =
related
to your problem. But it would be worthy to try.
http://bugzilla.kernel.org/show_bug.cgi?id=3D5604#c19

--Luming

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org=20
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Andreas Saur
>Sent: 2006=C4=EA4=D4=C213=C8=D5 13:28
>To: linux-acpi@vger.kernel.org
>Subject: Failed resuming IDE from S3 on Abit NF7 (nForce2)
>
>Topic: Failed resuming IDE from S3 on Abit NF7 (nForce2)
>
>Hello all,
>as already reported on bugzilla=20
>(http://bugzilla.kernel.org/show_bug.cgi?id=3D6326) and on this mailin=
g=20
>list=20
>(http://marc.theaimsgroup.com/?l=3Dlinux-acpi&m=3D114461011901806&w=3D=
2),=20
>I've finally made it to get some more or less usefull logs about this=20
>bug. After a accidentally building a kernel with an initrd(*), I was=20
>able to resume from S3, but only until the system didn't=20
>perform a disk=20
>access on IDE. But that was enough to make a dmesg with an interesting=
=20
>entry:
>
>"pnp: Failed to activate device 00:09.", where 00:09 is IDE!
>
>With the first access to IDE the system was instantly frozen.
>
>The only workaround I've found was here:
>    http://lkml.org/lkml/2006/2/21/280
>I've applied the mentioned kernel-patch:
>   =20
>http://www.xenotime.net/linux/SATA/2.6.16-rc3/libata-rollup-261
>6-rc3.patch
>, but it didn't work for me. In the mail was also said, that=20
>there is a=20
>trivial "4-hooks" patch, that also has to be applied, but reading all=20
>the mails I couldn't find this patch.
>
>Doest anybody know something about libata concerning ACPI=20
>problems? Btw.=20
>I've got an "sata_nv" mnodule loaded in the single-user-mode, but my=20
>sata is switched off in BIOS.
>
>Help appreciated! Thanks.
>
>----dmesg---Linux version 2.6.17-rc1-mm2a (root@vulcan) (gcc version=20
>4.0.3 20060304 ------
>PM: Preparing system for mem sleep
>Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D|
>[ACPI Debug]  String: [0x15] "=3D=3D=3D=3D SST Working =3D=3D=3D=3D"
>Suspending device 1.0
>Suspending device ide1
>Suspending device eisa.0
>Suspending device serio1
>Suspending device serio0
>Suspending device i8042
>Suspending device serial8250
>Suspending device pnp1
>Suspending device pcspkr
>Suspending device 00:09
>Suspending device 00:08
>Suspending device 00:07
>Suspending device 00:06
>Suspending device 00:05
>Suspending device 00:04
>Suspending device 00:03
>Suspending device 00:02
>Suspending device 00:01
>Suspending device 00:00
>Suspending device pnp0
>Suspending device 0000:02:00.1
>Suspending device 0000:02:00.0
>Suspending device 0000:00:1e.0
>Suspending device 0000:00:09.0
>Suspending device 0000:00:08.0
>Suspending device 0000:00:04.0
>Suspending device 0000:00:01.1
>Suspending device 0000:00:01.0
>Suspending device 0000:00:00.5
>Suspending device 0000:00:00.4
>Suspending device 0000:00:00.3
>Suspending device 0000:00:00.2
>Suspending device 0000:00:00.1
>Suspending device 0000:00:00.0
>Suspending device pci0000:00
>Suspending device platform
>PM: Entering mem sleep
> hwsleep-0285 [11] enter_sleep_state     : Entering sleep state [S3]
>Back to C!
>PM: Finishing wakeup.
>ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LMAC] -> GSI 11 (level,
>low) -> IRQ 11
>PCI: Setting latency timer of device 0000:00:04.0 to 64
>PCI: Setting latency timer of device 0000:00:08.0 to 64
>pnp: Failed to activate device 00:09.
>Restarting tasks... done
>[ACPI Debug]  String: [0x15] "=3D=3D=3D=3D SST Working =3D=3D=3D=3D"
>ACPI Error (evevent-0314): No installed handler for fixed event
>[00000002] [20060310]
>[ACPI Debug]  String: [0x15] "=3D=3D=3D=3D SST Working =3D=3D=3D=3D"
>
>(*) don't know if initrd is the reason, but I've tried so much, that I=
=20
>don't correctly remember anymore.
>-
>To unsubscribe from this list: send the line "unsubscribe=20
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
