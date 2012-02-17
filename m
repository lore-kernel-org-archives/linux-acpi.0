From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] ACPI: Provide config option to disable BIOS
 brightness changes on power events
Date: Fri, 17 Feb 2012 19:37:42 +0000
Message-ID: <20120217193742.GA11132@srcf.ucam.org>
References: <1328282293-16551-1-git-send-email-mjg@redhat.com>
 <20120217192704.GB2707@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49470 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2BQThr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Feb 2012 14:37:47 -0500
Content-Disposition: inline
In-Reply-To: <20120217192704.GB2707@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Fri, Feb 17, 2012 at 08:27:04PM +0100, Pavel Machek wrote:
> Hi!
> 
> > The default ACPI behaviour is to instruct the BIOS to automatically change
> > brightness on power events. This may be undesirable for distributions who
> > manage brightness in userspace. Provide a config option that disables this
> > behaviour and leaves brightness control up to the OS.
> 
> Should this be configured during runtime?
> 
> Like... when userspace power management starts, it disables this?

This is ACPI-specific. It's not emulated by any of the other backlight 
drivers. There's no terribly easy way to have generic userspace handle 
it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
