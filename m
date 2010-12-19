From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / PCIe: Clear Root PME Status bits during early resume
Date: Sun, 19 Dec 2010 13:38:23 +0100
Message-ID: <201012191338.24070.rjw@sisk.pl>
References: <201012191149.40547.rjw@sisk.pl> <20101219113658.GH1263@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38345 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010Ab0LSMi6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Dec 2010 07:38:58 -0500
In-Reply-To: <20101219113658.GH1263@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sunday, December 19, 2010, Matthew Wilcox wrote:
> On Sun, Dec 19, 2010 at 11:49:40AM +0100, Rafael J. Wysocki wrote:
> > in pci_pm_default_resume_early() and not in the port's resume
> > routine, because it's generally necessary even if the PCI Express
> > port driver is not used).
> 
> We should make it impossible to not use the PCIe port driver.

Actually, that's not correct.  In some cases (e.g. _OSI doesn't allow us
to use PCIe native services), we simply can't use it (because it is unsafe
and leads to serious problems).

Thanks,
Rafael
