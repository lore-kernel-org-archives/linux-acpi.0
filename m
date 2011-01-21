From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] printk: Allocate kernel log buffer earlier
Date: Thu, 20 Jan 2011 16:07:16 -0800
Message-ID: <20110120160716.d65c308b.akpm@linux-foundation.org>
References: <20110119230106.341785959@gulag1.americas.sgi.com>
	<20110119230106.527741713@gulag1.americas.sgi.com>
	<20110120155021.c39387c3.akpm@linux-foundation.org>
	<4D38CB72.2060503@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54702 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752700Ab1AUAID (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jan 2011 19:08:03 -0500
In-Reply-To: <4D38CB72.2060503@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <len.brown@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Lori Gilbertson <loriann@sgi.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 20 Jan 2011 15:55:30 -0800
Mike Travis <travis@sgi.com> wrote:

> If I have:
> 
> void __init setup(void)
> {
> 	static int data;
> ...
> 
> Does data automatically get put into the initdata section?  Or does
> it need the __initdata tag as well?

It needs __initdata.  gcc doesn't know that __init and __initdata are
related things - as far as the compiler is concerned, they're all just
sections.

