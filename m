From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI, CPU_IDLE: Add more information about C-states
Date: Thu, 14 Feb 2008 23:52:59 -0500
Message-ID: <200802142352.59859.lenb@kernel.org>
References: <20080212015036.GC32468@linux-os.sc.intel.com> <200802141541.20143.lenb@kernel.org> <924EFEDD5F540B4284297C4DC59F3DEE90BF92@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38377 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbYBOExN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 23:53:13 -0500
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE90BF92@orsmsx423.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 14 February 2008 19:42, Pallipadi, Venkatesh wrote:
> 
> >-----Original Message-----
> >From: Len Brown [mailto:lenb@kernel.org] 
> >Sent: Thursday, February 14, 2008 12:41 PM
> >To: Pallipadi, Venkatesh
> >Cc: linux-acpi@vger.kernel.org
> >Subject: Re: [PATCH] ACPI, CPU_IDLE: Add more information 
> >about C-states
> >
> >On Thursday 14 February 2008 11:52, Pallipadi, Venkatesh wrote:
> >> 
> >> 'usage' is a counter that counts every time we get into poll_idle
> >> routine. I also try to keep track of time spent in poll_idle, until
> >> need_resched sends us out. That time is accumulated in 'time'.
> >> Just have those to be consistent with other state and to be sure that
> >> powertop kind of tools wont get confused.
> >
> >yes, the consistency is good.
> >But my question is when and why we enter poll_idle at all.
> 
> Ohh. Ok. May be the ladder governor used it for a while, before we
> switch to menu governor. It should not increase later once system is
> fully up? Do you see it increasing later?

i haven't noticed it increase, but will look.

> >
> >> I agree with the 'power' number. I did not like that 
> >4294967295 there.
> >> But, I had to put some number higher than other C-states, maximum
> >> possible seemed logical. May be I can change the sysfs interface to
> >> print <NULL> or something like that for power?
> >
> >I dunno.  Somehow I like 0 to signify an unknown quantity
> >rather than a huge number.  If somebody actually looks at it
> >with a program,  they're going to have to special case either of them,
> >and 0 seems simpler.
> >
> 
> Yes. But, if we have a 0W Cn state in future? :-).

actually, the entire field is really worthless.
we all know that BIOS writers just take the example code
and use it multiple systems w/o changing these values.
Perhaps we should re-cosider exposing this field,
as it is mis-leading, at best...

-len
