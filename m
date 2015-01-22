From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/4] x86: pmc_atom: print index of device in loop
Date: Thu, 22 Jan 2015 11:40:49 +0200
Message-ID: <1421919649.31903.123.camel@linux.intel.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1421790603-30097-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <54C07247.20902@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18856 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbbAVJky (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jan 2015 04:40:54 -0500
In-Reply-To: <54C07247.20902@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 2015-01-22 at 11:45 +0800, Li, Aubrey wrote:
> On 2015/1/21 5:50, Andy Shevchenko wrote:
> > The register mapping may change from one platform to another. Thus, indices
> > might be not the same on different platforms. The patch makes the code to print
> > the device index dynamically at run time.
> 
> Will another platform use the same table but different bit position? In
> my opinion, different platform should use different mapping table.

Yes, indeed.

The only improvement I could suggest now is to use indices for bit field
name from one array of possible names.

Or use macro to fill the item like 
#define BIT_X(bitname) { .name = __stringify(bitname), .bit_mask = BIT_
## bitname, }


> > 
> > The patch also changes the for loop to iterate over the map until a terminator
> > is found.
> 
> Why do we need to do this? did you see any hurt from the existing
> implementation?

Just a micro optimization plus it allows in consequent patches to avoid
size members in the pmc_reg_map.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

