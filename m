From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI key events handling
Date: Fri, 11 Mar 2005 16:47:05 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8407663707@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The patch at http://bugzilla.kernel.org/show_bug.cgi?id=3D3851#c52 is =
worthy=20
testing, if you have EC related issue.

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Thomas =
Renninger
Sent: 2005=C4=EA3=D4=C211=C8=D5 0:28
To: Li, Shaohua
Cc: Karol Kozimor; Paulo Vitor Magacho da Silva; =
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] ACPI key events handling

Li, Shaohua wrote:

>How about below patch? It fixes current ec address space handler bugs.
>
>Thanks,
>Shaohua
>
>
>diff -puN drivers/acpi/ec.c~ec_addr_space_handler drivers/acpi/ec.c
>--- 2.5/drivers/acpi/ec.c~ec_addr_space_handler	2005-03-08
>09:19:05.228720200 +0800
>+++ 2.5-root/drivers/acpi/ec.c	2005-03-08 10:35:54.130060696 +0800
>@@ -441,7 +441,7 @@ acpi_ec_space_handler (
> {
> 	int			result =3D 0;
> 	struct acpi_ec		*ec =3D NULL;
>-	u32			temp =3D 0;
>+	u32			temp =3D *value;
> 	acpi_integer		f_v =3D 0;
> 	int 			i =3D 0;
>=20
>@@ -462,10 +462,9 @@ next_byte:
> 	switch (function) {
> 	case ACPI_READ:
> 		result =3D acpi_ec_read(ec, (u8) address, &temp);
>-		*value =3D (acpi_integer) temp;
> 		break;
> 	case ACPI_WRITE:
>-		result =3D acpi_ec_write(ec, (u8) address, (u8) *value);
>+		result =3D acpi_ec_write(ec, (u8) address, (u8) temp);
> 		break;
> 	default:
> 		result =3D -EINVAL;
>@@ -474,19 +473,18 @@ next_byte:
> 	}
>=20
> 	bit_width -=3D 8;
>-	if(bit_width){
>-
>+	if (bit_width){
> 		if(function =3D=3D ACPI_READ)
>-			f_v |=3D (acpi_integer) (*value) << 8*i;
>+			f_v |=3D temp << 8 * i;
> 		if(function =3D=3D ACPI_WRITE)
>-			(*value) >>=3D8;=20
>+			temp >>=3D 8;
> 		i++;
> =20
>

So the actual fix is this?

>+		(u8)address ++;
> =20
>
I saw it some days ago.
However this only fixes something if you see:
*acpi_ec_space_handler: bit_width should be 8*
messages in your syslog.
Could you delete this message as well, please?
I have a machine here having this message in syslog
every second...
I didn't try the keys, but I think they work as expected.

I wonder whether  u64 temp should be used, acpi_integer could be u64
and bit_width (QWordAcc) could be 64 bit?

> 		goto next_byte;
> 	}
>=20
>-
> 	if(function =3D=3D ACPI_READ){
>-		f_v |=3D (acpi_integer) (*value) << 8*i;
>+		f_v |=3D temp << 8 * i;
> 		*value =3D f_v;
> 	}
>=20
>@@ -505,8 +503,6 @@ out:
> 	default:
> 		return_VALUE(AE_OK);
> 	}
>-=09
>-
> }
>=20
> =20
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Karol Kozimor
>>Sent: Thursday, March 10, 2005 4:50 PM
>>To: Paulo Vitor Magacho da Silva
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: Re: [ACPI] ACPI key events handling
>>
>>Thus wrote Paulo Vitor Magacho da Silva:
>>   =20
>>
>>>  I have an ACER 163lmi laptop and I am having problem with some of
>>>     =20
>>>
>the
> =20
>
>>Fn
>>   =20
>>
>>>keys. I don't know if this is related to ACPI or not.
>>>  The problem is that when I press some the Fn keys, like the sleep
>>>     =20
>>>
>>button
>>   =20
>>
>>>(Fn+F4), and I look at the /proc/acpi/event, sometimes the key works
>>>sometimes it doesn't. I did also the check of the Fn keys with the
>>>     =20
>>>
>acerhk
> =20
>
>>>driver. My laptop has the mail, internet, p1, p2, wireless, buttons.
>>>     =20
>>>
>And
> =20
>
>>>when I press those buttons, sometimes I get the correct reading from
>>>     =20
>>>
>the
> =20
>
>>>acerhk driver, sometimes when I press the mail buttons it reads back
>>>     =20
>>>
>the
> =20
>
>>>wireless, or any other key, and sometimes it just reads garbage.
>>>     =20
>>>
>>Sounds like another instance of
>>http://bugzilla.kernel.org/show_bug.cgi?id=3D4124
>>
>>Best regards,
>>
>>   =20
>>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
