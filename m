From: Andrew Morton <akpm@osdl.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 4 Jan 2007 20:16:53 -0800
Message-ID: <20070104201653.f1939617.akpm@osdl.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	<200701040024.29793.lenb@kernel.org>
	<1167905384.7763.36.camel@localhost.localdomain>
	<20070104191512.GC25619@inferi.kami.home>
	<20070104125107.b82db604.akpm@osdl.org>
	<1167953784.4901.5.camel@localhost.localdomain>
	<20070104154434.7e1a7c83.akpm@osdl.org>
	<1167954872.4901.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:51307 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030312AbXAEESK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jan 2007 23:18:10 -0500
In-Reply-To: <1167954872.4901.12.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Fri, 05 Jan 2007 00:54:32 +0100
Stelian Pop <stelian@popies.net> wrote:

> Le jeudi 04 janvier 2007 =E0 15:44 -0800, Andrew Morton a =E9crit :
> > On Fri, 05 Jan 2007 00:36:23 +0100
> > Stelian Pop <stelian@popies.net> wrote:
> >=20
> > > Added acpi_bus_generate event for forwarding Fn-keys pressed to a=
cpi subsystem,
> > > and made correspondent necessary changes for this to work.
> >=20
> > neato.
> >=20
> > err, how does one use this?
>=20
> :)
>=20
> Well, it seems that on some Vaios (including Nilton's pcg-frv26 but n=
ot
> only this one), the Fn key events aren't seen by sonypi or sony_acpi
> GHKE method, but do generate an ACPI notify event.

Speak English ;)

> For those laptops, the patch forwards the ACPI event to the ACPI syst=
em
> and can be later interpreted in userspace using
> acpid's /etc/acpi/default.sh (example directly from Nilton):

The only things Mr Red Hat gave me are /etc/acpi/events/sample.conf and
/etc/acpi/events/video.conf.

> > case "$group" in
> >     button)
> >         case "$action" in
> >             power) /usr/sbin/hibernate
> >                 ;;
> >
> >             lid) cat /proc/acpi/button/lid/LID/state
> >                 ;;
> >=20
> >             *)  logger "ACPI action $action is not defined ($@)"
> >                 ;;
> >         esac
> >         ;;
> >=20
> >     SNC) echo "$@" > /dev/tcp/localhost/50007
> >         ;;
> >=20
> >     *) logger "ACPI group $group / action $action is not defined"
> >         ;;
> > esac
> >=20
> > In which I just forward the SNC event to another userspace applicat=
ion
> > listening on a TCP port.
>=20

I pressed then released a button and dmesg said

[   76.961568] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value: =
1
[   76.961576] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: 0
[   76.963277] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value: =
0
[   76.963284] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: 0
[   76.967341] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value: =
1
[   76.967349] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: 0
[   76.968136] evbug.c: Event. Dev: <NULL>, Type: 1, Code: 148, Value: =
0
[   76.968143] evbug.c: Event. Dev: <NULL>, Type: 0, Code: 0, Value: 0

Nothing else happened.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
