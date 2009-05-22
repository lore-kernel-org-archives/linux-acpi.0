From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI: Change the array size from 5 to 8
	for	acpi_bus_id
Date: Fri, 22 May 2009 10:08:58 +0800
Message-ID: <1242958138.8523.135.camel@localhost.localdomain>
References: <1242894335.8523.61.camel@localhost.localdomain>
	 <alpine.LFD.2.00.0905211425390.4390@localhost.localdomain>
	 <20090521190715.GA30375@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64684 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbZEVCHk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 22:07:40 -0400
In-Reply-To: <20090521190715.GA30375@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-05-22 at 03:07 +0800, Matthew Garrett wrote:
> On Thu, May 21, 2009 at 02:26:32PM -0400, Len Brown wrote:
> > what bad things happen if this patch is not applied --
> > do some of those strcpy()'s overflow?
> 
> Looks like there'd be issues with the change to the CPU name on systems 
> with lots of CPUs in ACPI.
What Matthew said is right.

On some boxes I want to change the ACPI processor bus id. And the new
bus id is generated as the following format:
	sprintf(acpi_device_bid(device), "CPU%X", cpu_id)
    
If the CPU number exceeds 255, the string length will exceed the array
size of acpi_bus_id.

Although it doesn't matter, it still looks not very good.  The reason
that it still can work is that the following three bytes are not used.

So I change the array size of acpi_bus_id from 5 to 8.

Thanks.    
> 

