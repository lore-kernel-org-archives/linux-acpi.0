From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: What's up with the Embedded Controller driver? [was Re: patched
 sms-cm acpi/ec.c to 2.6.11.5]
Date: Wed, 23 Mar 2005 14:19:37 -0500
Message-ID: <4241C149.4070601@bartol.udel.edu>
References: <423EF2EB.5030505@arrakis.dhis.org> <4241A77B.1070807@bartol.udel.edu> <200503231739.56592.pjvenda@arrakis.dhis.org> <4241B236.40601@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4241B236.40601-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Cc: Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Fran=E7ois Valenduc wrote:
> Pedro Venda a =E9crit :
>=20
>=20
>>On Wednesday 23 March 2005 17:29, Rich Townsend wrote:
>>=20
>>
>>
>>>Hi Pedro --
>>>
>>>Sorry I didn't respond sooner; I've been very busy with my job. I'll
>>>check through this when I get a chance, and roll it into my sbs-cm stu=
ff
>>>if it looks OK.
>>>  =20
>>>
>>
>>hello rich,
>>
>>take your time. we're all doing what we can.
>>
>>it does NOT seem ok. after some more tests with the patch, I found out =
that=20
>>francois was right about most of the problems:
>>* timeout on boot, just after the boot loader. this is very confusing t=
o me...
>>* when I plug in the battery, it takes ages to show information about i=
t...=20
>>more than 1 minute.
>>* about the usb problems, apparently I wasn't affected.
>>
>>could you please tip us about what could be causing these delays? espec=
ially=20
>>the boot delay... it really puzzles my mind.
>>
>>regards,
>>pedro venda.
>>=20
>>
>=20
> Concerning USB problems, I think it happens because I tried the patch=20
> with the 2.6.11 kernel. I have retried with the 2.6.11.5 and there are=20
> no more USB problems. But all the other problems remains. Concerning th=
e=20
> timeout on boot, could it be caused by the acpi-dsdt-initrd patch made=20
> by Markus Gaugausch. Maybe we should try other ways to incorporate the=20
> DSDT to the kernel.
> Fran=E7ois Valenduc

I doubt it is the DSDT patch; rather, it looks like something has gone=20
wrong in the embedded controller driver in going from 2.6.10 to 2.6.11.=20
  I've tried out a number of different ways of fixing ec event handling,=20
including my own spinlock kludge and Pedro's version of it, and also a=20
series of patches by Dmitry Torokhov; but all of them seem to have=20
problems with very sluggish EC response and/or EC timeouts (indicated by=20
"Handler for [EmbeddedControl] returned AE_TIME").

Who currently maintains ec.c? And what exactly has been done to it since=20
2.6.10?

cheers,

Rich


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
