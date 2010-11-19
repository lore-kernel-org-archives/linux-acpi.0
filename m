From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Fri, 19 Nov 2010 16:13:53 +0800
Message-ID: <1290154433.2903.50.camel@yhuang-dev>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55814 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab0KSIN5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Nov 2010 03:13:57 -0500
In-Reply-To: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 2010-11-19 at 16:10 +0800, Huang, Ying wrote:
> Hi, Len,
> 
> This is used by APEI ERST and GEHS. But it is a generic hardware
> error reporting mechanism and can be used by other hardware error
> reporting mechanisms such as EDAC, PCIe AER, Machine Check, etc.
> 
> The patchset is split from the original APEI patchset to make it
> explicit that this is a generic mechanism, not APEI specific bits.
> 
> [PATCH 1/2] Generic hardware error reporting mechanism
> [PATCH 2/2] Hardware error record persistent support

This patchset depends on version 5 of the lockless memory allocator
and list patchset as follow.

[PATCH -v5 0/3] Lockless memory allocator and list

Best Regards,
Huang Ying


