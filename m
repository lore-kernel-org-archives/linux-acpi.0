From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-usb-devel] [Bugme-new] [Bug 8190] New: ehci_hcd can't reinitialize scanner after suspend>resume
Date: Tue, 13 Mar 2007 09:19:33 +0100
Message-ID: <200703130919.33845.oneukum@suse.de>
References: <200703130751.l2D7pWks011303@fire-2.osdl.org> <20070313010057.e998fb6e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:48571 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965109AbXCMIWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Mar 2007 04:22:17 -0400
In-Reply-To: <20070313010057.e998fb6e.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-usb-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, linux-acpi@vger.kernel.org, bug-track@fisher-privat.net

Am Dienstag, 13. M=E4rz 2007 10:00 schrieb Andrew Morton:
> > On Tue, 13 Mar 2007 00:51:32 -0700 bugme-daemon@bugzilla.kernel.org=
 wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D8190
> >=20
> >            Summary: ehci_hcd can't reinitialize scanner after suspe=
nd>resume
> >     Kernel Version: 2.6.20, 2.6.21-rc3-gbe521466
> >             Status: NEW
> >           Severity: normal
> >              Owner: acpi_power-sleep-wake@kernel-bugs.osdl.org
> >          Submitter: bug-track@fisher-privat.net
> >=20
> >=20
> > Most recent kernel where this bug did *NOT* occur:
> > Distribution:gentoo 2006.1 i686-pc-linux-gnu
> > Hardware Environment:scanner epson perfection 1670, 82801G (ICH7 Fa=
mily) USB2
> > EHCI Controller
> >=20
> > Problem Description: with suspend to ram kernel will set scanner to=
 the standby
> > mode, but after resume kernel can't resume scanner _if_ ehci (modul=
e) is used.
> > With this issue sane can't use the scanner you need replug it to ma=
ke it use.
> >=20
> > This issue not upper if kernel compiled without ehci support.
> >=20
> > Steps to reproduce:
> > 1. compile kernel with ehci (module or build-in) and restart
> > 2. plugin scanner (sane is working)
> > 3. echo mem > /sys/power/state && scanner will be set to standby mo=
de too.
> > 4. resume && scanner will stay in standby mode
> > 5. replug the scanner to make it use.
> >=20
>=20
> Is this an ACPI bug, or a USB bug?

If any other USB device works, it is USB. Otherwise it may be both.

	Regards
		Oliver
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
