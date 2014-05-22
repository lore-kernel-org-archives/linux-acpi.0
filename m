From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/7 v3] trace, AER: Move trace into unified interface
Date: Thu, 22 May 2014 12:41:08 +0200
Message-ID: <20140522104108.GF4383@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-3-git-send-email-gong.chen@linux.intel.com>
 <20140521101903.GC21205@pd.tnic>
 <20140522000348.GC1644@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:50296 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbaEVKlK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 06:41:10 -0400
Content-Disposition: inline
In-Reply-To: <20140522000348.GC1644@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Wed, May 21, 2014 at 08:03:48PM -0400, Chen, Gong wrote:
> On Wed, May 21, 2014 at 12:19:03PM +0200, Borislav Petkov wrote:
> > >  drivers/pci/pcie/aer/Kconfig           |  1 +
> > >  drivers/pci/pcie/aer/aerdrv_errprint.c |  4 +-
> > >  include/ras/ras_event.h                | 64 ++++++++++++++++++++++++++++
> > >  include/trace/events/ras.h             | 77 ----------------------------------
> > 
> > Ok, I don't understand: all the rest of the kernel holds tracepoints in
> > include/trace/events/. Why are you moving this at all?
> > 
> > Why can't the new extlog tracepoint in patch 5 be added to
> > include/trace/events/ras.h too?
> > 
> OMG. Again? Long time ago Mauro highly recommended me not putting new
> tracepoints under include/trace/events/ras.h, on the contrary, it shoud
> be put to include/ras/ras_event.h. But now the same story plays
> again. :-(

Hey Steve, can you help us out please? What is the rationale about
tracepoints and their place? Do we put them in include/trace/events/ or
do we put there only generic enough ones or do we define our own include
path, i.e., include/ras/ras_event.h for example, what is it?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
