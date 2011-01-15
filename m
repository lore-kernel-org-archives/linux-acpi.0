From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: FW: ACPI Warning: Invalid length for Pm1aControlBlock: 32,
	using default 16 (20090903/tbfadt-607)
Date: Sat, 15 Jan 2011 23:00:54 +0000
Message-ID: <20110115230053.GA22873@srcf.ucam.org>
References: <88E058D95F1C6047975B85AB9C600B1F6DB20525AF@GVW1342EXA.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34123 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab1AOXBH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Jan 2011 18:01:07 -0500
Content-Disposition: inline
In-Reply-To: <88E058D95F1C6047975B85AB9C600B1F6DB20525AF@GVW1342EXA.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Berahalli, Sreenivasa Reddy" <sreenivasa-reddy.berahalli@hp.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jan 14, 2011 at 06:33:13PM +0000, Berahalli, Sreenivasa Reddy wrote:

> This warning message means the length of register in the ACPI tables and the default values are different.
> We see it as  over-aggressive check in Linux, with no issue.

Linux sees it as a deviation between the BIOS and the spec, which may 
cause issues if it turns out that we treat this behaviour differently to 
tested operating systems. Why not fix your BIOS?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
