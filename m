From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 4/4] x86: Minimize SRAT messages
Date: Wed, 30 Mar 2011 21:40:56 -0700
Message-ID: <AANLkTin51ecq4weuzGaQ91eFisWPSircWJGu-UnndiuN@mail.gmail.com>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
	<20110225180634.422972243@gulag1.americas.sgi.com>
	<20110227120348.GE16453@elte.hu>
	<4D6BFA76.2060208@sgi.com>
	<20110301075128.GC12384@elte.hu>
	<alpine.LFD.2.02.1103302237200.1920@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:57504 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab1CaEk5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2011 00:40:57 -0400
In-Reply-To: <alpine.LFD.2.02.1103302237200.1920@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Mike Travis <travis@sgi.com>, David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Mar 30, 2011 at 7:38 PM, Len Brown <lenb@kernel.org> wrote:
> Hi Mike,
>
> How about a patch to stuff the srat info into a debugfs file,
> and another patch to delete the console printk entirely?

with the patch using memblock for allocate log buf early. this patch
is not needed.

Thanks

Yinghai
