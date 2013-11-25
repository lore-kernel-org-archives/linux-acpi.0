From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 0/4] ACPI / bind: Simplify child devices lookup
Date: Mon, 25 Nov 2013 11:17:44 +0800
Message-ID: <5292C158.7090508@intel.com>
References: <2610478.KxPMyuOMok@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62383 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251Ab3KYDRt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Nov 2013 22:17:49 -0500
In-Reply-To: <2610478.KxPMyuOMok@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On 11/25/2013 08:09 AM, Rafael J. Wysocki wrote:
> Hi,
> 
> The following series of four patches (on top of current linux-pm.git/bleeding-edge)
> rework child device lookup in drivers/acpi/glue.c and related things:
> 
> [1/4] ACPI / bind: Simplify child device lookup
> [2/4] PCI/ ACPI: Use acpi_find_child_device() for child device lookup
> [3/4] ACPI / bind: Redefine acpi_get_child()
> [4/4] ACPI / bind: Redefine acpi_preset_companion()
> 
> Thanks!
> 

Reviewed-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Aaron Lu <aaron.lu@intel.com> #for ATA binding
