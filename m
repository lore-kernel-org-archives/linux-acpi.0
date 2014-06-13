From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/7 REVISION] trace, RAS: Add eMCA trace event interface
Date: Thu, 12 Jun 2014 23:08:33 -0400
Message-ID: <20140612230833.3c0f41b2@gandalf.local.home>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
	<1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
	<20140612092808.5f7bec5e@gandalf.local.home>
	<20140613021956.GA17509@gchen.bj.intel.com>
	<20140612230117.46758e3c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:58210 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750913AbaFMDIg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2014 23:08:36 -0400
In-Reply-To: <20140612230117.46758e3c@gandalf.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Thu, 12 Jun 2014 23:01:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 12 Jun 2014 22:19:57 -0400
> "Chen, Gong" <gong.chen@linux.intel.com> wrote:
> 
> > On Thu, Jun 12, 2014 at 09:28:08AM -0400, Steven Rostedt wrote:
> > > > +	TP_STRUCT__entry(
> > > > +		__field(u32, err_seq)
> > > > +		__field(u8, etype)
> > > > +		__field(u8, sev)
> > > > +		__field(u64, pa)
> > > > +		__field(u8, pa_mask_lsb)
> > > > +		__array(u8, fru_id, sizeof(uuid_le))
> > > > +		__string(fru_text, fru_text)
> > > > +		__array(u8, data, sizeof(struct cper_mem_err_compact))
> > > 
> > > The above array works, but I'm wondering why you don't just use the
> > > types themselves?
> > > 
> > > That is:
> > > 
> > > 		__field(uuid_le, fru_id)
> > > 		__field(struct cper_mem_err_compact, data)
> > > 
> > Every time when I use above codes I will hit some compiler error like
> > "error: conversion to non-scalar type requested". It looks some
> > data types like above (unless typedef) can't be used in __field.
> > Is it true? How to fix that?
> > 
> 
> Ah, that's a bug in the ftrace.h file. I'll need to test this against
> it to see what error it gives. I'll work on that tomorrow as it's
> bedtime for me now.

Wait, I take that back. I was thinking the error was with the
__array(). A __field() should work fine!

Can you post me the patch you did and the error you get when you
compile.

-- Steve
