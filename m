From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [PATCH] resend Andrew de Quincey patch, that resolve
	hangs problems
Date: 12 Nov 2003 01:11:29 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068599493.2115.34.camel@darkstar.portugal>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84DC4@pdsmsx403.ccr.corp.intel.com>
	<1068179499.3555.26.camel@darkstar.portugal>
	<1068506148.1703.52.camel@darkstar.portugal>
	<1068531948.2682.1076.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1068531948.2682.1076.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi
Windows run with APIC mode (at least is what windows says) and in linux
we must disable APIC in kernel.
with or without noapic, hangs on boot,  if we don't disable APIC.=20
with last message=20
ACPI Namespace successfully loaded at root c031547c
or just before:
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful.

I discover that system hangs when my cable modem, plugged by usb, goes
down (when ISP have problems).
BTW I had other hanging problems with an old USB storage.

cat /proc/interupts
CPU0
  0:    1003741          XT-PIC  timer
  1:       3100          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:        882          XT-PIC  VIA686A
  8:          1          XT-PIC  rtc
  9:      13807          XT-PIC  usb-uhci
 10:          6          XT-PIC  acpi
 12:      91976          XT-PIC  PS/2 Mouse
 14:      45941          XT-PIC  ide0
 15:     151078          XT-PIC  ide1
NMI:          0
ERR:          0


On Tue, 2003-11-11 at 06:25, Len Brown wrote:
> If Windows can run a box in IO-APIC mode, then Linux should be able to
> do the same.
>=20
> I hesitate to integrate Andrew's automatic pic-fallback workaround into
> the baseline kernel because I'm concerned that it will function
> perfectly.  If we drop into PIC mode automatically, we may not realize
> that we have a significant Linux-specific problem that we might be able
> to solve.

But we have many reports, for VIA or athlon boards, that resolves the
problems and we have many problem that wasnt yet resolved.
In my case, the laptop has 2 years and it is history, so I am not worry
about what is the real problem.
Conclusion if you put debug information when drop into pic mode, for me
it better.=20

>=20
> On the other hand, if Windows can't run in IO-APIC mode and the system
> is broken, then I'm fine with Linux also running in PIC mode.  We
> currently have the manual "noapic" on the cmdline workaround for that,
> as well as the opportunity to build APIC support out of the kernel.  If
> the system is common, we can invoke "noapic" automatically via
> dmi-blacklist.
>=20
> That said...
>=20
> Does Windows (2000/XP) run in IO-APIC mode on this system?
>=20
> Without patching the kernel, does dmesg and /proc/interrupts show your
> system has booted in IO-APIC mode?
>=20
> Can you describe in detail exactly what events cause your system to
> hang?  Can you re-produce this hang at will?
>=20
> If you boot the un-patched kernel with "noapic", does dmesg and
> /proc/interrupts show that we configured the PIC correctly?  Does the
> hang occur under these conditions?
>=20
> Can you send the dmesg and /proc/interrupts for the pacthed kernel?  Can
> you show that the hang doesn't occur using this kernel?
>=20
> It would be ideal if you could make these 6 items attachments in a bug
> report.
I will do it ...
>=20
> thanks,
> -Len
>=20
>=20
> How to file a bug against ACPI:
>=20
> http://bugzilla.kernel.org/
> Category: Power Management
> Component: ACPI
>=20
> Please attach the output from dmidecode, available in /usr/sbin/, or
> here:
> http://www.nongnu.org/dmidecode/
>=20
> Please attach the output from acpidmp, available in /usr/sbin/, or in
> here
> http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.=
gz
>=20
> Please attach /proc/interrupts and the dmesg output showing the failure,
> if possible.
>=20
>=20
> On Mon, 2003-11-10 at 18:15, S=C3=A9rgio Monteiro Basto wrote:
> > Hi=20
> > After the last experience with kernel 2.4.23-pre9, I test this patch an=
d
> > resolves the problem above.
> > And I believe that resolve various problems with irqs.
> > My tests confirm that I need this patch for my machine works well.
> > Yesterday my ISP had many problems and my cable modem has gone down
> > several times and my laptop never hangs.
> > _Note: This patch is already applied.in kernel 2.4.22-ac4.
> > thanks
> >=20
> > On Fri, 2003-11-07 at 04:31, S=C3=A9rgio Monteiro Basto wrote:
> > > Hi=20
> > > Sorry to say this, but laptop hangs again with this patch in pre-9.
> > > when usb CDCEthernet, was gone down.
> > > The facts are:
> > > With 22-ac4 never hangs, I use this kernel, for my normally work, sin=
ce
> > > this release (2003-09-21) and I never had this kind of problems.
> > > I just began use usb CDCEthernet with kernel 4.22, so I don't know if=
 it
> > > hangs or not before.
> > > so I know the problem is began in 23-preX, (I think after pre7) or is
> > > not been corrected like it does in ac4.
> > > If the first choice, what I can test more?
> > > If the second choice, could be one Andrew de Quincey patch's, that is
> > > not applied.
> > > Well I just don't resend the patch because I don't want make more
> > > confusions , and I don't understand if you try (force) to not use the
> > > patch.  If Alan had applied it , I think that can be trustable. Not m=
ore
> > > than that.
> > >=20
> > > thanks
> > >=20
> > > On Thu, 2003-11-06 at 02:40, Li, Shaohua wrote:
> > > >=20
> > > > Many thanks you let me know the result.
> > > >=20
> > > > Thanks,
> > > > Shaohua
> > > >=20
> > > >=20
> > > > > -----Original Message-----
> > > > > From: S=C3=A9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> > > > > Sent: 2003=E5=B9=B411=E6=9C=886=E6=97=A5 11:20
> > > > > To: Li, Shaohua
> > > > > Cc: acpi-devel
> > > > > Subject: RE: [ACPI] [Patch]fix EC GPE context error
> > > > >=20
> > > > > Hi,
> > > > > The first tests seems ok, in 2.4.23-pre9, I had problems without =
this
> > > > > patch, my laptop had hang again, when my usb cable modem has gone=
 down
> > > > > and I turn it off.
> > > > > Now, with this patch, don't had hang anymore.
> > > > > I will test it more time, if I have a problems, I will tell you.
> > > > >=20
> > > > > thanks
> > > > >=20
> > > > > On Mon, 2003-11-03 at 13:29, Li, Shaohua wrote:
> > > > > >
> > > > > > Hi,
> > > > > >    I have attached a patch against 2.4 in bugzilla 1171, please=
 help
> > > > > test. Many thanks.
> > > > > >
> > > > > > Thanks,
> > > > > > Shaohua
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: S=C3=A9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> > > > > > > Sent: 2003=E5=B9=B411=E6=9C=883=E6=97=A5 3:30
> > > > > > > To: Li, Shaohua
> > > > > > > Cc: ACPI Developers
> > > > > > > Subject: Re: [ACPI] [Patch]fix EC GPE context error
> > > > > > >
> > > > > > > Hi
> > > > > > > I can't apply this patch to 2.23-pre9 neither pre8 or pre7 .
> > > > > > > I got one big rejected file (on osl.c I think)
> > > > > > >
> > > > > > > thanks
> > > > > > >
> > > > > > > On Fri, 2003-10-31 at 08:42, Li, Shaohua wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > >      2.6-test9 has a regression. Specifically, the EC GPE c=
ontext
> > > > > fix
> > > > > > > > has error. This new patch is to replace the old one. The pa=
tch is
> > > > > > > > against 2.6-test7, and has passed under T40 and ASUS M2400.=
 You can
> > > > > find
> > > > > > > > detail info in osdl bugzilla 1171. Please help test.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Shaohua
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > --
> > > > > > > S=C3=A9rgioMB
> > > > > > > email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
> > > > > > >
> > > > > > > Who gives me one shell, give me everything.
> > > > > >
> > > > > --
> > > > > S=C3=A9rgioMB
> > > > > email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
> > > > >=20
> > > > > Who gives me one shell, give me everything.
> > > >=20
> > > --=20
> > > S=C3=A9rgioMB
> > > email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
> > >=20
> > > Who gives me one shell, give me everything.
> > >=20
> > >=20
> > >=20
> > > -------------------------------------------------------
> > > This SF.net email is sponsored by: SF.net Giveback Program.
> > > Does SourceForge.net help you be more productive?  Does it
> > > help you create better code?   SHARE THE LOVE, and help us help
> > > YOU!  Click Here: http://sourceforge.net/donate/
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
--=20
S=C3=A9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
