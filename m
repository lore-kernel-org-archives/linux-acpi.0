From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Centrino question
Date: Mon, 10 May 2004 10:27:24 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8404407A5B@PDSMSX403.ccr.corp.intel.com>
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
To: Cyril Wattebled <neurowork-GANU6spQydw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Need output of acpidmp to verify .

Thanks,
Luming
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Cyril Wattebled
>Sent: Monday, May 10, 2004 8:28 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Centrino question
>
>Thanks for the link, I applied the patch but I still only have=20
>C2 max ...
>Any other clues ?
>
>On Sun, 09 May 2004 13:51:13 -0400
>Dino Klein <zagzag-lists-zY4eFNvK5D9If6P1QZMOBw@public.gmane.org> wrote:
>
>> I have an Acer C302, with a Pentium M 1.6, and the Intel=20
>855GME chipset.=20
>> The CPU/chipset supports C1 - C4.
>> My hypothesis as to why you don't have C3 is because it is=20
>disabled thru=20
>> the value of the C3 latency in the FADT. The DSDT code=20
>probably has a=20
>> _CST field/method for the processor, which specifies the available=20
>> C-States. I've used a patch (from here=20
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D1958), that reads=20
>the _CST=20
>> object.
>> Give it a try, and see if it solves your issue.
>>=20
>>=20
>> Cyril Wattebled wrote:
>> > Hi there,
>> >=20
>> > I'm wondering if all Pentium M processor support C1 C2 and C3 ?
>> > Because I have a Sony Vaio Z1 with a Pentium M 1.7ghz and=20
>linux only
>> > detects C1 and C2. I have a friend who has a Toshiba Tecra=20
>with a Pentium M
>> > 1.4ghz and it supports C3.
>> > I have heard that even C3 and C4 are supported by Centrinos.
>> > I'm using kernel 2.6.6-rc3.=20
>> > Is there a logical answer why the kernel does only detect=20
>C1 and C3 ?
>> > Thanks
>> >=20
>> > Cyril
>>=20
>>=20
>> -------------------------------------------------------
>> This SF.Net email is sponsored by Sleepycat Software
>> Learn developer strategies Cisco, Motorola, Ericsson &=20
>Lucent use to deliver
>> higher performing products faster, at low TCO.
>> http://www.sleepycat.com/telcomwpreg.php?From=3Dosdnemail3
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>=20
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Sleepycat Software
>Learn developer strategies Cisco, Motorola, Ericsson & Lucent=20
>use to deliver
>higher performing products faster, at low TCO.
>http://www.sleepycat.com/telcomwpreg.php?From=3Dosdnemail3
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
