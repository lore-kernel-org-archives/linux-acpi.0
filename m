From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/7] ACPI, APEI patches for 2.6.39
Date: Wed, 02 Mar 2011 17:51:24 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1103021750250.12344@x980>
References: <1298267685-7357-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49552 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757660Ab1CBWvs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2011 17:51:48 -0500
In-reply-to: <1298267685-7357-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Mon, 21 Feb 2011, Huang Ying wrote:

> [PATCH 1/7] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
> [PATCH 2/7] lib, Add lock-less NULL terminated single list
> [PATCH 3/7] ACPI, APEI, Add ERST record ID cache
> [PATCH 4/7] PCIe, AER, use pre-generated prefix in error information printing
> [PATCH 5/7] ACPI, APEI, Add PCIe AER error information printing support
> [PATCH 6/7] lib, Make gen_pool memory allocator lockless
> [PATCH 7/7] ACPI, APEI, GHES, printk support for recoverable error via NMI

I've put this series into acpi-test, so it will be visible in linux-next;
but I'm not the right person to review the generic lockless stuff,
who is?

thanks,
-Len Brown Intel Open Source Technology Center
