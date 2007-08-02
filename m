From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Problem - disabling IRQ #20 and others
Date: Thu, 2 Aug 2007 11:31:46 -0700
Message-ID: <20070802113146.30eb2139.akpm@linux-foundation.org>
References: <ef8c225f0708010347l2a0a8e4cj4f47a243bba88989@mail.gmail.com>
	<f24d23310708010711w7cec4718tde8fd33b89fdfcf6@mail.gmail.com>
	<20070802014819.4760b06a.akpm@linux-foundation.org>
	<ef8c225f0708020427i6665d486he6a90f1f02823382@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48962 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753638AbXHBScT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Aug 2007 14:32:19 -0400
In-Reply-To: <ef8c225f0708020427i6665d486he6a90f1f02823382@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andev Debi <andev.debi@gmail.com>
Cc: debian developer <debiandev@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rl@hellgate.ch, Dave Airlie <airlied@linux.ie>

On Thu, 2 Aug 2007 16:57:42 +0530
"Andev Debi" <andev.debi@gmail.com> wrote:

> On 8/2/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> >> Please fix the wordwrapping before sending any more stuff - it's truly awful.
> >
> Sorry about that. Gmail automatically wraps the line. Will check in the future.
> 
> > Could be a bug in the via driver, but it's more likely an
> > acpi/pci/platform/bios thing.
> >
> CC'ing VIA Rhine network driver maintainer. May be he has any idea.

Sorry, I meant the VIA DRM driver.

> CC'ing ACPI people too.

I suspect that's getting warmer.

> > Did any previous kernels work OK?  If so, which?
> >
> 
> I booted with the stock ubuntu kernel 2.6.15-28-386, and it is showing
> a different irq (irq #201)being disabled.

OK, that's bad.


> Im attaching the dmesg of both stock 2.6.15 and self compiled 2.6.22.1-cfs-v19

For long-term bugs like this one it's best to track it in
bugzilla.kernel.org.  I'd suggest that you assign it to
acpi_config-interrupts@kernel-bugs.osdl.org and add airlied@linux.ie to the
cc.

It'll take a while, but these things often do end up fixed.
