From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/4] x86: pmc_atom: save struct device pointer in pmc
Date: Thu, 22 Jan 2015 11:29:45 +0200
Message-ID: <1421918985.31903.113.camel@linux.intel.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1421790603-30097-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <54C07190.3090403@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59007 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbAVJ3s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jan 2015 04:29:48 -0500
In-Reply-To: <54C07190.3090403@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 2015-01-22 at 11:42 +0800, Li, Aubrey wrote:
> On 2015/1/21 5:50, Andy Shevchenko wrote:
> > The change allows to use dev_printk() type of macros in the module functions.
> 
> The patch itself looks good to me, but not sure why do we need this
> change, will we use dev_prink in the subsequent patches?

Has no relations to the rest, indeed. Just found that would be easier to
send them together.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

