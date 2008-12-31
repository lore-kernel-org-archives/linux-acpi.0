From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking "brightness"
Date: Wed, 31 Dec 2008 03:24:12 +0000
Message-ID: <20081231032412.GA25598@srcf.ucam.org>
References: <1230088058.562.219.camel@rzhang-dt> <1230633250.5328.8.camel@dax.rpnet.com> <1230687781.562.249.camel@rzhang-dt> <20081231020146.GA24861@srcf.ucam.org> <1230692328.562.289.camel@rzhang-dt> <1230693119.562.300.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37977 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbYLaDYR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 22:24:17 -0500
Content-Disposition: inline
In-Reply-To: <1230693119.562.300.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, Dec 31, 2008 at 11:11:59AM +0800, Zhang Rui wrote:
> On Wed, 2008-12-31 at 10:58 +0800, Zhang Rui wrote:
> > always update pros.brightness no matter the backlight is changed
> > via procfs, hotkeys or sysfs.
> by the way, with this patch applied, we really don't need
> "actual_brightness" any more, at least for ACPI backlight class I/F.
> is there any chance that "actual_brightness" returns a different value
> from "brightness"?

Depending on _DOS, AC events can switch the backlight value without 
sending a notification. I don't /think/ it's worth worrying about that 
case, but it's still worth keeping the two attributes so that there's a 
consistent interface for userspace.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
