From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Thu, 06 Mar 2014 08:43:20 -0300
Message-ID: <20140306084320.539ec76e@samsung.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
 <20140306111852.GA24629@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:20497 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbaCFLn2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Mar 2014 06:43:28 -0500
Received: from uscpsbgm2.samsung.com
 (u115.gpu85.samsung.co.kr [203.254.195.115]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N2000HECJ8SCM50@mailout2.w2.samsung.com> for
 linux-acpi@vger.kernel.org; Thu, 06 Mar 2014 06:43:40 -0500 (EST)
In-reply-to: <20140306111852.GA24629@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org

Em Thu, 06 Mar 2014 12:18:52 +0100
Borislav Petkov <bp@alien8.de> escreveu:

> On Tue, Mar 04, 2014 at 04:23:16AM -0500, Chen, Gong wrote:
> > To avoid the confuision of usage for RAS related trace event, add
> > an unified RAS trace event stub.
> > 
> > Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> > ---
> >  drivers/edac/edac_mc.c    |  3 ---
> >  kernel/trace/Makefile     |  1 +
> >  kernel/trace/ras-traces.c | 12 ++++++++++++
> >  3 files changed, 13 insertions(+), 3 deletions(-)
> >  create mode 100644 kernel/trace/ras-traces.c
> > 
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index 33edd67..28c1695 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -33,9 +33,6 @@
> >  #include <asm/edac.h>
> >  #include "edac_core.h"
> >  #include "edac_module.h"
> > -
> > -#define CREATE_TRACE_POINTS
> > -#define TRACE_INCLUDE_PATH ../../include/ras
> >  #include <ras/ras_event.h>
> >  
> >  /* lock to memory controller's control array */
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index 1378e84..167193a 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -52,6 +52,7 @@ endif
> >  obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
> >  obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
> >  obj-$(CONFIG_KPROBE_EVENT) += trace_kprobe.o
> > +obj-$(CONFIG_TRACEPOINTS) += ras-traces.o
> 
> Actually I was thinking of slowly concentrating all the RAS stuff into
> arch/x86/ras/.
> 
> Just add arch/x86/ras/trace.c instead please.

I would prefer to keep this out of arch/, because there are some 
parts of the ras infra that aren't x86 specific.

So, it would be better to put those at /drivers/ras, and add a
"depends on X86" for the x86 specifics.

Going further, it also make sense to move the EDAC drivers into it.

Regards,
Mauro
