From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PCI / PCIe/ AER: Introduce pci_aer_available()
Date: Tue, 3 Aug 2010 21:50:28 +0200
Message-ID: <201008032150.28626.rjw@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <201008022354.46369.rjw@sisk.pl> <AANLkTimZV8KSkAR5Tc0nDK=TmzX1edKiJ9qSSgZ8v0h9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33591 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069Ab0HCTwO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Aug 2010 15:52:14 -0400
In-Reply-To: <AANLkTimZV8KSkAR5Tc0nDK=TmzX1edKiJ9qSSgZ8v0h9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jike Song <albcamus@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday, August 03, 2010, Jike Song wrote:
> On Tue, Aug 3, 2010 at 5:54 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Introduce a function allowing the caller to check if PCIe AER should
> > be enabled.
> >
> 
> Maybe it's misnamed?  How about pcie_aer_disable is not set and MSI is
> enabled, but there is not AER capability implemented at all?

The BIOS is supposed to tell us about that or we will find out from the
registers contents.  This function tells us whether to _try_ to enable AER
(ie. ask the BIOS and so on).

Thanks,
Rafael
