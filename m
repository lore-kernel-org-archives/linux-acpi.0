From: =?UTF-8?B?RnJhbsOnb2lzIFZhbGVuZHVj?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: Re: What's up with the Embedded Controller driver? [was
 Re: [ACPI] patched sms-cm acpi/ec.c to 2.6.11.5]
Date: Thu, 24 Mar 2005 16:37:16 +0100
Message-ID: <4242DEAC.6040900@tiscali.be>
References: <3ACA40606221794F80A5670F0AF15F84041AC159@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC159@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

You mean the acpi-20050309-2.6.11 patch ? I tried it but I get rejects=20
on the KConfig file. Nevertheless the kernel seems to compile correctly.=20
I have tried it and I don't notice big changes. However I already said=20
that I don't  encounter the problem mentionned by Rich Townsend when I=20
use his DSDT patches (lost interrupts, keypresses not taken into=20
account). There is sometime a slight but perceivable slowdown when I hit=20
the same key repeatedly (aad it occours only with some programs).

Fran=C3=A7ois Valenduc

Yu, Luming a =C3=A9crit :

>Do you try latest acpi testing patch?
>It includes patch filed at http://bugme.osdl.org/show_bug.cgi?id=3D3851
>
>
>Thanks
>Luming=20
>
> =20
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>>Fran?ois Valenduc
>>Sent: 2005=E5=B9=B43=E6=9C=8824=E6=97=A5 3:35
>>To: Rich Townsend
>>Cc: Pedro Venda; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: [ACPI] Re: What's up with the Embedded Controller=20
>>driver? [was Re: [ACPI] patched sms-cm acpi/ec.c to 2.6.11.5]
>>
>>
>>   =20
>>
>>>>>it does NOT seem ok. after some more tests with the patch, I found=20
>>>>>out that francois was right about most of the problems:
>>>>>* timeout on boot, just after the boot loader. this is very=20
>>>>>confusing to me...
>>>>>* when I plug in the battery, it takes ages to show information=20
>>>>>about it... more than 1 minute.
>>>>>* about the usb problems, apparently I wasn't affected.
>>>>>
>>>>>could you please tip us about what could be causing these delays?=20
>>>>>especially the boot delay... it really puzzles my mind.
>>>>>
>>>>>regards,
>>>>>pedro venda.
>>>>>
>>>>>
>>>>>         =20
>>>>>
>>>>Concerning USB problems, I think it happens because I tried=20
>>>>       =20
>>>>
>>the patch=20
>>   =20
>>
>>>>with the 2.6.11 kernel. I have retried with the 2.6.11.5 and there=20
>>>>are no more USB problems. But all the other problems remains.=20
>>>>Concerning the timeout on boot, could it be caused by the=20
>>>>acpi-dsdt-initrd patch made by Markus Gaugausch. Maybe we=20
>>>>       =20
>>>>
>>should try=20
>>   =20
>>
>>>>other ways to incorporate the DSDT to the kernel.
>>>>Fran=C3=A7ois Valenduc
>>>>       =20
>>>>
>>>I doubt it is the DSDT patch; rather, it looks like=20
>>>     =20
>>>
>>something has gone=20
>>   =20
>>
>>>wrong in the embedded controller driver in going from 2.6.10 to=20
>>>2.6.11.  I've tried out a number of different ways of fixing=20
>>>     =20
>>>
>>ec event=20
>>   =20
>>
>>>handling, including my own spinlock kludge and Pedro's=20
>>>     =20
>>>
>>version of it,=20
>>   =20
>>
>>>and also a series of patches by Dmitry Torokhov; but all of=20
>>>     =20
>>>
>>them seem=20
>>   =20
>>
>>>to have problems with very sluggish EC response and/or EC timeouts=20
>>>(indicated by "Handler for [EmbeddedControl] returned AE_TIME").
>>>
>>>Who currently maintains ec.c? And what exactly has been done to it=20
>>>since 2.6.10?
>>>
>>>cheers,
>>>
>>>Rich
>>>
>>>
>>>     =20
>>>
>>Just by curiosity I tried the DSDT patches without applying=20
>>any patch on=20
>>the ec.c file and I don't notice any problem yet. I choose for=20
>>a static=20
>>DSDT override and there doesn't seem to be any slowdown of my=20
>>computer.=20
>>If I have well understood I could see "Handler for [EmbeddedControl]=20
>>returned AE_TIME" appearing in kernel messages but it doesn't appear.=20
>>Maybe I am very lucky!
>>
>>Fran=C3=A7ois
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by Microsoft Mobile & Embedded=20
>>DevCon 2005
>>Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
>>Embedded(r) & Windows Mobile(tm) platforms, applications &=20
>>content.  Register
>>by 3/29 & save $300=20
>>http://ads.osdn.com/?ad_id=3D6883&alloc_id=3D15149&op=3Dclick
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>>   =20
>>



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Regi=
ster
by 3/29 & save $300 http://ads.osdn.com/?ad_id=3D6883&alloc_id=3D15149&op=
=3Dclick
