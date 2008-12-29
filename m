From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: "I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI region SMBI"
Date: Mon, 29 Dec 2008 14:35:08 +0000
Message-ID: <20081229143508.GD31266@srcf.ucam.org>
References: <1230560872.2328.4.camel@rhapsody>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45659 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYL2OfL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Dec 2008 09:35:11 -0500
Content-Disposition: inline
In-Reply-To: <1230560872.2328.4.camel@rhapsody>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: The Holy ettlz <theholyettlz@googlemail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Dec 29, 2008 at 02:27:52PM +0000, The Holy ettlz wrote:
> Hello,
> 
> I see the following in dmesg. I don't know how report-worthy it is, but
> anyway:
> 
> ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI
> region SMBI 
> [0x1c00-0x1c0f]
> ACPI: Device needs an ACPI driver

Your ACPI tables use the smbus controller themselves, so using a native 
Linux driver could potentially result in race conditions and bizarre 
failures. If you're not trying to use your smbus controller directly 
then it's not really an issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
