From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Wed, 31 Oct 2007 16:24:38 +0000
Message-ID: <200710311624.39428.cathectic@slackadelic.com>
References: <200710300336.43696.cathectic@slackadelic.com> <200710310018.19689.cathectic@slackadelic.com> <200710311221.11137.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:32891 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbXJaQXx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 12:23:53 -0400
In-Reply-To: <200710311221.11137.cathectic@slackadelic.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Nashif, Anas" <anas.nashif@intel.com>

On Wednesday 31 October 2007 12:21:10 Carlos Corbacho wrote:
> On Wednesday 31 October 2007 00:18:19 Carlos Corbacho wrote:
> > On Tuesday 30 October 2007 22:52:30 Carlos Corbacho wrote:
> > > On Tuesday 30 October 2007 18:18:22 Len Brown wrote:
> > > > When I consulted Anas about WMI, he recommended that Linux
> > > > expose WMI via CIMOM.  I think that this means we'd need
> > > > to invent a sysfs interface for this acpi->wmi driver
> > > > to expose the hooks to a user-space daemon, which
> > > > would then make sense of it in Linux's management framework.
> > >
> > > The main problem to overcome with a sysfs interface is that a
> > > WMI-ACPI call takes multiple values.
> >
> > So, thinking this over more carefully, whilst sysfs can probably be used
> > to export data, I'm not entirely convinced for using it to input
> > arbitrary data types, unless there's some way we can get round this?
>
> After sleeping on the matter, I'm now certain that sysfs is the wrong way
> to go for allowing userspace to access WMI-ACPI - we're trying to pass and
> return too much data for sysfs to handle.

On second thoughts, my other proposal won't work either - we'd end up with a 
mess of either ioctl's or sysctl's to call from userspace (I really should 
read up on my userspace interaction a bit more).

The sysfs proposal could be made to work, it will just be a little cumbersome 
(I'll have a go at implementing it and see how it works out).

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
