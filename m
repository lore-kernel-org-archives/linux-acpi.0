From: Brian Perkins <bperk-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>
Subject: Re: acpi events -- problem on ThinkPad T41P
Date: Sun, 29 Feb 2004 14:42:06 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4042408E.1070801@throb.netspace.org>
References: <1077631684.403b5ac4e6272@imp5-q.free.fr> <1077687901.5913.100.camel@dhcppc4> <20040227184204.GT19633@sowerbutts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040227184204.GT19633-ffEBwZeNOFERmelmmXo44Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: William R Sowerbutts <will-ffEBwZeNOFERmelmmXo44Q@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=3D1661 describes this problem.

Unfortunately for me, the proposed patch which used to work with=20
2.6-test11 doesn't work with 2.6.3 with my thinkpad R32.

I was waiting until the acpi-CA 20040220 is in the acpi-linux patch=20
before I started complaining.


William R Sowerbutts wrote:
> Hi,
>=20
> I have a similar problem with ACPI on my IBM ThinkPad T41P with Linux
> 2.6.3-mm4 (built without APIC support).
>=20
> After a reboot I get power button and lid open/close events reported to=
 acpid
> through /proc/acpi/event, but after sending the laptop to ACPI S3 sleep=
 mode
> and awakening it these events stop appearing.
>=20
> The acpi interrupt is not incremented. No strange messages errupt forth=
 from=20
> the kernel.
>=20
> Any ideas?
>=20
> Thanks,
>=20
> Will
>=20
>=20
> On Wed, Feb 25, 2004 at 12:45:01AM -0500, Len Brown wrote:
>=20
>>does the power button result in incrementing the acpi interrupt in
>>/proc/interrupts?
>>
>>if no, then we've got your SCI configured incorrectly, something I'm
>>looking at right now.
>>
>>if /proc/interrupts shows IOAPIC mode, you're probably suffering from
>>this one:
>>
>>http://bugzilla.kernel.org/show_bug.cgi?id=3D1622
>>
>>though if you send me your acpidmp output, /proc/interrupts, and dmesg,
>>I can tell for sure.
>>
>>cheers,
>>-len
>>
>>On Tue, 2004-02-24 at 09:08, sweafty-GANU6spQydw@public.gmane.org wrote:
>>
>>>Hi,
>>>
>>>I've got some problems with ACPI / Dell Inspiron 5100 (bios revision A=
26). I
>>>tried all kernels since 2.6.1, and i always got the same issue: There =
is no ACPI
>>>event writen to /proc/acpi/event.=20
>>>
>>>I close the lid (its state gets changed from 'open' to 'close') =3D> n=
o event
>>>I push power button =3D> no event
>>>
>>>Through boot messages (dmesg), all these are detected. Can somebody he=
lp me
>>>figuring out what the problem is ?
>>>
>>>Cheers,
>>>
>>>--
>>>Philippe
>>>
>>>
>>>-------------------------------------------------------
>>>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>>>Build and deploy apps & Web services for Linux with
>>>a free DVD software kit from IBM. Click Now!
>>>http://ads.osdn.com/?ad_id=1356&alloc_id438&op=3Dclick
>>>_______________________________________________
>>>Acpi-devel mailing list
>>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>>
>>
>>-------------------------------------------------------
>>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>>Build and deploy apps & Web services for Linux with
>>a free DVD software kit from IBM. Click Now!
>>http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>>
>=20
>=20
>=20
> _______________________________________________________________________=
__
> William R Sowerbutts                                  will-ffEBwZeNOFGbNrsf2+g7sw@public.gmane.org=
om
> Coder / Guru / Nrrrd                                http://sowerbutts.c=
om
>          main(){char*s=3D">#=3D0> ^#X@#@^7=3D",c=3D0,m;for(;c<15;c++)fo=
r
>          (m=3D-1;m<7;putchar(m++/6&c%3/2?10:s[c]-31&1<<m?42:32));} =20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
