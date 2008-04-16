From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/7] ACPI: Introduce acpi_get_physical_pci_device
Date: Wed, 16 Apr 2008 20:14:54 +0100
Message-ID: <20080416191453.GA27128@srcf.ucam.org>
References: <1208372398.1784.348.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:51678 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbYDPUGQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Apr 2008 16:06:16 -0400
Content-Disposition: inline
In-Reply-To: <1208372398.1784.348.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

On Wed, Apr 16, 2008 at 08:59:58PM +0200, Thomas Renninger wrote:
> ACPI: Introduce acpi_get_physical_pci_device
> 
> This is the same as acpi_get_physical_pci_device, but checks whether
> the ACPI device's HID has a valid PCI value. This one should get
> enhanced (later or if accepted), so that the returned struct *device
> PCI device is further evaluated if it's a PCI bridge and the device
> behind that bridge should be returned then.
> Sanity checks were taken over from Matthew Garrett.

The comment isn't quite right. It checks whether the ADR is a likely PCI 
value, not a valid one.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
