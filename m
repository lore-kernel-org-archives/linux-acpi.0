From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] merge 32/64 bits realmode wakeup code
Date: Sun, 30 Jan 2011 23:42:40 +0100
Message-ID: <201101302342.40977.rjw@sisk.pl>
References: <4D41EA12.1030402@free.fr> <201101292215.57292.rjw@sisk.pl> <20110130210441.150e1006@mat-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50671 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910Ab1A3Wmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Jan 2011 17:42:54 -0500
In-Reply-To: <20110130210441.150e1006@mat-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

On Sunday, January 30, 2011, matthieu castet wrote:
> Le Sat, 29 Jan 2011 22:15:57 +0100,
> "Rafael J. Wysocki" <rjw@sisk.pl> a =E9crit :
>=20
> > On Saturday, January 29, 2011, matthieu castet wrote:
> > > Rafael J. Wysocki a =E9crit :
> > > >=20
> > > > It _looks_ sane, but it will require some serious testing.  I'm
> > > > not sure, though, if we can get enough testing coverage without
> > > > actually committing that change.
> > > >=20
> > > > How much testing has it received so far?
> > > >=20
> > > Not too much only qemu with 1 and 2 core and a laptop with 1 cpu.
> > >=20
> > > Please note that with this patch we can also remove the gdt, idt,
> > > ldt stuff from arch/x86/kernel/acpi/wakeup_32.S
> >=20
> > That's correct, but those changes can wait.=20
> Any idea how to test this patch with more configurations ?
>=20
> Submitting it to tip ?=20
> But as resume regression showed, there aren't many user with 32 bits
> system using it.

No, I don't think there are too many users testing suspend with -tip on=
 x86-32.
I'm afraid the changes in question won't get any substantial testing un=
til
included into the mainline, but it will be easier to diagnose problems =
with
them if they go in during the .39 merge window.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
