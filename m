From: Len Brown <lenb@kernel.org>
Subject: Re: Toshiba P105-S6207 (success using acpi_osi=!Linux) w/dmidecode,dmesg
Date: Fri, 18 Jan 2008 17:26:15 -0500
Message-ID: <200801181726.16018.lenb@kernel.org>
References: <1195043534.5511.18.camel@localhost> <1195072412.7963.6.camel@WM_ADAM1.morrison.iserv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42456 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbYARW03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 17:26:29 -0500
In-Reply-To: <1195072412.7963.6.camel@WM_ADAM1.morrison.iserv.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: adamtaunowilliams@gmail.com
Cc: linux-acpi@vger.kernel.org

On Wednesday 14 November 2007 15:33, Adam Tauno Williams wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: TOSHIBA
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: Satelli=
te P105

> I have a Toshiba P105-S6207 running openSUSE 10.3
> (2.6.22.12-0.1-default).  All the devices (to my knowledge) are worki=
ng,
> except sound;  I've tried various things and the sound driver seems t=
o
> load just fine but produce no output.  Then I noticed a message in dm=
esg
> about trying to boot with "acpi_osi=3D!Linux".  So I booted as:
>=20
> root=3D/dev/Aleph/Root vga=3D0x314 resume=3D/dev/sda2 splash=3Dsilent=
 acpi_osi=3D!
> Linux
>=20
> and Bingo! I got sound.=20

Okay, I've added this box to the list of systems that
fail with OSI(Linux).

Please send me the output from acpidump -- I'd like to find out why.

If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
