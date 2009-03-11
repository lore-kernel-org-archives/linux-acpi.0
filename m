From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 5/5] ACPI video: support _BQC/_BCL/_BCM methods that use index values
Date: Wed, 11 Mar 2009 01:19:36 +0000
Message-ID: <20090311011936.GB13472@srcf.ucam.org>
References: <1236672214.2820.123.camel@rzhang-dt> <20090310171000.GC2527@srcf.ucam.org> <1236734272.2820.137.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43092 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbZCKBTk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 21:19:40 -0400
Content-Disposition: inline
In-Reply-To: <1236734272.2820.137.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Wed, Mar 11, 2009 at 09:17:52AM +0800, Zhang Rui wrote:
> On Wed, 2009-03-11 at 01:10 +0800, Matthew Garrett wrote:

> > This hunk doesn't seem obviously related?
> I need to set the backlight in acpi_video_init_brightness, before video
> backlight device being registered.

Ah, got you.

> > Do we have any bugs that suggest there are boxes like this?
> > 
> No, we don't have one.
> So we should remove this check unless we've one _BCL like this?

I think print a warning in that case - it'd be helpful to find any that 
exist, but with luck we'll never see it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
