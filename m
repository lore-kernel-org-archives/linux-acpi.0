From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1 3/3] x86/platform/intel-mid: Add special handling of
 ACPI HW reduced platforms
Date: Fri, 19 Jan 2018 09:15:25 +0100
Message-ID: <20180119081525.w3sdwm5xlbanqop2@gmail.com>
References: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
 <20180117173409.88136-3-andriy.shevchenko@linux.intel.com>
 <1516211032.7000.1049.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36671 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeASIP3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2018 03:15:29 -0500
Content-Disposition: inline
In-Reply-To: <1516211032.7000.1049.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, 2018-01-17 at 19:34 +0200, Andy Shevchenko wrote:
> > When switching to ACPI HW reduced platforms we still want to
> > initialize timers.
> > Override acpi_reduced_hw_init() to achieve that.
> 
> Just realized, that it may annihilate the other acpi_reduced_hw_init()
> on non-MID platforms...
> 
> Open to suggestions how would be better to deal with this (I really
> don't like the idea to spread MID quirks all over the code).
> 
> P.S. Patch 2 from the series still makes sense per se.

Ok, I'll apply patch #2 to tip:x86/platform.

Thanks,

	Ingo
