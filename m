From: giggz <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 08 Mar 2008 09:56:41 +0100
Message-ID: <fqtkjq$rod$1@ger.gmane.org>
References: <fmaaj5$jsl$1@ger.gmane.org>	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org> <1203347919.6019.79.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:49933 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbYCHJBE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Mar 2008 04:01:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JXuvJ-0006u9-33
	for linux-acpi@vger.kernel.org; Sat, 08 Mar 2008 09:00:57 +0000
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 08 Mar 2008 09:00:57 +0000
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 08 Mar 2008 09:00:57 +0000
In-Reply-To: <1203347919.6019.79.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Thomas Renninger a =C3=A9crit :
[...]
> You can download the latest SUSE live-CD, there acpi debug is compile=
d
> in.

Hi,

I have downloaded the latest SUSE live-CD and booted with it.

> Or you have to compile a kernel yourself and enable CONFIG_ACPI_DEBUG=
=3Dy
> When booted, unload polling ACPI drivers (to not pollute the logs):
> rmmod battery
> rmmod ac
>=20

done

> Increase ACPI debug level:
> echo 0x1F >/sys/module/acpi/parameters/debug_level

done this one.

> (or even: echo 0x21F >/sys/module/acpi/parameters/debug_level)
> then hit the button and you should see some output.
> Interesting e.g. would be if a notification "notify" appears and is s=
ent
> to a vendor specific device.
>=20

In the /var/log/message I get this message when I hit the Fn+F3 button =
:
Mar  8 09:32:25 linux kernel:       ec-0413 [00] ec_gpe_query          =
:
Evaluating _Q0CExecute Method: [\_SB_.PCI0.LPCB.EC0_._Q0C] (Node dfff53=
60)
Mar  8 09:32:25 linux kernel: exregion-0287 [00] ex_system_io_space_han=
:
System-IO (width 8) R/W 1 Address=3DC043061C00000080
Mar  8 09:32:25 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 1 Address=3DDFFF0FC47FF7BE7F
Mar  8 09:32:25 linux kernel: exregion-0287 [00] ex_system_io_space_han=
:
System-IO (width 8) R/W 1 Address=3DDFFF0FC400000800
Mar  8 09:32:25 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE81
Mar  8 09:32:25 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7D
Mar  8 09:32:25 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7E
Mar  8 09:32:25 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7D
Mar  8 09:32:25 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7E
Mar  8 09:32:25 linux kernel: [ACPI Debug]  String: [0x0D] " SMI routin=
e "

Thx for your attention.

If you need more informations, please tell me...I always have the
opensuse live cd.

Cheers
Guillaume

>>> In that case, try catting /proc/acpi/event and hit the button.
> On SUSE, instead of stopping acpid, you can use:
> acpi_listen
> to log acpi events.
>=20
>    Thomas
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
