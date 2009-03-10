From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH]: ACPI: Add the dmi check to make acpi_enforce_resources strict
Date: Tue, 10 Mar 2009 12:39:50 +0000
Message-ID: <20090310123950.GA30016@srcf.ucam.org>
References: <1236687873.7060.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46270 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbZCJMj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 08:39:58 -0400
Content-Disposition: inline
In-Reply-To: <1236687873.7060.31.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tue, Mar 10, 2009 at 08:24:33PM +0800, yakui_zhao wrote:
> Subject: ACPI: Add the dmi check to make acpi_enforce_resources strict
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
>    On some boxes the SMBus PCI controller is not hidden. The SMbus I/O port
> will be accessed in AML code. If the i2c driver is still loaded for the SMbus
> PCI device, there is no synchronization between OS and BIOS. And the conflict
> will happen.
>    So the dmi check is added so that the acpi_enforce_resources is strict when
> the box falls into the dmi check table. In such case the i2c driver won't be
> loaded for the SMbus pci device.

I think the only safe behaviour here is to default to strict on all 
hardware.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
