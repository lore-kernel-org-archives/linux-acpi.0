From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Wed, 25 Jul 2007 23:55:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707252353150.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org> <200707251851.22777.lenb@kernel.org>
 <Pine.LNX.4.64.0707251917320.21378@asgard.lang.hm>
 <200707260026.08183.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57154 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754395AbXGZGzx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 02:55:53 -0400
In-Reply-To: <200707260026.08183.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On Thu, 26 Jul 2007, Len Brown wrote:
> 
> Feel free to share what you know about the benefits vs. the costs
> of maintaining CONFIG_ACPI_SLEEP as a build option.

Why don't you just make CONFIG_ACPI_SLEEP dependent on SOFTWARE_SUSPEND 
and STR?

> If you feel that your system has been degraded
> because it now includes what used to be excluded under
> CONFIG_ACPI_SLEEP=n, please let me know how.

I feel that I get asked to include a feature that 
 (a) I have no interest in on that machine
 (b) I didn't need to include before.

What was the advantage? And what was it that caused something like this to 
be a post-rc1 thing. That makes me really unhappy. This is a *regression*.

		Linus
