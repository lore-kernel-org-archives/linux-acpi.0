From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] [REPOST] Add Panasonic Laptop ACPI extras driver
Date: Fri, 22 Aug 2008 15:12:46 +0200
Message-ID: <87y72pkxbl.fsf@basil.nowhere.org>
References: <20080822030044.GT27587@prithivi.gnumonks.org>
	<48AE7FDE.3060907@linux.intel.com>
	<20080822105820.GC27101@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:40838 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYHVNMy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Aug 2008 09:12:54 -0400
In-Reply-To: <20080822105820.GC27101@prithivi.gnumonks.org> (Harald Welte's message of "Fri, 22 Aug 2008 18:58:20 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org

Harald Welte <laforge@gnumonks.org> writes:
>
> oh, sorry for my ignorance.  I just never got any confirmation and didn't see
> it in linux-2.6.git.  Probably I should start adding linux-next to my workflow.

Or the git tree of the subsystem you're submitting, but linux-next
is more convenient because it's all in one. The main annoyance is 
that you need git magic to update because they rebase all the time
(normal pull -u doesn't work)

>
> sorry once again for bothering you.

No problem. I must have forgotten to send out an ACK. I do merges
in batches and this sometimes happens.

-Andi
