From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Thu, 6 Mar 2014 16:26:33 +0100
Message-ID: <20140306152633.GE24629@pd.tnic>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
 <20140306111852.GA24629@pd.tnic>
 <20140306084320.539ec76e@samsung.com>
 <20140306121714.GC24629@pd.tnic>
 <20140306100653.46249ea1@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34612 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbaCFP0k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2014 10:26:40 -0500
Content-Disposition: inline
In-Reply-To: <20140306100653.46249ea1@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

On Thu, Mar 06, 2014 at 10:06:53AM -0300, Mauro Carvalho Chehab wrote:
> For example PCIe and memory errors are not x86-specific. Also, as ACPI 
> may also be used on ARM, we may also start to have APEI errors there:
> 	https://lwn.net/Articles/574439/
> 	https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI
> 
> So, better to think on that on a long term.

kernel/ras/ could also be used in that case but I guess drivers/ras/ is
fine too.

> In order to put all RAS drivers under the same place. We may
> eventually have a subdir there for EDAC, and one per RAS report
> mechanism, in order to keep it cleaner.

That doesn't bring any advantages - edac drivers are just fine in
drivers/edac/. And without benefits for a move, it would be a senseless
code churn only.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
