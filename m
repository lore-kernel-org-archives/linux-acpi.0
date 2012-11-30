From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] aerdrv: Trace Event for AER
Date: Fri, 30 Nov 2012 18:36:35 +0100
Message-ID: <20121130173635.GD23034@liondog.tnic>
References: <20121129215443.5483.43364.stgit@grignak.americas.hpqcorp.net>
 <1354240279.6276.131.camel@gandalf.local.home>
 <20121130105311.GA6869@liondog.tnic>
 <1354275551.6276.140.camel@gandalf.local.home>
 <20121130134232.GD6869@liondog.tnic>
 <1354283631.6276.143.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354283631.6276.143.camel@gandalf.local.home>
Sender: linux-pci-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com, mchehab@redhat.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 30, 2012 at 08:53:51AM -0500, Steven Rostedt wrote:
> On Fri, 2012-11-30 at 14:42 +0100, Borislav Petkov wrote:
> 
> > So, it sounds to me like we should we move all RAS-specific tracepoints
> > to <trace/events/ras.h> and then in each usage site do:
> 
> Note, the CREATE_TRACE_POINTS must only be done in one location. Not
> every place. It creates the code that does the work to make the
> tracepoints show up in /debug/tracing/events/* as well as the callback
> code and other such things. If you define it in more than one .c file,
> then you will have linker issues due to the functions being created more
> than once.
> 
> > 
> > #define CREATE_TRACE_POINTS
> > #include <trace/events/ras.h>
> > 
> > Correct?
> 
> That's the default way to do things.

Ok, cool.

Lance, care to move the TP to a new header called
include/trace/events/ras.h in your next iteration of the patches?

I'll later move the mc_event TP there too and drop the RAS-specific TP
header.

Thanks.

-- 
Regards/Gruss,
    Boris.
