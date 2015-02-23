From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] x86: pmc_atom: Add Cherrytrail support
Date: Mon, 23 Feb 2015 14:45:52 +0200
Message-ID: <1424695552.14897.7.camel@linux.intel.com>
References: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18307 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131AbbBWMp4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Feb 2015 07:45:56 -0500
In-Reply-To: <1421790603-30097-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-acpi@vger.kernel.org
Cc: Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org

On Tue, 2015-01-20 at 23:49 +0200, Andy Shevchenko wrote:
> This is the reworked patch series which had been sent earlier [1] to support
> Intel CherryTrail SoC.
> 
> The patches were tested on both BayTrail and CherryTrail SoCs.
> 
> [1] https://patchwork.kernel.org/patch/5235891/

Aubrey, is everything is clear for you now? Can I send v3 with your
Ack's?

> 
> Changes to v1:
>  - rebased on top of recent pmc_atom changes
>  - cleaned up, reqorked and split to few smaller patches
> 
> Andy Shevchenko (4):
>   x86: pmc_atom: save struct device pointer in pmc
>   x86: pmc_atom: print index of device in loop
>   x86: pmc_atom: supply register mappings via pmc object
>   PMC driver: Add Cherrytrail PMC interface
> 
>  arch/x86/include/asm/pmc_atom.h |  25 ++++
>  arch/x86/kernel/pmc_atom.c      | 270 +++++++++++++++++++++++++---------------
>  2 files changed, 198 insertions(+), 97 deletions(-)
> 


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

