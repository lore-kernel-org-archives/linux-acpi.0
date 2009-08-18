From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 5/7] PM: Asynchronous suspend and resume of PCI
 devices
Date: Tue, 18 Aug 2009 09:47:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908180947080.2995-100000@iolanthe.rowland.org>
References: <1250578628.5351.64.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758941AbZHRNrm@vger.kernel.org>
In-Reply-To: <1250578628.5351.64.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Tue, 18 Aug 2009, Zhang Rui wrote:

> On Mon, 2009-08-17 at 08:20 +0800, Rafael J. Wysocki wrote:
> > Set async_suspend for all PCI devices and PCIe port services.
> >=20
> =EF=BB=BFAlan said that we can not break the resume order of the uhci=
/ehci host
> controllers on some platforms.
>=20
> For example,
> 00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UH=
CI
> Controller #4 (rev 02)
> 00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UH=
CI
> Controller #5 (rev 02)
> 00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 E=
HCI
> Controller #2 (rev 02)
> 00:1a.7 must be resumed after 00:1a.0 and 00:1a.1
>=20
> please refer to this thread:
> http://marc.info/?l=3Dlinux-acpi&m=3D122996117918188&w=3D2
>=20
> So I'm afraid we can not suspend/resume the PCI devices in parallel,
> unless we add this off-tree dependency at the same time.

It's okay for testing.  The dependency is needed mostly for=20
resume-from-hibernation.

Alan Stern
