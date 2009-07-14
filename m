From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Tue, 14 Jul 2009 13:55:07 +0100
Message-ID: <20090714125507.GA21992@srcf.ucam.org>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com> <1247574573.23871.8.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57710 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbZGNMzM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jul 2009 08:55:12 -0400
Content-Disposition: inline
In-Reply-To: <1247574573.23871.8.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net

On Tue, Jul 14, 2009 at 01:29:33PM +0100, Richard Purdie wrote:

> My main concern is that we don't start getting bug reports of 'missing'
> events and have clearly defined expectations of when we see what kind of
> events. For example, should an event be emitted when low battery causes
> the backlight to be limited? How about console blanking events turning
> off the backlight? Are there any other occasions we should be emitting
> change events and do we need to audit other drivers?

These are all good questions. I'm working through the drivers now, and 
there's definitely a few more that need doing.

> Also, are "userspace" and "kernel" as meaningful as they could be? Would
> "sysfs" and "hwkeys" make more sense and allow for other future hardware
> differences? Perhaps someone will tie the backlight to an ambient light
> sensor for example...

Yes, though we'd need to extend the interface slightly in that case to 
allow the information to be provided. The ALS case is a good one - if 
that ends up happening in-kernel then there probably shouldn't be a 
UI update.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
