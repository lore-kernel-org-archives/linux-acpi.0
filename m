From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: disable NHM/WSM HW C-state auto-demotion (v3)
Date: Mon, 28 Feb 2011 11:08:50 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1102281105460.17782@x980>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
 <alpine.LFD.2.02.1101190035200.14668@x980>
 <alpine.LFD.2.02.1102160119430.843@x980>
 <AANLkTinVCvUkmX3pnSy_Ah3fOm6hV-jAPrQXAQ971xnS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:36478 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1B1QJP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2011 11:09:15 -0500
In-reply-to: <AANLkTinVCvUkmX3pnSy_Ah3fOm6hV-jAPrQXAQ971xnS@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> > Hardware C-state auto-demotion is a mechanism where the HW overrides
> > the OS C-state request, instead demoting to a shallower state,
> > which is less expensive, but saves less power.

> I'm interrested, for pytimechart, to have trace information of what
> actual c-state got reached after each idle request.
> Do you have any info on how to get that?

the actual c-state residency can be seen in the residency 
counters that are exported by turbostat.
However, at the time of the request/return the OS doesn't know
that it's request got demoted demoted (or un-demoted).

No, checking the counters is not something we want to
add to the idle entry/exit path -- they are not optimized for speed.

thanks,
Len Brown, Intel Open Source Technology Center

