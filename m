From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 06/13] ACPI: updates rtc-cmos device platform_data
Date: Mon, 5 Feb 2007 17:11:43 -0800
Message-ID: <20070205171143.b1f1be43.akpm@linux-foundation.org>
References: <200702060010.l160AEfC003735@shell0.pdx.osdl.net>
	<200702051707.35256.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:43070 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965430AbXBFBNB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 20:13:01 -0500
In-Reply-To: <200702051707.35256.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, len.brown@intel.com

On Mon, 5 Feb 2007 17:07:34 -0800
David Brownell <david-b@pacbell.net> wrote:

> By the way ... in case I was unclear about this, this does need to _follow_ the
> patch defining the rtc-cmos driver and its platform data.  Which I'm sure it
> does in the MM tree, as it does in my own patchsets.  :)
> 

Oh.  Len, please drop.

And, ideally, ack it - then I'll send both patches to Linus at the same time.
Thanks.
