From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: patched sms-cm acpi/ec.c to 2.6.11.5
Date: Wed, 23 Mar 2005 19:15:18 +0100
Message-ID: <4241B236.40601@tiscali.be>
References: <423EF2EB.5030505@arrakis.dhis.org> <4241A77B.1070807@bartol.udel.edu> <200503231739.56592.pjvenda@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <200503231739.56592.pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pedro Venda a =E9crit :

>On Wednesday 23 March 2005 17:29, Rich Townsend wrote:
> =20
>
>>Hi Pedro --
>>
>>Sorry I didn't respond sooner; I've been very busy with my job. I'll
>>check through this when I get a chance, and roll it into my sbs-cm stuf=
f
>>if it looks OK.
>>   =20
>>
>
>hello rich,
>
>take your time. we're all doing what we can.
>
>it does NOT seem ok. after some more tests with the patch, I found out t=
hat=20
>francois was right about most of the problems:
>* timeout on boot, just after the boot loader. this is very confusing to=
 me...
>* when I plug in the battery, it takes ages to show information about it=
...=20
>more than 1 minute.
>* about the usb problems, apparently I wasn't affected.
>
>could you please tip us about what could be causing these delays? especi=
ally=20
>the boot delay... it really puzzles my mind.
>
>regards,
>pedro venda.
> =20
>
Concerning USB problems, I think it happens because I tried the patch=20
with the 2.6.11 kernel. I have retried with the 2.6.11.5 and there are=20
no more USB problems. But all the other problems remains. Concerning the=20
timeout on boot, could it be caused by the acpi-dsdt-initrd patch made=20
by Markus Gaugausch. Maybe we should try other ways to incorporate the=20
DSDT to the kernel.
Fran=E7ois Valenduc


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Regi=
ster
by 3/29 & save $300 http://ads.osdn.com/?ad_id=3D6883&alloc_id=3D15149&op=
=3Dclick
