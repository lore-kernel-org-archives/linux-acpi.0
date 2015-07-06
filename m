From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 4/5] x86: pmc_atom: Add Cherrytrail PMC interface
Date: Mon, 6 Jul 2015 17:44:25 +0200
Message-ID: <20150706154425.GA19665@gmail.com>
References: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1436192944-56496-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36916 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbbGFPoa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2015 11:44:30 -0400
Content-Disposition: inline
In-Reply-To: <1436192944-56496-5-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The patch adds CHT PMC interface. This exposes all the South IP device power
> states and S0ix states for CHT. The bit map of FUNC_DIS and D3_STS_0 registers
> for SoCs are consistent. The D3_STS_1 and FUNC_DIS_2 registers, however, are
> not aligned. This is fixed by splitting a common mapping on per register basis.
> 
> Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

That's a weird signoff sequence. I changed it to:

 Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Acked-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>

Thanks,

	Ingo
