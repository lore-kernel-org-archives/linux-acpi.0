From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 13/14] ACPI: use PNPID:instance_no as bus_id of ACPI
	device
Date: Fri, 08 Dec 2006 09:05:51 +0800
Message-ID: <1165539951.18470.5.camel@localhost.localdomain>
References: <1165496265.11485.87.camel@localhost.localdomain>
	 <20061207130246.GB19142@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31572 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164314AbWLHBBz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 20:01:55 -0500
In-Reply-To: <20061207130246.GB19142@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thu, 2006-12-07 at 08:02 -0500, Dave Jones wrote:
> On Thu, Dec 07, 2006 at 08:57:45PM +0800, Zhang Rui wrote:
>  > +		memset(acpi_device_bus_id, sizeof(struct acpi_device_bus_id), 0);
> 
> Bzzzrrrt,  Swapped args.
> 
> 		Dave
Yes, that's really a careless mistake :(
Thanks for pointing it out. I'll refresh the patch.

Thanks,
Ray
