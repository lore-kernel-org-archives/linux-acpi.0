From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Q] How to tell we're using the KMS (during suspend/resume)
	outside the graphics driver
Date: Wed, 10 Mar 2010 21:17:04 +0000
Message-ID: <20100310211704.GA29201@srcf.ucam.org>
References: <201003062236.09801.rjw@sisk.pl> <548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com> <20100310205618.GA28628@srcf.ucam.org> <201003102215.26232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52874 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0CJVRI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2010 16:17:08 -0500
Content-Disposition: inline
In-Reply-To: <201003102215.26232.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pauli Nieminen <suokkos@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net

On Wed, Mar 10, 2010 at 10:15:26PM +0100, Rafael J. Wysocki wrote:
> On Wednesday 10 March 2010, Matthew Garrett wrote:
> > As far as the ACPI video driver goes, acpi_get_physical_pci_device() 
> > will give you something to work with.
> 
> Hmm.  Did you mean acpi_get_physical_device()?

Ah, no, acpi_get_pci_dev.

> Which acpi_device should I call that for?

The video one. acpi_video_bus_check does something very similar to check 
whether the device actually exists.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
