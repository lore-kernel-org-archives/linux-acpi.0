From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: What's up with the Embedded Controller driver? [was Re: [ACPI]
 patched sms-cm acpi/ec.c to 2.6.11.5]
Date: Wed, 23 Mar 2005 20:35:02 +0100
Message-ID: <4241C4E6.4020103@tiscali.be>
References: <423EF2EB.5030505@arrakis.dhis.org> <4241A77B.1070807@bartol.udel.edu> <200503231739.56592.pjvenda@arrakis.dhis.org> <4241B236.40601@tiscali.be> <4241C149.4070601@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4241C149.4070601-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>>>
>>> it does NOT seem ok. after some more tests with the patch, I found=20
>>> out that francois was right about most of the problems:
>>> * timeout on boot, just after the boot loader. this is very=20
>>> confusing to me...
>>> * when I plug in the battery, it takes ages to show information=20
>>> about it... more than 1 minute.
>>> * about the usb problems, apparently I wasn't affected.
>>>
>>> could you please tip us about what could be causing these delays?=20
>>> especially the boot delay... it really puzzles my mind.
>>>
>>> regards,
>>> pedro venda.
>>>
>>>
>>
>> Concerning USB problems, I think it happens because I tried the patch=20
>> with the 2.6.11 kernel. I have retried with the 2.6.11.5 and there=20
>> are no more USB problems. But all the other problems remains.=20
>> Concerning the timeout on boot, could it be caused by the=20
>> acpi-dsdt-initrd patch made by Markus Gaugausch. Maybe we should try=20
>> other ways to incorporate the DSDT to the kernel.
>> Fran=E7ois Valenduc
>
>
> I doubt it is the DSDT patch; rather, it looks like something has gone=20
> wrong in the embedded controller driver in going from 2.6.10 to=20
> 2.6.11.  I've tried out a number of different ways of fixing ec event=20
> handling, including my own spinlock kludge and Pedro's version of it,=20
> and also a series of patches by Dmitry Torokhov; but all of them seem=20
> to have problems with very sluggish EC response and/or EC timeouts=20
> (indicated by "Handler for [EmbeddedControl] returned AE_TIME").
>
> Who currently maintains ec.c? And what exactly has been done to it=20
> since 2.6.10?
>
> cheers,
>
> Rich
>
>
Just by curiosity I tried the DSDT patches without applying any patch on=20
the ec.c file and I don't notice any problem yet. I choose for a static=20
DSDT override and there doesn't seem to be any slowdown of my computer.=20
If I have well understood I could see "Handler for [EmbeddedControl]=20
returned AE_TIME" appearing in kernel messages but it doesn't appear.=20
Maybe I am very lucky!

Fran=E7ois


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Regi=
ster
by 3/29 & save $300 http://ads.osdn.com/?ad_id=3D6883&alloc_id=3D15149&op=
=3Dclick
