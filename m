From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Thu, 06 Mar 2014 10:06:53 -0300
Message-ID: <20140306100653.46249ea1@samsung.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
 <20140306111852.GA24629@pd.tnic> <20140306084320.539ec76e@samsung.com>
 <20140306121714.GC24629@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:22342 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaCFNG7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Mar 2014 08:06:59 -0500
Received: from uscpsbgm2.samsung.com
 (u115.gpu85.samsung.co.kr [203.254.195.115]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N2000GD0N3YM260@mailout2.w2.samsung.com> for
 linux-acpi@vger.kernel.org; Thu, 06 Mar 2014 08:07:10 -0500 (EST)
In-reply-to: <20140306121714.GC24629@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

Em Thu, 06 Mar 2014 13:17:14 +0100
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Mar 06, 2014 at 08:43:20AM -0300, Mauro Carvalho Chehab wrote:
> > I would prefer to keep this out of arch/, because there are some parts
> > of the ras infra that aren't x86 specific.
> 
> Those are?

For example PCIe and memory errors are not x86-specific. Also, as ACPI 
may also be used on ARM, we may also start to have APEI errors there:
	https://lwn.net/Articles/574439/
	https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI

So, better to think on that on a long term.

> > Going further, it also make sense to move the EDAC drivers into it.
> 
> Why?

In order to put all RAS drivers under the same place. We may eventually
have a subdir there for EDAC, and one per RAS report mechanism, in order
to keep it cleaner.

Regards,
Mauro
