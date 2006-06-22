From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Thu, 22 Jun 2006 16:31:30 +0200
Message-ID: <6bffcb0e0606220731m53af3114t85be11f4de148035@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6CF0CF1@hdsmsx411.amr.corp.intel.com>
	 <20060621215946.5d27e1f1.akpm@osdl.org>
	 <20060622072029.GA19228@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:26825 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161149AbWFVObb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 10:31:31 -0400
Received: by py-out-1112.google.com with SMTP id z74so352346pyg
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jun 2006 07:31:30 -0700 (PDT)
In-Reply-To: <20060622072029.GA19228@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Arjan van de Ven <arjan@infradead.org>

Hi Ingo,

On 22/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Andrew Morton <akpm@osdl.org> wrote:
>
> > > It complains about this only the 1st time, even though
> > > this same code sequence runs for every (subsequent) ACPI interrupt.
>
> that is because the lock validator turns itself off after the first
> complaint.
>
> > Yes, lockdep uses the callsite of spin_lock_init() to detect the
> > "type" of a lock.
> >
> > But the ACPI obfuscation layers use the same spin_lock_init() site to
> > initialise two not-the-same locks, so lockdep decides those two locks
> > are of the same "type" and gets confused.
> >
> > We had earlier decided to remove that ACPI code which kmallocs a
> > single spinlock.  When that's done, lockdep will become unconfused.
> >
> > AFACIT it's all used for just two statically allocated locks anwyay.
>
> Ok, great! Find below the (tested) cleanup that also fixes the validator
> problem.

Problem fixed, thanks.

>
> (if ACPI wants to turn this into platform-independent code it should be
> a build-time and type-correct translation layer that understands things
> like DEFINE_SPINLOCK as well.)
>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
