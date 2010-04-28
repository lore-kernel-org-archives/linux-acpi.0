From: Pat Erley <pat-lkml@erley.org>
Subject: Re: powernow-k8: No compatible ACPI _PSS objects found. (Asrock N68-S)
Date: Wed, 28 Apr 2010 01:38:00 -0400
Message-ID: <4BD7C9B8.3090508@erley.org>
References: <hr8dum$ivs$1@dough.gmane.org> <4BD7C0FF.5030302@erley.org> <hr8h5q$qt7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from li59-9.members.linode.com ([97.107.129.9]:42894 "EHLO erley.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538Ab0D1FiH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Apr 2010 01:38:07 -0400
In-Reply-To: <hr8h5q$qt7$1@dough.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Manuel_Arg=FCelles?= <manuel.arguelles@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 04/28/10 01:30, Manuel Arg=FCelles wrote:
> Pat Erley wrote:
>>
>> I recently did something similar: http://pat.erley.org/Other/P4EISTS=
SDT
>>
>> It wasn't 'too hard', but it was by no means easy... the _PSS values=
 were
>> kinda voodoo for me to come up with, and I'm not sure that I have th=
em
>> correct, just that they work.
>>
>> Pat
>=20
> Thanks a lot!! I took a look at my ssdt and it doesn't even looks com=
plete:
>=20
> DefinitionBlock ("SSDT.aml", "SSDT", 1, "A M I ", "POWERNOW", 0x00000=
001)
> {
>=20
> No idea how to get the values for my CPU, maybe contacting AMD?
>=20
> One question, if I do something really really stupid, is it possible =
to fry=20
> the CPU? what can be the worst case scenario?=20

Unfortunately, I don't have answers to any of these questions/problems.=
  In=20
my case, Intel DSDT/SSDT mods are common in the Mac world, so I was abl=
e to
find a lot of resources.  I'm guessing the wrong value could damage som=
ething,
but can't speak from experience.  the PSS values dictate CPU voltages a=
nd=20
=46reqencies, which dictate heat generation, so it'd be logical that th=
is=20
could cause damage.  I'd suggest looking up AMD datasheets for the CPU =
and=20
chipsets.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
