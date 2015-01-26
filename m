From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v2 4/4] PMC driver: Add Cherrytrail PMC interface
Date: Mon, 26 Jan 2015 10:30:42 +0800
Message-ID: <54C5A6D2.5000005@linux.intel.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>	 <1421790603-30097-5-git-send-email-andriy.shevchenko@linux.intel.com>	 <54C07641.7090706@linux.intel.com> <1421918770.31903.111.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5493 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbbAZCap (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Jan 2015 21:30:45 -0500
In-Reply-To: <1421918770.31903.111.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 2015/1/22 17:26, Andy Shevchenko wrote:
> On Thu, 2015-01-22 at 12:02 +0800, Li, Aubrey wrote:
>> On 2015/1/21 5:50, Andy Shevchenko wrote:
>>> The patch adds CHT PMC interface. This exposes all the South IP device power
>>> states and S0ix states for CHT. The bit map of FUNC_DIS and D3_STS_0 registers
>>> for SoCs are consistent. The D3_STS_1 and FUNC_DIS_2 registers, however, are
>>> not aligned. This is fixed by splitting a common mapping on per register basis.
>>>
>> Should we define the bit map table completely separate for different
>> platforms? My concern is, when D3_STS_0 and FUNC_DIS becomes not
>> consistent in a new SoC, the implementation in this patch has to be
>> rewritten completely.
>>
>> Defining entire bit map table for different platform introduces
>> reduplicated bit definitions, but when we add a new platform in future,
>> we don't need to consider the existing platforms definition, and no need
>> to change code structure any longer.
>>
>> Thoughts?
>>
> 
> But this what I did by introducing pmc_reg_map structure per SoC.
> You may or may not use previous definitions.
> 
okay, it makes sense to me.

Thanks,
-Aubrey

