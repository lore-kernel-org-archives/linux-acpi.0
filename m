From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/9] Extended H/W error log driver
Date: Wed, 16 Oct 2013 12:56:46 -0400
Message-ID: <20131016125646.7141b580@gandalf.local.home>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
	<20131016160550.GG13608@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:52749 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932550Ab3JPQ4t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 12:56:49 -0400
In-Reply-To: <20131016160550.GG13608@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 Oct 2013 18:05:50 +0200
Borislav Petkov <bp@alien8.de> wrote:

 
> > For trace output format we still need further discussion. In the last
> > patch(support trace interface) I have to reserve previous Kconfig
> > format because I find once I put trace_event interface in the module,
> > it will not work. I will paste another trace patch(it only works when

What did not work?

> > acpi_extlog is builtin) for your answer.
> 
> I think to be able to define TRACE_EVENTs in modules, you need
> https://lwn.net/Articles/383362/
> 
> Steve, that still true?
> 

Take a look at samples/trace_events/

That's a module that uses TRACE_EVENTs.

What exactly is the problem here?


-- Steve
