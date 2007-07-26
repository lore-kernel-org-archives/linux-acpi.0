From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Thu, 26 Jul 2007 11:16:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707261113360.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org> <200707260026.08183.lenb@kernel.org>
 <alpine.LFD.0.999.0707252353150.3442@woody.linux-foundation.org>
 <200707261345.29902.lenb@kernel.org>
 <Pine.LNX.4.64.0707261056010.4183@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55316 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936116AbXGZSQv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 14:16:51 -0400
In-Reply-To: <Pine.LNX.4.64.0707261056010.4183@asgard.lang.hm>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david@lang.hm
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On Thu, 26 Jul 2007, david@lang.hm wrote:
> 
> how about the fact that Linus found the problem becouse his system didn't work
> right?

No, it works, it just forces me to use a configuration that I'm not 
personally interested in on that particular machine.

I tend to like using minimal kernels. I don't use modules on most of my 
machines, and I actually look over my config. Maybe I'm odd. But I think 
it's a good thing to let people decide what they want (and what they do 
_not_ want) in their kernels.

I think forcing people to use CPU_HOTPLUG is a mistake. There's a reason 
that existed as a config option. The ACPI changes basically mean that the 
whole CPU_HOTPLUG config option is totally pointless, because everybody is 
forced to have it.

		Linus
