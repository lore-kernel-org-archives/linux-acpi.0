From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Fri, 13 Nov 2009 00:04:02 -0800
Message-ID: <4AFD12F2.2090103@zytor.com>
References: <4AF7D820.5040503@kernel.org> <4AFA210B.3020207@kernel.org> <20091112073616.GA11365@elf.ucw.cz> <200911122032.46872.rjw@sisk.pl> <20091113073608.GB26127@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:39484 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbZKMIEq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2009 03:04:46 -0500
In-Reply-To: <20091113073608.GB26127@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On 11/12/2009 11:36 PM, Ingo Molnar wrote:
> 
> Physical constraints to allocations (which this is) should be expressed 
> early and with high priority, to make sure they can be met.
> 

Indeed, and in this case this means before bootmem allocator initialization.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

