From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/4] x86: Minimize SRAT messages
Date: Wed, 30 Mar 2011 22:38:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103302237200.1920@x980>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
 <20110225180634.422972243@gulag1.americas.sgi.com>
 <20110227120348.GE16453@elte.hu> <4D6BFA76.2060208@sgi.com>
 <20110301075128.GC12384@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:63995 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab1CaCjH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2011 22:39:07 -0400
In-reply-to: <20110301075128.GC12384@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Travis <travis@sgi.com>, David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Hi Mike,

How about a patch to stuff the srat info into a debugfs file,
and another patch to delete the console printk entirely?

thanks,
Len Brown, Intel Open Source Technology Center

