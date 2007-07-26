From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Thu, 26 Jul 2007 11:01:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707261100130.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org> <200707260026.08183.lenb@kernel.org>
 <alpine.LFD.0.999.0707252353150.3442@woody.linux-foundation.org>
 <200707261345.29902.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50815 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935758AbXGZSCG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 14:02:06 -0400
In-Reply-To: <200707261345.29902.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On Thu, 26 Jul 2007, Len Brown wrote:
> 
> I was actually asking how somebody's _system_ has been degraded
> by this change -- but I haven't got an objective answer to that one yet.

According to that logic, we should always compile *everything* in.

Do you see the problem?

And can you realize that this should not have happened after -rc1?

So send me the patch to undo this breakage, and stop making excuses.

		Linus
