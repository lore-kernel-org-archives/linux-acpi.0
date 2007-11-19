From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [RFC] ACPI interrupt statistics
Date: Mon, 19 Nov 2007 19:42:35 +0000
Message-ID: <200711191942.35575.carlos@strangeworlds.co.uk>
References: <200711030040.53126.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53879 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbXKSTnn (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 19 Nov 2007 14:43:43 -0500
In-Reply-To: <200711030040.53126.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

On Saturday 03 November 2007 04:40:53 Len Brown wrote:
> For your review and testing...
>
> The patch below exports interrupt counters from within ACPI
> so that developers can better understand the cause of ACPI interrupts.
>
> My intent is to have something like this built in by default
> starting in 2.6.25.  The version below applies to 2.6.21
> and is originally based on a patch by Luming Yu.

There have been a fair few changes since then, and this patch will probably 
need a fair bit of work.

1) Back in 2.6.21, acpi_subsys was defined as a 'struct subsystem' in 
acpi_bus.h - it's now a 'struct kset'

2) Greg KH has an RFC patch lined up that does even more work in this area - 
http://lkml.org/lkml/2007/11/2

3) From my limited understanding of the area and intent, this patch seems to 
be a combination of kset work + the interrupt support - could it be split 
into two functionally separate patches to cover these instead?

(Basically, the only bit I'm really interested in is the 
EXPORT_SYMBOL(acpi_subsys), as acpi_subsys can currently only be used from 
built-in drivers, which is preventing me from converting wmi.c to a module).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
