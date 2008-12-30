From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.28: How come some kernel options cannot be disabled for non-existent hardware?
Date: Tue, 30 Dec 2008 13:14:47 +0000
Message-ID: <20081230131447.GA14942@srcf.ucam.org>
References: <alpine.DEB.1.10.0812300641390.11356@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40253 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYL3NOv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 08:14:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0812300641390.11356@p34.internal.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Dec 30, 2008 at 07:25:42AM -0500, Justin Piszcz wrote:

> It still shows up as enabled and it is in dmesg shown above.  How come 
> some kernel options are enabled and cannot (easily?) be disabled for 
> hardware that does not exist in my machine?

It's enabled by the ATA_ACPI support so libata can handle ACPI-based 
drive hotswaps. You can check these by looking at the help for an option 
in make menuconfig. That'll tell you what's selecting an option.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
