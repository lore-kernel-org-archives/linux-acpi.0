From: Thomas Renninger <trenn@suse.de>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Mon, 18 Feb 2008 16:18:39 +0100
Message-ID: <1203347919.6019.79.camel@queen.suse.de>
References: <fmaaj5$jsl$1@ger.gmane.org>
	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>
	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:39318 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbYBRPSk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 10:18:40 -0500
In-Reply-To: <fmakts$gqs$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: giggz <giggzounet@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, 2008-01-12 at 16:02 +0100, giggz wrote:
> Matthew Garrett a =C3=A9crit :
> > On Sat, Jan 12, 2008 at 01:33:38PM +0100, giggz wrote:
> >=20
> >> What is the acpi video module ?
> >=20
> > If you have /proc/acpi/video, it's loaded.
> >=20
> >> I don't have any /var/log/acpid.log
>=20
> it seems to be normal that I don't have any /var/log/acpid.log :
> according to the NEWS.debian.gz from acpid package :
>=20
> " Starting with version 1.0.6 acpid uses syslog instead of its own lo=
gging
>   mechanism. During the upgrade of this package the old log files and=
 the
>   logrotate configuration file are backed up to
>   /var/backups/acpid-cruft.tar.gz and are removed from the filesystem=
=2E"
>=20
> So if I understand I must look at the syslog and message...but I don'=
t
> see anything in these two file...
>=20
> How can I increase the level of debugging ?
You can download the latest SUSE live-CD, there acpi debug is compiled
in.
Or you have to compile a kernel yourself and enable CONFIG_ACPI_DEBUG=3D=
y
When booted, unload polling ACPI drivers (to not pollute the logs):
rmmod battery
rmmod ac

Increase ACPI debug level:
echo 0x1F >/sys/module/acpi/parameters/debug_level
(or even: echo 0x21F >/sys/module/acpi/parameters/debug_level)
then hit the button and you should see some output.
Interesting e.g. would be if a notification "notify" appears and is sen=
t
to a vendor specific device.

> > In that case, try catting /proc/acpi/event and hit the button.
On SUSE, instead of stopping acpid, you can use:
acpi_listen
to log acpi events.

   Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
