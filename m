From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Fri, 4 Feb 2011 21:36:19 +0100
Message-ID: <201102042136.20165.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201102032351.31307.rjw@sisk.pl> <201102040844.05490.ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201102040844.05490.ozan@pardus.org.tr>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Richard =?utf-8?q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, February 04, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> Cuma 04 =C5=9Eubat 2011 g=C3=BCn=C3=BC (saat 00:51:31) Rafael J. Wyso=
cki =C5=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:
>=20
> > Hmm.  Are those boxes uniprocessor running SMP kernels?
>=20
> The kernel is SMP.
>=20
> ASUS X61S is=20
>  CPU0: Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz stepping 0a
>=20
> F50SV has 2 CPU's too according to dmesg:
> [    0.000000] Processor #0 (Bootup-CPU)
> [    0.000000] Processor #1
> [    0.000000] I/O APIC #2 Version 20 at 0xFEC00000.
> [    0.000000] IOAPIC[0]: apic_id 2, version 20, address 0xfec00000, =
GSI 0-23
> [    0.000000] Processors: 2
> [    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
>=20
> ASUS N51JQ (occasional shutdown hang) has:
> CPU0: Intel(R) Core(TM) i7 CPU       Q 740  @ 1.73GHz stepping 05
> [    0.132435] Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 Ok.
> [    0.768809] Brought up 8 CPUs

OK, so it's not the case I was thinking of.  Ohwell.

At this point I guess it's best to open a bug entry in the kernel Bugzi=
lla,
against ACPI (although ACPI may be a red herring), and put some system
information (ie. dmesg outputs from working kernels, if any, outputs of
acpidump) -- or links to where it can be found.

Thanks,
Rafael
