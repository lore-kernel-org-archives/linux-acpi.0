From: William R Sowerbutts <will-ffEBwZeNOFERmelmmXo44Q@public.gmane.org>
Subject: Re: acpi events -- problem on ThinkPad T41P
Date: Fri, 27 Feb 2004 18:42:04 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040227184204.GT19633@sowerbutts.com>
References: <1077631684.403b5ac4e6272@imp5-q.free.fr> <1077687901.5913.100.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1077687901.5913.100.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a similar problem with ACPI on my IBM ThinkPad T41P with Linux
2.6.3-mm4 (built without APIC support).

After a reboot I get power button and lid open/close events reported to acp=
id
through /proc/acpi/event, but after sending the laptop to ACPI S3 sleep mode
and awakening it these events stop appearing.

The acpi interrupt is not incremented. No strange messages errupt forth fro=
m=20
the kernel.

Any ideas?

Thanks,

Will


On Wed, Feb 25, 2004 at 12:45:01AM -0500, Len Brown wrote:
>does the power button result in incrementing the acpi interrupt in
>/proc/interrupts?
>
>if no, then we've got your SCI configured incorrectly, something I'm
>looking at right now.
>
>if /proc/interrupts shows IOAPIC mode, you're probably suffering from
>this one:
>
>http://bugzilla.kernel.org/show_bug.cgi?id=3D1622
>
>though if you send me your acpidmp output, /proc/interrupts, and dmesg,
>I can tell for sure.
>
>cheers,
>-len
>
>On Tue, 2004-02-24 at 09:08, sweafty-GANU6spQydw@public.gmane.org wrote:
>> Hi,
>>=20
>> I've got some problems with ACPI / Dell Inspiron 5100 (bios revision A26=
). I
>> tried all kernels since 2.6.1, and i always got the same issue: There is=
 no ACPI
>> event writen to /proc/acpi/event.=20
>>=20
>> I close the lid (its state gets changed from 'open' to 'close') =3D> no =
event
>> I push power button =3D> no event
>>=20
>> Through boot messages (dmesg), all these are detected. Can somebody help=
 me
>> figuring out what the problem is ?
>>=20
>> Cheers,
>>=20
>> --
>> Philippe
>>=20
>>=20
>> -------------------------------------------------------
>> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>> Build and deploy apps & Web services for Linux with
>> a free DVD software kit from IBM. Click Now!
>> http://ads.osdn.com/?ad_id=1356&alloc_id438&op=3Dclick
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>
>-------------------------------------------------------
>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>Build and deploy apps & Web services for Linux with
>a free DVD software kit from IBM. Click Now!
>http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>


_________________________________________________________________________
William R Sowerbutts                                  will-ffEBwZeNOFERmelmmXo44Q@public.gmane.org
Coder / Guru / Nrrrd                                http://sowerbutts.com
         main(){char*s=3D">#=3D0> ^#X@#@^7=3D",c=3D0,m;for(;c<15;c++)for
         (m=3D-1;m<7;putchar(m++/6&c%3/2?10:s[c]-31&1<<m?42:32));} =20



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
