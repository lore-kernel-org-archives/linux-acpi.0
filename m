From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 3/6] eeepc-laptop: enable Bluetooth for Asus EEE 901
Date: Fri, 09 Jan 2009 16:49:27 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091644201.20020@localhost.localdomain>
References: <200901092017.n09KHA3E014942@imap1.linux-foundation.org>
 <alpine.LFD.2.00.0901091623400.16697@localhost.localdomain>
 <20090109133908.631b0fc1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36591 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZAIVti (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:49:38 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD800L0D4MILH2D@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:49:30 -0600 (CST)
In-reply-to: <20090109133908.631b0fc1.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, santiago@crfreenet.org, corentincj@iksaif.net, mjg59@srcf.ucam.org



On Fri, 9 Jan 2009, Andrew Morton wrote:

> On Fri, 09 Jan 2009 16:24:09 -0500 (EST)
> Len Brown <lenb@kernel.org> wrote:
> 
> > the original version of this patch is already in my tree
> > queued for linus.
> 
> It's not in today's linux-next?

Yeah, and that was my fault.
When I saw your e-mail I remembered the patch -- it had been sent a while
back by a different author.  I found the original
it on a branch that I'd neglected to merge intot he acpi test branch,
and so it was not in linux-next.  So I cherry-picked it on top of my 
release branch that I've already asked Linus to pull.

If Linus has already pulled my tree, it will make it into the next batch.

sorry for the confusion.

thanks,
-Len
Intel Open Source Technology Center



