From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi: simplify module_param namespace
Date: Thu, 02 Apr 2009 22:44:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904022243420.9182@localhost.localdomain>
References: <200903071328.28113.rusty@rustcorp.com.au>
 <200903110927.12792.rusty@rustcorp.com.au>
 <20090311145124.696b2448.sfr@canb.auug.org.au>
 <200903120907.20055.rusty@rustcorp.com.au>
 <alpine.LFD.2.00.0904021659190.4660@localhost.localdomain>
 <20090402212625.GA8502@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:43253 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZDCCpK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Apr 2009 22:45:10 -0400
In-reply-to: <20090402212625.GA8502@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Stephen Rothwell <sfr@canb.auug.org.au>, yakui_zhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2 Apr 2009, Sam Ravnborg wrote:

> > +
> > +processor-objs	+= processor_core.o processor_throttling.o \
> > +				processor_idle.o processor_thermal.o
> > +ifdef CONFIG_CPU_FREQ
> > +processor-objs	+= processor_perflib.o
> > +endif
> 
> It would be nicer to do:
> processor-y := processor_core.o processor_throttling.o
> processor-y += processor_idle.o processor_thermal.o
> processor-$(CONFIG_CPU_FREQ) += processor_perflib.o
> 
> Assuming processor-objs was not assinged before in this file.
> 
> 	Sam

Can-do.
In Rusty's defense, these lines were in his patch simply because he moved 
them.

thanks,
Len Brown, Intel Open Source Technology Center

