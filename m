From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] aerdrv: Trace Event for AER
Date: Fri, 30 Nov 2012 06:39:11 -0500
Message-ID: <1354275551.6276.140.camel@gandalf.local.home>
References: <20121129215443.5483.43364.stgit@grignak.americas.hpqcorp.net>
	 <1354240279.6276.131.camel@gandalf.local.home>
	 <20121130105311.GA6869@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:26232 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab2K3LjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Nov 2012 06:39:14 -0500
In-Reply-To: <20121130105311.GA6869@liondog.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com, mchehab@redhat.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2012-11-30 at 11:53 +0100, Borislav Petkov wrote:
> On Thu, Nov 29, 2012 at 08:51:19PM -0500, Steven Rostedt wrote:
> > >  include/ras/aer_event.h |   77 +++++++++++++++++++++++++++++++++++++++++++++++
> > 
> > Is there a reason this header is here? Egad, I never noticed the
> > ras_event.h that is there. This include/ras directory was created for
> > the sole purpose of trace events! This is not the way to do this.
> 
> Well, the idea for the ras event was to be able to use it in multiple
> places. It is currently used only by EDAC but it could be that memory
> errors could be reported by other agents which would reuse that TP.
> 

If it's generic, then place it into the include/trace/events directory,
the you don't need to have the TRACE_INCLUDE_PATH as that is the default
path the macros will use.

> > Please look at the sample in samples/trace_events/
> > 
> > The proper way is to keep the header by the driver. Then you can simply
> > include the header with "aer_event.h".
> > 
> > But to have the macro magic work, you need to modify the Makefile to
> > have something like:
> > 
> > CFLAGS_aerdrv_errprint.o = -I$(src)
> 
> So I'm guessing that every .c file including the TP should also -I
> include the TP definition header wherever it is. Is that agreeable?

You only need the -I$(src) for the .c file that uses the
CREATE_TRACE_POINTS macro, as the trace point macro magic headers
require it to find the TP header. Other files just need "foo.h", or
<trace/events/foo.h> if it's in the generic location.

-- Steve


