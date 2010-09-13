From: Yedidia Klein <yedidia@atarplpl.co.il>
Subject: Fwd: getting new hardware (arbor M1526) buttons to work w/ acpi
Date: Mon, 13 Sep 2010 20:14:59 +0200
Message-ID: <AANLkTikmRFbTbcPLmKzV5bK7Y=9ga88NaN=6A26f-tEX@mail.gmail.com>
References: <AANLkTinTLAhRL48sP=B86RMEahx2dg_aczuwS+vn78js@mail.gmail.com>
 <201009061343.32919.trenn@suse.de> <AANLkTikN8bbu=q2bq9N1CptKVJvZD0RVsQGtTwU-AEnE@mail.gmail.com>
 <201009131657.48686.trenn@suse.de> <AANLkTinLh6_q3n8WQJ1DWrhepqXdCeNosRZh9ByY8qVh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63567 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab0IMSPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Sep 2010 14:15:20 -0400
Received: by pvg2 with SMTP id 2so2241543pvg.19
        for <linux-acpi@vger.kernel.org>; Mon, 13 Sep 2010 11:15:19 -0700 (PDT)
In-Reply-To: <AANLkTinLh6_q3n8WQJ1DWrhepqXdCeNosRZh9ByY8qVh@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

ok, found that wmi is compiled into my kernel and not built as module.
while the grep for PNP0C32 returned nothing - so I assume that it's not=
 that.

is there any way to read these addresses directly via C and not via ACP=
I ?

tnx a lot,

--Y


2010/9/13 Thomas Renninger <trenn@suse.de>
>
> On Monday 13 September 2010 16:46:32 Yedidia Klein wrote:
> > hi,
> These are only two possibilities/interfaces how the buttons may be
> driven.
>
> > what is the wmi driver ? there is not any module in this name on my=
 distro
> > (ubuntu 10.4)
> Oh, there should, they probably compiled this driver:
> wmi.ko
> ?
> A debug facility (debug_events=3D1 module parameter) was added
> recently and may not exist there yet.
>
> > the =C2=A0PNP0C32 sounds interesting - what should I patch to enabl=
e it ?
> mkdir /tmp/acpi
> cd /tmp/acpi
> acpidump >acpidump
> acpixtract -a acpidump
> iasl -d DSDT.dat
> iasl -d -e DSDT.dat SSDT*.dat
> grep PNP0C32 *.dsl
>
> Does the last command (grep) give you any output that
> it found the PNP0C32 string in your ACPI BIOS tables
> (which were dumped from memory with the commands before).
> If yes, the button might be served by this interface.
>
> =C2=A0 =C2=A0Thomas
>
> >
> > tnx,
> >
> > --Y
> >
> >
> > On Mon, Sep 6, 2010 at 1:43 PM, Thomas Renninger <trenn@suse.de> wr=
ote:
> >
> > > On Friday 27 August 2010 03:30:11 Zhang Rui wrote:
> > > > On Thu, 2010-08-26 at 17:17 +0800, Yedidia Klein wrote:
> > > > > here is my acpidump output.
> > > > >
> > > > hmmm, please attach the output of "cat /proc/interrupts" and
> > > > "grep . /sys/firmware/acpi/interrupts/*", both before and after=
 pressing
> > > > the hotkey.
> > > Yep.
> > > You could also try to load the wmi driver with:
> > > debug_event=3D1
> > > e.g. adding this line:
> > > options wmi debug_event=3D1
> > > in
> > > /etc/modprobe.d/99-local.conf or /etc/modprobe.conf.local
> > > (the first is the new the latter the older interface, depends on =
your
> > > userspace versions)
> > > Then hit the button and check syslog.
> > >
> > > It might also be served by a Windows spec called "hot start" for =
which
> > > I sent a driver which would still need some polishing some weeks =
ago.
> > > The device for these is:
> > > PNP0C32
> > >
> > > Please add me to CC if you open bug at bugzilla.kernel.org. I won=
't
> > > have time to code, but I can help a bit.
> > >
> > > =C2=A0 =C2=A0 =C2=A0Thomas
> > >
> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
