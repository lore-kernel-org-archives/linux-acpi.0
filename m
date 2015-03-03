From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v2 0/4] x86: pmc_atom: Add Cherrytrail support
Date: Tue, 03 Mar 2015 11:37:50 +0800
Message-ID: <54F52C8E.2050705@linux.intel.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com> <1424695552.14897.7.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42023 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbbCCDh7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Mar 2015 22:37:59 -0500
In-Reply-To: <1424695552.14897.7.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org

On 2015/2/23 20:45, Andy Shevchenko wrote:
> On Tue, 2015-01-20 at 23:49 +0200, Andy Shevchenko wrote:
>> This is the reworked patch series which had been sent earlier [1] to support
>> Intel CherryTrail SoC.
>>
>> The patches were tested on both BayTrail and CherryTrail SoCs.
>>
>> [1] https://patchwork.kernel.org/patch/5235891/
> 
> Aubrey, is everything is clear for you now? Can I send v3 with your
> Ack's?
> 

The patches overall look good to me, except a few minor comments need to
be addressed in the last conversation. For example, I think we don't
need patch 1/4 if we won't use dev_print. some other changes might be
necessary only if they makes code cleaner and works better.

Certainly, it would be better if other x86 maintainers can take a look
at these patches.

Thanks,
-Aubrey
>>
>> Changes to v1:
>>  - rebased on top of recent pmc_atom changes
>>  - cleaned up, reqorked and split to few smaller patches
>>
>> Andy Shevchenko (4):
>>   x86: pmc_atom: save struct device pointer in pmc
>>   x86: pmc_atom: print index of device in loop
>>   x86: pmc_atom: supply register mappings via pmc object
>>   PMC driver: Add Cherrytrail PMC interface
>>
>>  arch/x86/include/asm/pmc_atom.h |  25 ++++
>>  arch/x86/kernel/pmc_atom.c      | 270 +++++++++++++++++++++++++---------------
>>  2 files changed, 198 insertions(+), 97 deletions(-)
>>
> 
> 

