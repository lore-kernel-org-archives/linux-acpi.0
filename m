From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Sat, 1 Dec 2007 02:17:40 -0800
Message-ID: <20071201021740.2e66b918.akpm@linux-foundation.org>
References: <200711302153.lAULrZ7n026255@imap1.linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE2FAE6A@orsmsx423.amr.corp.intel.com>
	<20071130142058.816d1693.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>
	<4750CC78.9070105@rtr.ca>
	<20071130190227.1976e682@laptopd505.fenrus.org>
	<4750D180.6080001@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34567 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169AbXLAKSs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Dec 2007 05:18:48 -0500
In-Reply-To: <4750D180.6080001@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, abelay@novell.com, lenb@kernel.org, mlord@pobox.com, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 30 Nov 2007 22:14:08 -0500 Mark Lord <lkml@rtr.ca> wrote:

> > latency. If your app cant take any latency, you should set those... and
> > the side effect is that the kernel will not do long-latency C-states or
> > P-state transitions..
> ..
> 
> I don't mind the cpufreq changing (actually, I want it to drop in cpugfreq
> to save power and keep the fan off), but the C-states just kill this app.

semi-OT: I was finding that disabling cpufreq altogether on the Vaio speeds up
`quilt push 1000' by a lot - around 30% iirc.

There do seem to be some unsophisticated decisions in there and we're losing quite
a bit of performance as a result.
