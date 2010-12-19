From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] PCI / PCIe: Clear Root PME Status bits during early
	resume
Date: Sun, 19 Dec 2010 04:36:58 -0700
Message-ID: <20101219113658.GH1263@parisc-linux.org>
References: <201012191149.40547.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:46531 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab0LSLhA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Dec 2010 06:37:00 -0500
Content-Disposition: inline
In-Reply-To: <201012191149.40547.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sun, Dec 19, 2010 at 11:49:40AM +0100, Rafael J. Wysocki wrote:
> in pci_pm_default_resume_early() and not in the port's resume
> routine, because it's generally necessary even if the PCI Express
> port driver is not used).

We should make it impossible to not use the PCIe port driver.
(This isn't a reason to not take this patch for now, just a direction
we should be heading in for the future).

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
