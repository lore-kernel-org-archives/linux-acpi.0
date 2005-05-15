From: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: Whait is CFGD for?
Date: Mon, 16 May 2005 00:20:18 +0200
Message-ID: <4287CB22.6070306@altern.org>
References: <42820E57.7030309@altern.org> <loom.20050514T041524-961@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <loom.20050514T041524-961-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Manuel J.Galan a =E9crit :

>DJAX <djax@...> writes:
>
> =20
>
>>Hello,
>>I got an Acer Aspire 1694WLMi with bios 3c25.
>>I try to fix the DSDT, but  I don't how to correct the last errors.
>>The compiler tell me about an object CFGD that doesn't exist, but I
>>don't know how and where to declare it and with  which value to
>>initialise it.
>>
>>Can you help me?
>>
>>Thank you
>>Didier
>>
>>   =20
>>
>
>Try this diff:
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>--- dsdt.20050509.custom.dsl.orig       2005-05-14 03:12:47.000000000 +0=
100
>+++ dsdt.20050509.custom.dsl    2005-05-14 03:13:20.000000000 +0100
>@@ -209,6 +209,7 @@
>     Name (\CTYP, 0x00)
>     Name (\L01C, 0x00)
>     Name (\INSX, 0x00)
>+    External (CFGD)
>     Method (\_PIC, 1, NotSerialized)
>     {
>         Store (Arg0, GPIC)
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =20
>

Thank you. It compiles and generates an DSDT.aml to put in my initrd.img =
.
Now at boot, I see this error :
--------------------------8<-------------------------
ACPI: Processor [CPU0] (supports 8 throttling states)
acpi_processor-0484 [07] acpi_processor_get_inf: Error getting cpuindex
for acpi
id 0x1
ACPI: Thermal Zone [THRM] (41 C)
-------------------------->8-------------------------
/Is it an error in my DSDT or somewhere else?

Best regards,
Didier
/


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
