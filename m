From: Stelian Pop <stelian@popies.net>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 05 Jan 2007 00:54:32 +0100
Message-ID: <1167954872.4901.12.camel@localhost.localdomain>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <1167953784.4901.5.camel@localhost.localdomain>
	 <20070104154434.7e1a7c83.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:3015 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030295AbXADXyf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jan 2007 18:54:35 -0500
In-Reply-To: <20070104154434.7e1a7c83.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

Le jeudi 04 janvier 2007 =E0 15:44 -0800, Andrew Morton a =E9crit :
> On Fri, 05 Jan 2007 00:36:23 +0100
> Stelian Pop <stelian@popies.net> wrote:
>=20
> > Added acpi_bus_generate event for forwarding Fn-keys pressed to acp=
i subsystem,
> > and made correspondent necessary changes for this to work.
>=20
> neato.
>=20
> err, how does one use this?

:)

Well, it seems that on some Vaios (including Nilton's pcg-frv26 but not
only this one), the Fn key events aren't seen by sonypi or sony_acpi
GHKE method, but do generate an ACPI notify event.

=46or those laptops, the patch forwards the ACPI event to the ACPI syst=
em
and can be later interpreted in userspace using
acpid's /etc/acpi/default.sh (example directly from Nilton):

> case "$group" in
>     button)
>         case "$action" in
>             power) /usr/sbin/hibernate
>                 ;;
>
>             lid) cat /proc/acpi/button/lid/LID/state
>                 ;;
>=20
>             *)  logger "ACPI action $action is not defined ($@)"
>                 ;;
>         esac
>         ;;
>=20
>     SNC) echo "$@" > /dev/tcp/localhost/50007
>         ;;
>=20
>     *) logger "ACPI group $group / action $action is not defined"
>         ;;
> esac
>=20
> In which I just forward the SNC event to another userspace applicatio=
n
> listening on a TCP port.

Stelian.
--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
