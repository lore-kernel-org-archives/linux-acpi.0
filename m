From: Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH 32/70] ACPI: fix checkpatch.pl complaints in scan.c
Date: Fri, 20 Jun 2008 13:59:59 -0700
Message-ID: <1213995600.31598.40.camel@promb-2n-dhcp368.eng.vmware.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
	 <ad7f0d9feee6980a3ab3ea806854f56817d1da8e.1213947350.git.len.brown@intel.com>
	 <87lk0zanvo.fsf@basil.nowhere.org>
	 <1213993974.31598.31.camel@promb-2n-dhcp368.eng.vmware.com>
	 <485C157A.5080803@firstfloor.org>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.113.40.141]:54799 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbYFTVAG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jun 2008 17:00:06 -0400
In-Reply-To: <485C157A.5080803@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, 2008-06-20 at 13:39 -0700, Andi Kleen wrote:
> Alok Kataria wrote:
> > On Fri, 2008-06-20 at 12:48 -0700, Andi Kleen wrote:
> >> Len Brown <lenb@kernel.org> writes:
> >>
> >>> From: Alok N Kataria <akataria@vmware.com>
> >>>
> >>> http://bugzilla.kernel.org/show_bug.cgi?id=9772
> >> This bug has nothing to do with the patch?
> >>
> >> "This patch fixes the return value of acpi_eject_store()"
> >>
> >
> > This patch fixes the checkpatch.pl complaints introduced by patch in
> > comment 23 in that bug.
> > Please look here for the checkpatch.pl complaints..
> > http://bugzilla.kernel.org/show_bug.cgi?id=9772#c33
> 
> Well that's still not a very useful description, given that you fix
> a real bug here, not just the usual checkpatch whitspace nops.
> 
Maybe I am overlooking what you are trying to say over here.
but, Which real bug ?

> Not sure why Len also didn't fast track it. It seems to me like
> something .26-worthy.
> 

This patch modifies the code to use kthread_run instead of
kernel_thread. The kernel_thread call was introduced by an earlier patch
from Zhang Rui which is in comment 23. 

Since the patch from Zhang has not reached mainline yet, i fail to
understand how can this patch be worthy of .26 ?


Thanks,
Alok

> -Andi
> 
> 

