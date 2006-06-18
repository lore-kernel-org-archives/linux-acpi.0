From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI for Toshiba TECRA M5
Date: Sun, 18 Jun 2006 14:27:05 +0100
Message-ID: <20060618132705.GB13697@srcf.ucam.org>
References: <44930BF8.3020300@triumf.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:53720 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932227AbWFRN1J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jun 2006 09:27:09 -0400
Content-Disposition: inline
In-Reply-To: <44930BF8.3020300@triumf.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zaher Salman <zaher@triumf.ca>
Cc: linux-acpi@vger.kernel.org

On Fri, Jun 16, 2006 at 03:52:24PM -0400, Zaher Salman wrote:

> I have a fairly new Toshiba Tecra M5 (Core duo) running Mandriva 2006 
> with kernel 2.6.16. ACPI support for this laptop is quite good including 
> battery, fan, thermal zone, cpu frequency, lid and power buttons etc. 
> The problem is that /sys/power/state has only standby and mem (no disk) 
> and I cannot figure out why. I also cannot get all the function buttons 
> to work (only the scree brightness and mute). Attached is the dmesg output.

suspend to disk isn't handled via ACPI - you need to make sure that 
CONFIG_SOFTWARE_SUSPEND is set and that you're passing a resume= 
parameter to the kernel.

Recent Toshibas don't use the same mechanism as before to trigger hotkey 
events. I don't think anyone's reverse engineered them yet.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
