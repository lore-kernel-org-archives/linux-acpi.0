From: Stefan Seyfried <seife@suse.de>
Subject: Re: x60 - spontaneous thermal shutdown
Date: Mon, 11 Sep 2006 17:13:03 +0200
Message-ID: <20060911151303.GD17655@suse.de>
References: <20060904214059.GA1702@elf.ucw.cz> <20060911094607.GA14095@suse.de> <200609111610.37514.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:18858 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964843AbWIKPNT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Sep 2006 11:13:19 -0400
Content-Disposition: inline
In-Reply-To: <200609111610.37514.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI mailing list <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

On Mon, Sep 11, 2006 at 04:10:36PM +0200, Rafael J. Wysocki wrote:
> On Monday, 11 September 2006 11:46, Stefan Seyfried wrote:
> > On Mon, Sep 04, 2006 at 11:40:59PM +0200, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > x60 shut down after quite a while of uptime, in period of quite h=
eavy
> > > load:
> > >=20
> > > Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
> > > Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C),=
 shutting down.
> > > Sep  4 23:33:01 amd shutdown[32585]: shutting down for system hal=
t
> > > Sep  4 23:34:42 amd init: Switching to runlevel: 0
> > >=20
> > > I do not think cpu reached 128C, as I still have my machine... Di=
d
> > > anyone else see that?
> >=20
> > my usual suspect: use ec_intr=3D0.
>=20
> Is this a kernel command line parameter?

yes.

seife@susi:~> dmesg | grep "^ACPI: EC"
ACPI: EC polling mode.
seife@susi:~> cat /proc/cmdline
root=3D/dev/hda5 vga=3D0x317 sysrq=3Dyes resume=3D/dev/hda1  splash=3Ds=
ilent showopts ec_intr=3D0

with ec_intr=3D1 (default), you'll get "ACPI: EC interrupt mode."

> I'm having some suspend/resume related problems on HPC 6325 now, and =
they
> seem to be related to the embedded controller.

Well, polling mode is always on my "things to try"-list for those unspe=
cified
ACPI failures :-)
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
