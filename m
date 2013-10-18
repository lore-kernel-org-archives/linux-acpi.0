From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 0/9] Extended H/W error log driver
Date: Fri, 18 Oct 2013 11:20:54 +0200
Message-ID: <20131018092054.GB1007@pd.tnic>
References: <1382084624-10857-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382084624-10857-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com
Cc: joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2013 at 04:23:35AM -0400, Chen, Gong wrote:
> OK, this is the 3rd version. Hope it is the last one :-).

It looks ok to me so far, I'm guessing Tony you're picking this up or
should I?

> this version just updates some minors places and apply some Ack/Review
> information. In this version I remove the last patch for trace
> interface. Maybe it is time to build a new RAS trace interface to
> integrate all RAS related error report interfaces now.

Yeah, let's start small here by moving the CREATE_TRACE_POINTS macro
definition to something like arch/x86/ras/core.c and work slowly up from
there. We have ras_event.h for tracepoints already.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
