From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
 acpi_os_validate_address interface"
Date: Wed, 1 Jul 2009 23:42:38 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308582EA5E7E2@orsmsx503.amr.corp.intel.com>
References: <1246415391.24831.30.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.0907012202580.19077@localhost.localdomain>
 <1246516045.3326.0.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55237 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbZGBGmi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 02:42:38 -0400
In-Reply-To: <1246516045.3326.0.camel@minggr.sh.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Before we start extending the existing mechanisms, I think we need to really think about a better solution.

Since there already appears to be a workaround for the problem, then this should give us some time to analyze this.

>-----Original Message-----
>From: Lin, Ming M
>Sent: Wednesday, July 01, 2009 11:27 PM
>To: Len Brown
>Cc: Thomas Renninger; Moore, Robert; Zhao, Yakui; linux-acpi
>Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
>acpi_os_validate_address interface"
>
>On Thu, 2009-07-02 at 10:03 +0800, Len Brown wrote:
>> I can't apply a patch that adds a known memory leak,
>> even if it removes a conflict between drivers.
>>
>> The reason is that there is a workaround for the driver conflict,
>> but no workaround for the memory leak.
>
>Here is a prototype simple patch, please review to see if it is the
>right way to go.
>
>1) add a new field "count" to struct acpi_res_list.
>
>   When inserting, if the region(addr, len) is already in the resource
>   list, we just increase "count", otherwise, the region is inserted
>   with count=1.
>
>   When deleting, the "count" is decreased, if it's decreased to 0,
>   the region is deleted from the resource list.
>
>   With "count", the region with same address and length can only be
>   inserted to the resource list once, so prevent potential memory leak.
>
>2) add a new function acpi_os_invalidate_address, which is called when
>   region is deleted.
>

