From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: DMI information for Dell Latitude E4300
Date: Tue, 9 Dec 2008 15:01:28 +0000
Message-ID: <20081209150128.GA18599@srcf.ucam.org>
References: <493E8186.6020705@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36170 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbYLIPBa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Dec 2008 10:01:30 -0500
Content-Disposition: inline
In-Reply-To: <493E8186.6020705@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Humann <ingo_humann@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Tue, Dec 09, 2008 at 03:32:38PM +0100, Ingo Humann wrote:

> The kernel option acpi_osi=Linux works better for me. When I use it, I 
> can use suspend to ram without complications. Without this kernel option 
> the computer freezes after awaking.

Update hal-info and pm-utils and it should work without the boot option.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
