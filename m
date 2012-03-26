From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via
 initrd
Date: Sun, 25 Mar 2012 18:25:17 -0700
Message-ID: <4F6FC57D.3050404@zytor.com>
References: <1332512984-79664-1-git-send-email-trenn@suse.de> <201203240402.38749.trenn@suse.de> <4F6D50DD.4050306@zytor.com> <201203260245.43177.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:46016 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab2CZBZi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Mar 2012 21:25:38 -0400
In-Reply-To: <201203260245.43177.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, Al Viro <viro@zeniv.linux.org.uk>

On 03/25/2012 05:45 PM, Thomas Renninger wrote:
> Best would be if no distro specific mkinitrd magic is needed and it's
> just as easy as it is:
> cp DSDT.aml /boot/initrd-test
> cat /boot/initrd >>/boot/initrd-test
> and add a test boot entry to grub's menu.lst or whereever.
> Then developers would not have to look at distro specific implementations
> (which should not exist) about how to test a table quickly.

There is no distro-specific magic needed.  What I'm proposing is
basically what you have above, except that your DSDT.aml would be
wrapped in a cpio header.  What I would like to ask from you is if it
makes sense to have kernel/acpi/DSDT, kernel/acpi/SSDT and so on, or
just make it a single kernel/acpi member.

By wrapping in a cpio container it becomes a generic mechanism.

>> By the way, if "relying on the bootloader" was an option in any way
> 
> Why exactly is a change in the bootloader not an option?
> Not sure whether a version number is passed, but the magic number could be
> changed for now.

There are a lot of bootloaders, and one of the most commonly used ones
has a very adversarial relationship with the kernel maintainers.

> If the new magic number is passed, we get a linked list.

The linked list stuff is already supported.  This interface has been
supported in the kernel since 2007.

	-hpa
