From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: disable the ACPI backlight control on laptops with buggy _BCL methods
Date: Thu, 8 Jan 2009 03:32:50 +0000
Message-ID: <20090108033250.GA2550@srcf.ucam.org>
References: <1231383496.20746.44.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39625 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbZAHDc6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jan 2009 22:32:58 -0500
Content-Disposition: inline
In-Reply-To: <1231383496.20746.44.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, trenn@suse.de

On Thu, Jan 08, 2009 at 10:58:16AM +0800, Zhang Rui wrote:

> Some users used to control the backlight via the platform interface.
> But commit c3d6de698c84efdbdd3781b7058bcc339ab43da8 disables the platform
> backlight control if ACPI video backlight control is available.
> 
> This breaks the laptops with buggy _BCL/_BCM/_BQC methods. i.e. only ACPI
> backlight I/F are available on these laptops but they don't work.
> 
> With this patch applied, the ACPI backlight control are disabled instead
> on these laptops.

Why? These all seem to behave consistently, so I can't see any problem 
with us simply adding support for this varient. Disabling the ACPI 
control when we have no idea whether there's a platform driver available 
for the machine doesn't seem like the right fix.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
