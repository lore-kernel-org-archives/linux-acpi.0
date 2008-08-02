From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sat, 2 Aug 2008 17:59:52 +0100
Message-ID: <20080802165952.GA30580@srcf.ucam.org>
References: <1217632817.4610.6.camel@hidalgo> <1217696279-23848-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36929 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbYHBQ75 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Aug 2008 12:59:57 -0400
Content-Disposition: inline
In-Reply-To: <1217696279-23848-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Sat, Aug 02, 2008 at 06:57:57PM +0200, Thomas Renninger wrote:
> ThinkPads store OSI calls in separate variables and later
> check for NT/XP/VISTA specific code to process.
> 
> I lately saw a line on a ThinkPad checking for XP and VISTA
> at video device specific code.
> 
> So currently some ThinkPads run into code paths which should
> either run on XP or VISTA, but Linux might execute them both
> or in a way that is not intended by BIOS developers.

Could you please show the code in question? I think you're misdiagnosing 
the issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
