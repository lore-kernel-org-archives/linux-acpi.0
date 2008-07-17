From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Please pull ACPI updates
Date: Thu, 17 Jul 2008 12:12:11 -0700
Message-ID: <1216321931.6029.1.camel@brick>
References: <20080716214516.GA10777@basil.nowhere.org>
	 <200807170011.12184.rjw@sisk.pl>
	 <200807161633.01375.jbarnes@virtuousgeek.org>
	 <alpine.LFD.1.10.0807161639090.2835@woody.linux-foundation.org>
	 <487EE940.1050007@firstfloor.org>
	 <alpine.LFD.1.10.0807170752190.2959@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0807171402110.2965@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.180]:2484 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758879AbYGQTMO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 15:12:14 -0400
Received: by el-out-1112.google.com with SMTP id z25so29910ele.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jul 2008 12:12:13 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0807171402110.2965@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thu, 2008-07-17 at 14:49 -0400, Len Brown wrote:
> Andi, Jesse, Linus,
> 
> One thing I wish I had in git is a way to make this sequence easier...
> 
> Say I have a big topic branch with 30 patches in it.
> The 3rd patch turns out to have a bug in it, but the
> rest of the series is okay.  Today I invoke gitk on
> the branch and keep that open.
> Then I create a new topic branch at the broken patch.
> 
> I always consult ~/src/git/Documentation/git-reset.txt
> so I can remember the following sequence...
> 
> $ git reset --soft HEAD^
> $ edit
> $ git commit -a -c ORIG_HEAD
> 
> Now I've got the fixed 3rd patch checked in,
> but 27 patches in the original branch are hanging
> off the original broken 3rd patch.
> So I git-cherry-pick 27 patches
> I hope I get them in the right order and don't miss any...
> 
> It would be nice if we could somehow git rebase those
> 27 patches in a single command, but if we do,
> that pulls with it the broken 3rd patch.

git rebase --interactive

sounds like exactly what you are asking for.

Harvey

