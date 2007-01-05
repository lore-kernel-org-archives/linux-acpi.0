From: Stelian Pop <stelian@popies.net>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 05 Jan 2007 10:58:00 +0100
Message-ID: <1167991081.8985.17.camel@localhost.localdomain>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <1167953784.4901.5.camel@localhost.localdomain>
	 <20070104154434.7e1a7c83.akpm@osdl.org>
	 <1167954872.4901.12.camel@localhost.localdomain>
	 <20070104201653.f1939617.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:3800 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161033AbXAEJ6I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 04:58:08 -0500
In-Reply-To: <20070104201653.f1939617.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

Le jeudi 04 janvier 2007 =E0 20:16 -0800, Andrew Morton a =E9crit :
> On Fri, 05 Jan 2007 00:54:32 +0100
> Stelian Pop <stelian@popies.net> wrote:
>=20
> > Le jeudi 04 janvier 2007 =E0 15:44 -0800, Andrew Morton a =E9crit :
> > > On Fri, 05 Jan 2007 00:36:23 +0100
> > > Stelian Pop <stelian@popies.net> wrote:
> > >=20
> > > > Added acpi_bus_generate event for forwarding Fn-keys pressed to=
 acpi subsystem,
> > > > and made correspondent necessary changes for this to work.
> > >=20
> > > neato.
> > >=20
> > > err, how does one use this?
> >=20
> > :)
> >=20
> > Well, it seems that on some Vaios (including Nilton's pcg-frv26 but=
 not
> > only this one), the Fn key events aren't seen by sonypi or sony_acp=
i
> > GHKE method, but do generate an ACPI notify event.
>=20
> Speak English ;)

Oh, sorry, I'll try again :)

There are several ways of detecting the Fn key events, depending on the
Vaio series:
	- some Vaios report them using the SPIC device (driven by sonypi)
	- some Vaios let the driver poll for the Fn key status using the GHKE
ACPI method of the SNC device (driven by sony_acpi)
	- some Vaios generate an ACPI notify event on the SNC device when a Fn
key is pressed - this is what the latest patch is for.

Unfortunately there are way too many different Vaio series, and no
information about what series support what method. I should have
maintained some sort of wiki to let the users build themselves a
comprehensive list, but I never get around to do it. Maybe Mattia could
do it if he has the time and will...

> > For those laptops, the patch forwards the ACPI event to the ACPI sy=
stem
> > and can be later interpreted in userspace using
> > acpid's /etc/acpi/default.sh (example directly from Nilton):
>=20
> The only things Mr Red Hat gave me are /etc/acpi/events/sample.conf a=
nd
> /etc/acpi/events/video.conf.

Well, there was an /etc/acpi/default.sh in an older version of acpid...
I'm not sure what it looks like now on a recent Fedora but on my Ubuntu
I still have an acpid package, which has some files in /etc/acpi/
looking familiar.

> I pressed then released a button and dmesg said
>=20
> [   76.961568] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value=
: 1
> [   76.961576] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: =
0
> [   76.963277] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value=
: 0
> [   76.963284] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: =
0
> [   76.967341] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value=
: 1
> [   76.967349] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: =
0
> [   76.968136] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value=
: 0
> [   76.968143] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: =
0
>=20
> Nothing else happened.

Well, you got the events from evdev, which means you probably got them
directly from sonypi (or the regular keyboard..)

Unless your distribution does some neat tricks and somehow feeds the
events coming from somewhere into the event subsystem (like Ubuntu's
acpi_fakekey for example...).

Stelian.
--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
