From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 4/5] x86: pmc_atom: Add Cherrytrail PMC interface
Date: Mon, 6 Jul 2015 19:37:51 +0300
Message-ID: <CAHp75VfupS4FLu2jAmBL-Ja-ydb9+0-thD3pUbwrD+3StrE4dA@mail.gmail.com>
References: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1436192944-56496-5-git-send-email-andriy.shevchenko@linux.intel.com>
	<20150706154425.GA19665@gmail.com>
	<alpine.DEB.2.11.1507061747100.3916@nanos>
	<20150706155008.GA3095@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35693 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbbGFQhw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2015 12:37:52 -0400
In-Reply-To: <20150706155008.GA3095@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Jul 6, 2015 at 6:50 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Mon, 6 Jul 2015, Ingo Molnar wrote:
>>
>> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >
>> > > The patch adds CHT PMC interface. This exposes all the South IP device power
>> > > states and S0ix states for CHT. The bit map of FUNC_DIS and D3_STS_0 registers
>> > > for SoCs are consistent. The D3_STS_1 and FUNC_DIS_2 registers, however, are
>> > > not aligned. This is fixed by splitting a common mapping on per register basis.
>> > >
>> > > Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
>> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >
>> > That's a weird signoff sequence. I changed it to:
>> >
>> >  Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >  Acked-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
>>
>> It might lack a From: Kumar ...
>
> Yeah, and got lost due to a rebase. Will change it to that, to preserve
> authorship. Won't push it out before I hear back from Andy though.

To clarify: "It's based on the previous work done by Kumar P Mahesh."
and we can remove SoB. It's quite far from the code initially taken
from Kumar.

Would you like me to update the commit message accordingly?

-- 
With Best Regards,
Andy Shevchenko
