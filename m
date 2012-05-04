From: Marco Aurelio da Costa <costa@gamic.com>
Subject: Re: [RFC][PATCH v2] ACPI: Ignore invalid _PSS entries, but use valid ones
Date: Fri, 4 May 2012 18:21:43 +0200
Message-ID: <CAEe-dwhQXaMLH3FomhhD+iyqVOOKJA7ccSzmar9XRXS971JdeQ@mail.gmail.com>
References: <CAEe-dwgCR55urie0c1MdBWTS6-E=3faXj68=WMcb6NvQCQX0rg@mail.gmail.com>
	<20120504135217.GB1049@phenom.dumpdata.com>
	<CAEe-dwj4JP-U0tc3wpmHvzv=aQU5zy3cG_E9FrriPw_sdfg2bg@mail.gmail.com>
	<CAEe-dwg5pG2aDHopeHA2yiACUjS3cba5Vm1GyOaM4y=gpvpmMQ@mail.gmail.com>
	<CAEe-dwjVsqn-XyXfhRacEF5gh_5GCX_MeNafPkSGFu_eeA3Pfw@mail.gmail.com>
	<20120504161154.GA16255@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42525 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2EDQVo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 May 2012 12:21:44 -0400
In-Reply-To: <20120504161154.GA16255@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, May 4, 2012 at 6:11 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Fri, May 04, 2012 at 05:25:13PM +0200, Marco Aurelio da Costa wrot=
e:
>> From: Marco Aurelio da Costa <costa@gamic.com>
>> [v2: Fixes suggested by Konrad]
>> Signed-off-by: Marco Aurelio da Costa <costa@gamic.com>
>
> Heh. You didn't compile test this version did you?

>>
>> The EliteBook 8560W has non-initialized entries in its _PSS ACPI
>> table. Instead of bailing out when the first non-initialized entry i=
s
>> found, ignore it and use only =C2=A0the valid entries. Only bail out=
 if there
>> is no valid entry at all.
>>
>> ---
>> --- linux-3.3.3/drivers/acpi/processor_perflib.c.orig 2012-04-24
>> 22:18:23.288041268 +0200
>> +++ linux-3.3.3/drivers/acpi/processor_perflib.c =C2=A0 =C2=A0 =C2=A0=
2012-05-04
>> 17:22:57.400034613 +0200
>> @@ -311,6 +311,7 @@ static int acpi_processor_get_performanc
>> =C2=A0 =C2=A0 =C2=A0 struct acpi_buffer state =3D { 0, NULL };
>> =C2=A0 =C2=A0 =C2=A0 union acpi_object *pss =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 int i;
>> + =C2=A0 =C2=A0 int last_invalid =3D -1;
>>
>>
>> =C2=A0 =C2=A0 =C2=A0 status =3D acpi_evaluate_object(pr->handle, "_P=
SS", NULL, &buffer);
>> @@ -372,14 +373,32 @@ static int acpi_processor_get_performanc
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((u32=
)(px->core_frequency * 1000) !=3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(px->core_frequency * 1000))) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_ERR FW_BUG PREFIX
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Invalid BIOS _PSS frequency: 0x%llx MHz=
\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0px->core_frequency);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 result =3D -EFAULT;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 kfree(pr->performance->states);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto end;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Invalid BIOS _PSS frequency found for p=
rocessor %d: 0x%llx MHz\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr->id, px->core_frequency);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (last_invalidi =3D=3D -1)
>
> Hrmm. invalidi?

Sorry, vi...

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_invalid =3D i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (last_invalid !=3D -1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Copy this valid entry over last=
_invalid entry
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&(pr->performance->states[last_i=
nvalid]),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0px, sizeof(s=
truct acpi_processor_px));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++last_invalid;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 if (last_invalid =3D=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR FW_BUG P=
REFIX
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0"No valid BIOS _PSS frequency found for processor %d\n", pr->id);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D -EFAULT;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(pr->performance->s=
tates);
>
> Just as a precaution - also do this pls:
>
> pr->performance->states =3D NULL?

It wasn't on the original code, but I agree with you.

Doing and compiling, this time... :)

>
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (last_invalid > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr->performance->state_c=
ount =3D last_invalid;
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0end:
>> =C2=A0 =C2=A0 =C2=A0 kfree(buffer.pointer);
>>
>> --
>> Marco Costa
>> Customer Support
>> --
>> GAMIC mbH
>> Roermonder Strasse, 151
>> 52072 Aachen
>> Germany
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml



--=20
Marco Costa
Customer Support
--
GAMIC mbH
Roermonder Strasse, 151
52072 Aachen
Germany
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
