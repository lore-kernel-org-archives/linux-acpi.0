From: Pat Erley <pat-lkml@erley.org>
Subject: Re: powernow-k8: No compatible ACPI _PSS objects found. (Asrock N68-S)
Date: Wed, 28 Apr 2010 01:00:47 -0400
Message-ID: <4BD7C0FF.5030302@erley.org>
References: <hr8dum$ivs$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from li59-9.members.linode.com ([97.107.129.9]:54456 "EHLO erley.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab0D1FAz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Apr 2010 01:00:55 -0400
In-Reply-To: <hr8dum$ivs$1@dough.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Manuel_Arg=FCelles?= <manuel.arguelles@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 04/28/10 00:35, Manuel Arg=FCelles wrote:
> Hi,
>=20
> I just bought an AsRock N68-S motherboard with an AMD Phenom II 955=20
> processor and I'm getting this message.
>=20
> Cool 'n Quiet option is enabled on the bios, I retrieved the DSDT (fr=
om=20
> /proc/acpi/dsdt) and decoded it with iasl -d, couldn't find anything =
about=20
> _PSS on it.
>=20
> I emailed AsRock support but no answer, the bios version that I have =
is 2.0,=20
> it was released on December 25, 2009.
>=20
> I have read that it is possible to modify the DSDT to support this, b=
ut I=20
> have no idea how to do that, I haven't found much information either.
>=20
> What do you recommend me to do?, should I try to get more into DSDT? =
is=20
> adding _PSS to a DSDT an easy task?
>=20
> I haven't test it on windows, do you think that may help? is there an=
y=20
> useful information that I cat get about it on windows? does windows a=
lso=20
> interacts with the Cool 'n Quiet feature using the bios' DSDT or some=
thing=20
> else? Will it be possible that it works fine on windows but not on li=
nux? On=20
> the download page there's a Cool'n'Quiet driver for windows. (Is ther=
e=20
> anything that can be done with that?)
>=20
> I also tried to recompile the DSDT and got one error and 7 warnings, =
the=20
> error was:
>=20
> DSDT.dsl  4832:  Return (Zero)
> Error    4080 -  ^ Invalid object type for reserved name (found ZERO,=
=20
> requires Buffer)
>=20
> Which I suppose has nothing to do with this.
>=20
> Regards
>=20

I recently did something similar: http://pat.erley.org/Other/P4EISTSSDT

It wasn't 'too hard', but it was by no means easy... the _PSS values we=
re=20
kinda voodoo for me to come up with, and I'm not sure that I have them
correct, just that they work.

Pat
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
