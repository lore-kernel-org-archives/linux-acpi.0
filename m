From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Oops during startup
Date: Wed, 2 Jun 2004 11:17:57 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F840483B1C4@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Andrew D. Keyser" <andrewdk-Wuw85uim5zDR7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 Please try kernel option: acpi_sci=3D{ level | edge | high | low }

--Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Andrew D. Keyser
>Sent: Wednesday, June 02, 2004 10:48 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Re: Oops during startup
>
>Your problem seems similar to mine; I can't boot any kernel newer than=20
>2.6.6-mm4 without using acpi=3Doff. When the kernel boots, it gets to=20
>"ACPI: IRQ9 SCI: Level Trigger." and stops. I have an HP ze4560us. The=20
>stranger thing though is that I can't even load the Gentoo LiveCD=20
>without acpi=3Doff, so something must be broken either in my laptop=20
>(however that happened) or in both of the kernel versions...
>Might not be related but the symptoms are similar so I figured I might=20
>as well add on.
>
>Andrew
>
>Ethan Glasser-Camp wrote:
>> 2.6.6 oopses on startup for me. acpi=3Doff seems to work OK.
>>=20
>> My Thinkpad T-30 has served me faithfully for about 1.5=20
>years, but was
>> needing some service so I took it to the shop today. They gave me a
>> replacement laptop (same model, still a T-30), but when I tried to
>> boot up, I got a kernel oops. 2.6.5 boots up fine, and so does 2.6.6
>> when given the boot parameter acpi=3Doff. The machines are basically
>> identical except for the CD-ROM drive. Might this cause a problem? Or
>> should I be pointing a finger at the ACPI tables and other firmware?
>>=20
>> Since the kernel oopses before it finishes booting up, I can't even
>> scroll up to the top of it to see what the oops message is.=20
>I can copy
>> the callback if it helps. How can I help to diagnose the problem?
>>=20
>> Ethan Glasser-Camp
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
>installation-authoring solution that does it all. Learn more and
>evaluate today! http://www.installshield.com/Dev2Dev/0504
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
