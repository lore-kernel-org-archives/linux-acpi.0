From: Len Brown <lenb@kernel.org>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Mon, 7 Jan 2008 17:43:03 -0500
Message-ID: <200801071743.04192.lenb@kernel.org>
References: <20071130142058.816d1693.akpm@linux-foundation.org> <200801071412.59964.lenb@kernel.org> <47829AA7.3020304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54538 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbYAGWoe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jan 2008 17:44:34 -0500
In-Reply-To: <47829AA7.3020304@rtr.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@infradead.org>, abelay@novell.com, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl

On Monday 07 January 2008 16:33, Mark Lord wrote:
> Len Brown wrote:
> > 1. Why does VMware need max_cstate=1 to load quickly?
> ..
> 
> Eh?  Nothing to do with "loading" anything,
> but rather it's simple responsiveness to guest keyboard
> input that we're experiencing trouble with.
> The guest OS is probably "broken" in that regard,
> but setting max_cstate=1 makes it usable here.

okay, then when vmware is loaded, but idle, please run powertop
http://www.lesswatts.org/projects/powertop

and report what you see for C-states, P-states
and wakeup sources.


> > 2. Why does the "max_csate=1" workaround help only
> >    on the dual-core boxes, while the single-core
> >    boxes still fail to load quickly?
> ..
> 
> Eh?  Setting max_cstate=1 helps on both single/dual core
> boxes/kernels here.  The alternative (newer) latency thing
> (that requires a custom kernel module to change on the fly)
> is the thing that had no effect at all on our single-core box,
> but did seem to help the dual-core more (not verified completely
> on dual-core though).

please report the contents of 
cat /proc/acpi/processor/CPU*/power
for both systems when the C-states are not limited.

what latency limit did you specific to the latency I/F?

thanks,
-Len
