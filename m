From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi/blacklist: enable OSI(Linux) on newer eeepc
Date: Sat, 21 Nov 2009 23:28:15 +0000
Message-ID: <20091121232815.GA17749@srcf.ucam.org>
References: <1258752548-9299-1-git-send-email-corentincj@iksaif.net> <20091121184503.GA15141@srcf.ucam.org> <71cd59b00911211322t45be6c92g2a0c78c03d7eb5e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48546 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbZKUX2W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Nov 2009 18:28:22 -0500
Content-Disposition: inline
In-Reply-To: <71cd59b00911211322t45be6c92g2a0c78c03d7eb5e9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Sat, Nov 21, 2009 at 10:22:45PM +0100, Corentin Chary wrote:

> I think we could add that patch to 2.6.32, then revert it in 2.6.33 (or later)
> when a eeepc-wmi driver (or wmi support inside eeepc-laptop) is available.
> And I don't think such a driver (patch) will be available before 2.6.32.
> 
> That means that owner of 1000h and 1005ha won't be able to use eeepc-laptop
> (camera, rfkill, hotkeys) without adding acpi_osi="Linux" manually in 2.6.32.
> 
> I know this is not a long term solution.

The reason I'm not keen is that hardware vendors seem to continue 
believing that Linux claims to be Linux - it's almost understandable for 
Asus when they're shipping 2.6.remotely_exploitable on their hardware, 
but Lenovo are still doing it for no obvious reason. I'm worried that 
even doing a single release with this defined will result in Asus 
pulling the same trick at some point in the future.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
