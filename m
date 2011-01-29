From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] merge 32/64 bits realmode wakeup code
Date: Sat, 29 Jan 2011 22:15:57 +0100
Message-ID: <201101292215.57292.rjw@sisk.pl>
References: <4D41EA12.1030402@free.fr> <201101272354.00042.rjw@sisk.pl> <4D447C00.70709@free.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49425 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513Ab1A2VQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Jan 2011 16:16:42 -0500
In-Reply-To: <4D447C00.70709@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

On Saturday, January 29, 2011, matthieu castet wrote:
> Rafael J. Wysocki a =E9crit :
> > On Thursday, January 27, 2011, matthieu castet wrote:
> >> Hi,
> >>
> >> this patch merge 32 and 64 realmode wakeup code :
> >> - this mean less ifdef in code
> >> - we could remove now unused field in wakeup_header (pmode_*)
> >> - this allow to set the first 1 MB NX.
> >>
> >> Do you think it is safe on all X86 32 bit machine ?
> >>
> >> Matthieu
> >>
> >>
> >> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> >=20
> > It _looks_ sane, but it will require some serious testing.  I'm not=
 sure,
> > though, if we can get enough testing coverage without actually comm=
itting
> > that change.
> >=20
> > How much testing has it received so far?
> >=20
> Not too much only qemu with 1 and 2 core and a laptop with 1 cpu.
>=20
> Please note that with this patch we can also remove the gdt, idt, ldt=
 stuff from=20
> arch/x86/kernel/acpi/wakeup_32.S

That's correct, but those changes can wait.  The most urgent thing is t=
o fix
the resume regression at hand.  I guess we should ask the reporter's in
https://bugzilla.kernel.org/show_bug.cgi?id=3D27472 to test that patch,=
 right?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
