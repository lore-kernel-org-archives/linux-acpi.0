From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI / PCIe / AER: Disable native AER service if BIOS
 has precedence (v2) (was: Re: [PATCH]  PCI / PCIe / AER ...)
Date: Fri, 24 Sep 2010 09:53:55 -0700
Message-ID: <20100924095355.36a7b064@jbarnes-desktop>
References: <201009200002.15609.rjw@sisk.pl>
	<4C96FCA3.2060704@linux.intel.com>
	<201009201850.00626.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpoproxy1-pub.bluehost.com ([69.89.21.11]:37911 "HELO
	cpoproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755394Ab0IXQx6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Sep 2010 12:53:58 -0400
In-Reply-To: <201009201850.00626.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chen Gong <gong.chen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 20 Sep 2010 18:50:00 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday, September 20, 2010, Chen Gong wrote:
> > =E4=BA=8E 9/20/2010 6:02 AM, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > > From: Rafael J. Wysocki<rjw@sisk.pl>
> > >
> > > There is a design issue related to PCIe AER and _OSC that the BIO=
S
> > > may be asked to grant control of the AER service even if some
> > > Hardware Error Source Table (HEST) entries contain information
> > > meaning that the BIOS really should control it.  Namely,
> > > pcie_port_acpi_setup() calls pcie_aer_get_firmware_first() that
> > > determines whether or not the AER service should be controlled by
> > > the BIOS on the basis of the HEST information for the given PCIe
> > > port.  The BIOS is asked to grant control of the AER service for
> > > a PCIe Root Complex if pcie_aer_get_firmware_first() returns 'fal=
se'
> > > for at least one root port in that complex, even if all of the ot=
her
> > > root ports' HEST entries have the FIRMWARE_FIRST flag set (and no=
ne
> > > of them has the GLOBAL flag set).  However, if the AER service is
> > > controlled by the kernel, that may interfere with the BIOS' handl=
ing
> > > of the error sources having the FIRMWARE_FIRST flag.  Moreover,
> > > there may be PCIe endpoints that have the FIRMWARE_FIRST flag set=
 in
> > > HEST and are attached to the root ports in question, in which cas=
e it
> > > also may be unsafe to ask the BIOS for control of the AER service=
=2E
> > >
> > > For this reason, introduce a function checking if there's at leas=
t
> > > one PCIe-related HEST entry with the FIRMWARE_FIRST flag set and
> > > disable the native AER service altogether if this function return=
s
> > > 'true'.

Applied the second patch to my linux-next branch, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
