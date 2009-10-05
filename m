From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull request] ACPI Processor Aggregator Driver for
 2.6.32-rc1
Date: Mon, 5 Oct 2009 13:56:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0910051354450.3432@localhost.localdomain>
References: <alpine.LFD.2.00.0910030145140.25240@localhost.localdomain> <20091005033256.GA26592@balbir.in.ibm.com> <200910052159.24920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55228 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753042AbZJEU6p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 16:58:45 -0400
In-Reply-To: <200910052159.24920.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: balbir@linux.vnet.ibm.com, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Shaohua Li <shaohua.li@intel.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>



On Mon, 5 Oct 2009, Rafael J. Wysocki wrote:
> 
> This thing has already been merged, it appears: and it looks like a 
> total breakage of rules to me.

Well, Len pointed out to me that the NAK is kind of pointless, since it 
had no constructive alternatives to the issue. So he left it in as 
documentation, but until the scheduler people can actually _do_ something 
about the problem, their voice doesn't really matter, does it?

		Linus
