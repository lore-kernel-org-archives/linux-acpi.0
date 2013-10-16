From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 0/9] Extended H/W error log driver
Date: Wed, 16 Oct 2013 20:00:38 +0200
Message-ID: <20131016180038.GO13608@pd.tnic>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
 <20131016160550.GG13608@pd.tnic>
 <20131016125646.7141b580@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131016125646.7141b580@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2013 at 12:56:46PM -0400, Steven Rostedt wrote:
> On Wed, 16 Oct 2013 18:05:50 +0200
> Borislav Petkov <bp@alien8.de> wrote:
> 
>  
> > > For trace output format we still need further discussion. In the last
> > > patch(support trace interface) I have to reserve previous Kconfig
> > > format because I find once I put trace_event interface in the module,
> > > it will not work. I will paste another trace patch(it only works when
> 
> What did not work?
> 
> > > acpi_extlog is builtin) for your answer.
> > 
> > I think to be able to define TRACE_EVENTs in modules, you need
> > https://lwn.net/Articles/383362/
> > 
> > Steve, that still true?
> > 
> 
> Take a look at samples/trace_events/
> 
> That's a module that uses TRACE_EVENTs.
> 
> What exactly is the problem here?

Right, the only difference I can see is that include/ras/ras_event.h
doesn't have those below:

#undef TRACE_INCLUDE_PATH
#undef TRACE_INCLUDE_FILE
#define TRACE_INCLUDE_PATH .

Perhaps that is the problem?

Gong, what is exactly the issue you're observing?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
