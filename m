From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Bugme-new] [Bug 12235] New: /sys/devices/virtual/backlight/acpi_video0/brightness has it backwards
Date: Tue, 16 Dec 2008 20:55:32 +0000
Message-ID: <20081216205532.GB14332@srcf.ucam.org>
References: <bug-12235-10286@http.bugzilla.kernel.org/> <20081216100023.2e437c8c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34526 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737AbYLPUzh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 15:55:37 -0500
Content-Disposition: inline
In-Reply-To: <20081216100023.2e437c8c.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, khashayar.lists@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>

On Tue, Dec 16, 2008 at 10:00:23AM -0800, Andrew Morton wrote:

> OK, that's weird.  I have a suspicion that we're about to find out that
> this is intentional, but I don't know what the fix is..

My recollection is that some BIOSes provide the list of brightness 
values in reverse order - someone posted a patch to sort them in-kernel, 
but I can't remember what happened to it. xbacklight will work because 
it triggers a direct write to the hardware if the acpi driver isn't 
loaded.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
