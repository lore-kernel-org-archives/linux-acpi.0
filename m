From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] ACPI/Processor: Rework processor throttling with work_on_cpu()
Date: Thu, 27 Feb 2014 00:49:24 +0100
Message-ID: <1578601.f4RF6O7QVQ@vostro.rjw.lan>
References: <1393419786-5275-1-git-send-email-tianyu.lan@intel.com> <9984522.UXi6hmLF20@vostro.rjw.lan> <530DF035.2090703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51468 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750891AbaBZXeX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Feb 2014 18:34:23 -0500
In-Reply-To: <530DF035.2090703@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: tj@kernel.org, jolsa@redhat.com, oleg@redhat.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, February 26, 2014 09:46:29 PM Lan Tianyu wrote:
> On 02/26/2014 09:30 PM, Rafael J. Wysocki wrote:
> > On Wednesday, February 26, 2014 09:03:05 PM Lan Tianyu wrote:
> >> acpi_processor_set_throttling() uses set_cpus_allowed_ptr() to make
> >> sure struct acpi_processor->acpi_processor_set_throttling() callback
> >> run on associated cpu. But the function maybe called in a worker which
> >> has been bound to a cpu. The patch is to replace set_cpus_allowed_ptr()
> >> with work_on_cpu().
> >>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >
> > OK
> >
> > I suppose we need this in -stable?
> 
> Yes.
> 
> >
> > Which series of -stable should it go to?  All of them or just recent?
> 
> I think it should be all of them.

OK, queued up as a fix for 3.14, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
