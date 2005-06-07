From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM)
Date: Tue, 07 Jun 2005 03:06:08 +0200
Message-ID: <E1DfSXh-0006lI-39@be1.7eggert.dyndns.org>
References: <4cnEB-7Y5-13@gated-at.bofh.it> <4cnEB-7Y5-19@gated-at.bofh.it> <4cnEB-7Y5-11@gated-at.bofh.it> <4cpZW-1yL-13@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262020AbVFGWrb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger@gmx.at>, acpi-devel@lists.sourceforge.net, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Stefan D=F6singer <stefandoesinger@gmx.at> wrote:

> So it does reach the kernel, right? I don't know if I remembered that=
 call
> correctly, but "lcall $0xffff,$0" should call the real mode BIOS rese=
t
> code...
> Anyone else who can correct me here?

If it's realmode, it should do a jump to the boot entry point of the BI=
OS.
This does not imply a reset, some machines will just hang. Especially a=
fter
messing with the interrupts or mapping some RAM over the lower half of =
the
BIOS, where the boot code is expected.

Good (=3D=3D long gone) old times with DOS.
--=20
Ich danke GMX daf=FCr, die Verwendung meiner Adressen mittels per SPF
verbreiteten L=FCgen zu sabotieren.
