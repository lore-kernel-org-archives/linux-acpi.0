From: Romano Giannetti <romano@dea.icai.upcomillas.es>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off
	aftersuspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 20:43:22 +0100
Message-ID: <1203623002.3420.6.camel@localhost>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
	<b6a2187b0802200937q3ff8f470k235b5d1e00eab59e@mail.gmail.com>
	<alpine.LFD.1.00.0802200945591.7833@woody.linux-foundation.org>
	<b6a2187b0802201002t315548b5uac623759723842d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ic0245.upco.es ([130.206.70.245]:56926 "EHLO
	antispam.upcomillas.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758116AbYBUUKX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 15:10:23 -0500
In-Reply-To: <b6a2187b0802201002t315548b5uac623759723842d0@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>


On Thu, 2008-02-21 at 02:02 +0800, Jeff Chua wrote:
> On Feb 21, 2008 1:52 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=0D
> > Ahh. You're using the BIOS to re-initialize your video, aren't you?
>=0D
> I don't know. Just pure simple "s2ram" without any options.

Well, as far as I know, s2ram could be doing vbe save/restore for you.
Even without parameter, if your laptop is in the whitelist.

> > Let's try to narrow it down to what the interaction is. Are you usi=
ng
> > something like acpi_sleep=3Ds3_bios or similar?
>=0D
> No. Not additional command line option except for resume=3D/dev/sda3 =
reboot=3Dbios

My laptop (a Toshiba satellite U305, intel 945GM chipset, used to need
s2ram -f -p -m to STR correctly. In 2.6.25-rc2 I can simply STR with
echo mem > /sys/power/state.

Romano=0D

I imagine this will be received as blasphemy, but if only ndiswrapper
were not horribly broken, this will be my day-by-day kernel. I just hop=
e
ath5k will arrive to my chipset soon...



--
La presente comunicaci=C3=B3n tiene car=C3=A1cter confidencial y es par=
a el exclusivo uso del destinatario indicado en la misma. Si Ud. no es =
el destinatario indicado, le informamos que cualquier forma de distribu=
ci=C3=B3n, reproducci=C3=B3n o uso de esta comunicaci=C3=B3n y/o de la =
informaci=C3=B3n contenida en la misma est=C3=A1n estrictamente prohibi=
dos por la ley. Si Ud. ha recibido esta comunicaci=C3=B3n por error, po=
r favor, notif=C3=ADquelo inmediatamente al remitente contestando a est=
e mensaje y proceda a continuaci=C3=B3n a destruirlo. Gracias por su co=
laboraci=C3=B3n.

This communication contains confidential information. It is for the exc=
lusive use of the intended addressee. If you are not the intended addre=
ssee, please note that any form of distribution, copying or use of this=
 communication or the information in it is strictly prohibited by law. =
If you have received this communication in error, please immediately no=
tify the sender by reply e-mail and destroy this message. Thank you for=
 your cooperation.=0D

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
