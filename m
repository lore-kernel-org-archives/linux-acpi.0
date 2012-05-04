From: Marco Aurelio da Costa <costa@gamic.com>
Subject: Re: [RFC][PATCH] ACPI: Ignore invalid _PSS entries, but use valid ones
Date: Fri, 4 May 2012 11:13:22 -0300
Message-ID: <CAEe-dwj4JP-U0tc3wpmHvzv=aQU5zy3cG_E9FrriPw_sdfg2bg@mail.gmail.com>
References: <CAEe-dwgCR55urie0c1MdBWTS6-E=3faXj68=WMcb6NvQCQX0rg@mail.gmail.com>
	<20120504135217.GB1049@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51837 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab2EDONX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 May 2012 10:13:23 -0400
In-Reply-To: <20120504135217.GB1049@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Konrad.

On Fri, May 4, 2012 at 10:52 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Fri, May 04, 2012 at 10:46:01AM -0300, Marco Aurelio da Costa wrot=
e:
>> From: Marco Aurelio da Costa <costa@gamic.com>
>> Signed-off-by: Marco Aurelio da Costa <costa@gamic.com>
>>
>> The EliteBook 8560W has non-initialized entries in its _PSS ACPI
>> table. Instead of bailing out when the first non-initialized entry i=
s
>> found, ignore it and use only =C2=A0the valid entries. Only bail out=
 if there
>> is no valid entry at all.
>
> Is that safe? Meaning re-use the other CPU's _PSS states? Perhaps the
> warning at the end should say: "Trying to compensate by using the
> other CPU's PSS state).

This case in question was created by HP removing the overclock options
and leaving the entries in a invalid/empty situation. In this specific
case, it is safe.
I am not changing the table in any way, I just ignore the
non-initialized entries. The code only use listed states. If they are
CPU bound, the code doesn't assume anything.

>
>>
>> ---
>> --- linux-3.3.3/drivers/acpi/processor_perflib.c.orig =C2=A0 2012-04=
-24
>> 22:18:23.288041268 +0200
>> +++ linux-3.3.3/drivers/acpi/processor_perflib.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A02012-04-24
>> 22:19:25.912042603 +0200
>> @@ -311,6 +311,7 @@ static int acpi_processor_get_performanc
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct acpi_buffer state =3D { 0, NULL };
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0union acpi_object *pss =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>> + =C2=A0 =C2=A0 =C2=A0 int last_invalid =3D -1;
>>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D acpi_evaluate_object(pr->handl=
e, "_PSS", NULL, &buffer);
>> @@ -374,12 +375,30 @@ static int acpi_processor_get_performanc
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0printk(KERN_ERR FW_BUG PREFIX
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Invalid BIOS _PSS frequency: 0x%ll=
x MHz\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px->core_frequency);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 result =3D -EFAULT;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kfree(pr->performance->states);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto end;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (-1 =3D=3D last_invalid)
>
> Swap it around or just do it this way:

Ok.

>
> if (last_invalid < 0)
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_invalid =3D i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (last_invalid !=3D -1) {
>
> if (last_invalid >=3D 0)
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Copy this valid entry ov=
er last_invalid entry
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&(pr->performance->states=
[last_invalid]),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0px, s=
izeof(struct acpi_processor_px));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++last_invalid;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> + =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D last_invalid) {
>
> So if _PSS that is missing is at CPU2, this own't print it.

I don't get what do you mean by CPU. last_invalid is just the last
invalid _PSS entry item. Nothing to do with the CPU.

>
> I think you want 'if (last_invalid >=3D 0)'

No, it is correct. If the last invalid found item is the item 0, than
it means that no valid item was found.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR F=
W_BUG PREFIX
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0"No valid BIOS _PSS frequency found\n");
>
> And you should mention which CPU has it busted - as there are
> some that are working.

No CPU here, just the _PSS item.

>
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D -EFAUL=
T;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(pr->perform=
ance->states);
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (last_invalid > 0)
>
> Don't you want 'last_invalid >=3D 0' ?

No. It is correct. If the last invalid item is greater than 0, then
there was at least 1 valid _PSS entry. And the count of valid entries
is the same as the last_invalid variable.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr->performance->=
state_count =3D last_invalid;
>> +
>> =C2=A0 =C2=A0 =C2=A0 end:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(buffer.pointer);
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml

I will send the corrected patch next.


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
