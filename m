From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/8] ACPI: Prepare for constifying
 acpi_get_next_subnode() fwnode argument
Date: Fri, 21 Jul 2017 15:30:58 +0300
Message-ID: <1500640258.29303.176.camel@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
         <1500637177-16095-4-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59359 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbdGUMbD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 08:31:03 -0400
In-Reply-To: <1500637177-16095-4-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, erik.veijola@intel.com

On Fri, 2017-07-21 at 14:39 +0300, Sakari Ailus wrote:
> Make local variables const (head) or add new variables; adev was used
> for
> two purposes: to refer the root device node and its children. The two
> purposes are separated by this patch.
> 
> This is preparation for making fwnode arguments const for fwnode ops.
> Don't constify the argument itself quite yet as this is used as a
> callback
> function.

>  		if (child) {
> -			adev = to_acpi_device_node(child);
> -			next = adev->node.next;
> +			child_adev = to_acpi_device_node(child);
> +			next = child_adev->node.next;
>  			if (next == head) {
>  				child = NULL;
>  				goto nondev;
>  			}
> -			adev = list_entry(next, struct acpi_device,
> node);
> +			child_adev = list_entry(next, struct
> acpi_device, node);


Isn't it 

list_first_entry_or_null() ?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
