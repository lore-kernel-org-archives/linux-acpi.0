From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Q] How to tell we're using the KMS (during suspend/resume)
	outside the graphics driver
Date: Wed, 10 Mar 2010 20:56:18 +0000
Message-ID: <20100310205618.GA28628@srcf.ucam.org>
References: <201003062236.09801.rjw@sisk.pl> <201003091234.59598.rjw@sisk.pl> <alpine.LFD.2.00.1003091613390.30952@casper.infradead.org> <201003092208.28175.rjw@sisk.pl> <20100310055013.GC19518@linux-sh.org> <548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37154 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab0CJU4X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2010 15:56:23 -0500
Content-Disposition: inline
In-Reply-To: <548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pauli Nieminen <suokkos@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net

As far as the ACPI video driver goes, acpi_get_physical_pci_device() 
will give you something to work with. For the console-switching case, I 
think the most reasonable plan is probably to add a flag to the console 
drivers to indicate whether or not they support reprogramming the 
hardware themselves, and then walk all active console drivers. There'd 
need to be a way for fb drivers to tell fbcon that they can handle it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
