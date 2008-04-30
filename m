From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc0
Date: Wed, 30 Apr 2008 11:55:57 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804301153100.2980@woody.linux-foundation.org>
References: <200804301420.11696.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51766 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758650AbYD3S40 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 14:56:26 -0400
In-Reply-To: <200804301420.11696.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org



On Wed, 30 Apr 2008, Len Brown wrote:
> 
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Ok, this clashed in some nasty ways in drivers/acpi/video.c due to the 
non-racy /proc file creation changes that came through Andrew. I fixed up 
the result, and it *looks* sane (and compiles), but I didn't actually test 
it, and I don't know the code well. Can you double-check.

There were some (smaller) rejects in drivers/misc/intel_menlow.c due to 
two different versions of the same patch from Julia Lawall (again, the 
other came through Andrew), and I picked the one from Andrew because it 
had the later date. But again, you should double-check.

		Linus
