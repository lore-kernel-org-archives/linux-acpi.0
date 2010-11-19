From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] Hardware error record persistent support
Date: Fri, 19 Nov 2010 12:01:12 -0800
Message-ID: <20101119120112.77f2636f.akpm@linux-foundation.org>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
	<1290154233-28695-3-git-send-email-ying.huang@intel.com>
	<AANLkTikPTYLELKMLOeB868rW9cN40897TRg0dtuN=zQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37026 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753421Ab0KSUCO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Nov 2010 15:02:14 -0500
In-Reply-To: <AANLkTikPTYLELKMLOeB868rW9cN40897TRg0dtuN=zQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 19 Nov 2010 07:52:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Nov 19, 2010 at 12:10 AM, Huang Ying <ying.huang@intel.com> wrote:
> > Normally, corrected hardware error records will go through the kernel
> > processing and be logged to disk or network finally. __But for
> > uncorrected errors, system may go panic directly for better error
> > containment, disk or network is not usable in this half-working
> > system. __To avoid losing these valuable hardware error records, the
> > error records are saved into some kind of simple persistent storage
> > such as flash before panic, so that they can be read out after system
> > reboot successfully.
> 
> I think this is totally the wrong thing to do. TOTALLY.
> 
> The fact is, concentrating about "hardware errors" makes this
> something that I refuse to merge. It's such an idiotic approach that
> it's disgusting.
> 
> Now, if this was designed to be a "hardware-backed persistent 'printk'
> buffer", and was explicitly meant to save not just some special
> hardware error, but catch all printk's (which may be due to hardware
> errors or oopses or warnings or whatever), that would be useful.
> 
> But limiting it to just some special source of errors makes this
> pointless and not ever worth merging.
> 

yep.  We already have bits and pieces in place for this: kmsg_dump,
ramoops, mtdoops, etc.  If your hardware has a non-volatile memory then
just hook it up as a backend driver for kmsg_dump.

