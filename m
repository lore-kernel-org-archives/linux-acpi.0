From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: smartbattery support
Date: Thu, 7 Oct 2004 21:43:20 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575456AB2@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

You needed an EC-based SMBus host driver (IIRC, some Acer latops defined
such host in DSDT). ACPI spec has the definition for EC-based SMBus host
interface. Second, a sensor driver for reading smart battery information
is required.

Thanks,
Shaohua

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Pedro Venda
>Sent: Thursday, October 07, 2004 8:34 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Pavel Machek
>Subject: Re: [ACPI] smartbattery support
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>i have joined the lmsensors mailing list and the sbs-forum to get some
>more help but i'm still waiting for feedback there, so... mean while
>i'll just study i2c protocols.
>
>i'm thinking in writing a sensor driver to read the battery information
>and then a userland program could format it and do whatever it likes.
>
>as far as acpi goes, i still need some information on how will the i2c
>driver be plugged into the ACPI framework.
>
>regards,
>pedro venda.
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.4 (GNU/Linux)
>Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
>iD8DBQFBZTeseRy7HWZxjWERAhruAKD2+1WfdGmnVTK0D193UI/0McnRqwCcCWwL
>xJ8po5VdwLyS2/pMP25drh8=3D
>=3DdQP1
>-----END PGP SIGNATURE-----
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IT Product Guide on
ITManagersJournal
>Use IT products in your business? Tell us what you think of them. Give
us
>Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
more
>http://productguide.itmanagersjournal.com/guidepromo.tmpl
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
