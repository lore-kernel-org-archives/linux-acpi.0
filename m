From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: acpi on sony vaio vgn-sz61mn
Date: Tue, 23 Jun 2009 16:44:15 +0800
Message-ID: <1245746655.15520.96.camel@rzhang-dt>
References: <4A38F2FA.5000207@uni-koblenz.de>
	 <1245286687.9076.101.camel@rzhang-dt>  <4A40928A.7000608@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15824 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614AbZFWIn3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2009 04:43:29 -0400
In-Reply-To: <4A40928A.7000608@uni-koblenz.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>

On Tue, 2009-06-23 at 16:30 +0800, Sebastian Pohl wrote:
> Hi!
>=20
> Zhang Rui wrote:
> > On Wed, 2009-06-17 at 21:43 +0800, Sebastian Pohl wrote:
> >  =20
> >> Hello everyone!
> >>
> >> Thank you to everyone working on the sony stuff! It made my laptop=
 a=20
> >> much more valuable companion!
> >>
> >> But there are still some flaws that are left. I am writing to get =
an=20
> >> advise what to do with them.=20
> >>    =20
> >
> >
> >  =20
> >> Ok, the problems are:
> >>
> >> - The special button s2 generates the same acpi event as the stami=
na switch
> >> - The lidswitch does not generate any acpi events
> >> - The Power does not generate any acpi events
> >>
> >>    =20
> > please kill acpid, and run "cat /proc/acpi/event", what do you get =
when
> > pressing each of the three buttons?
> >  =20
> Both, the s2 Button and the stamina switch generate the following
>=20
so Q1 and Q2 are sony platform driver problems.
what do you get when pressing the power button?

thanks,
rui
> sony/hotkey SPIC 00000001 00000021
> > run "cat /proc/interrupts" both before and after pressing these but=
tons,
> > does the number of ACPI or sony interrupts increase?
> > If ACPI interrupts increases, please run
> > "grep . /sys/firmware/acpi/interrupts/*" and tell us which GPE/Fixe=
d
> > event is fired.
> >
> >  =20
> Only the stamina switch and the s2 button increase any interrupts but=
=20
> only sony interrupts are generated.
> > =EF=BB=BF
> >  =20
> >> Should i post them to bugtrackter or=20
> >> something else?
> >>
> >>    =20
> > please file a new bug report at
> > http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> > and attach all the request info there.
> > please also attach the acpidump output.
> >
> > thanks,
> > rui
> >
> >  =20
>=20
> thank you!
>=20
> regards
>=20
>      sebastian

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
