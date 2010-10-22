From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/9] ACPI, APEI patches for 2.6.37
Date: Fri, 22 Oct 2010 16:55:42 +0800
Message-ID: <1287737742.2862.241.camel@yhuang-dev>
References: <1287538620-7442-1-git-send-email-ying.huang@intel.com>
	 <alpine.LFD.2.00.1010220147560.27300@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49875 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005Ab0JVIzv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Oct 2010 04:55:51 -0400
In-Reply-To: <alpine.LFD.2.00.1010220147560.27300@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2010-10-22 at 13:50 +0800, Len Brown wrote:
> On Wed, 20 Oct 2010, Huang Ying wrote:
> 
> > [PATCH 2/9] Add lock-less version of bitmap_set/clear
> > [PATCH 3/9] lock-less NULL terminated single list implementation
> > [PATCH 4/9] lock-less general memory allocator
> 
> What kinds of tests has this lockless lib code been subject to?

These code are used by GHES only now. We have a test suite for GHES.
These code works well for GHES.

At the same time, we have test code dedicated for these lib too,
including stress testing.

> This is generic code, does it play on multiple architectures?

We have tested the code on x86_64 and i386 architectures. For some other
architectures, we have done compile testing. The code is quite simple,
so I think it should run properly on other architectures too.

Best Regards,
Huang Ying


