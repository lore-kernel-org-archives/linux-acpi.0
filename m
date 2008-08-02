From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sat, 2 Aug 2008 18:31:46 +0100
Message-ID: <20080802173146.GA31166@srcf.ucam.org>
References: <1217632817.4610.6.camel@hidalgo> <1217696279-23848-1-git-send-email-trenn@suse.de> <20080802165952.GA30580@srcf.ucam.org> <200808021848.16457.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33545 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbYHBRb5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Aug 2008 13:31:57 -0400
Content-Disposition: inline
In-Reply-To: <200808021848.16457.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Sat, Aug 02, 2008 at 06:48:15PM +0200, Thomas Renninger wrote:
> On Saturday 02 August 2008 06:59:52 pm Matthew Garrett wrote:
> # Only process this on XP, not on Linux and Vista
>                            If (LAnd (\WXPF, LNot (\WVIS)))

The only way this statement makes sense is if both WXPF and WVIS can be 
true, which is only possible if Vista responds to all of the _OSI 
requests.

> # Only process this on XP, not on Linux and Vista
>                         If (LAnd (LNot (\WXPF), \WNTF))

Actually, this is "Only execute on 2000, not on XP or higher".

> Amazing, it looks like they already check for Linux by checking if
> OSI returned true on two major Windows versions which would indicate
> Linux running.

No, that's not true at all. You haven't shown any evidence that Windows 
only returns true to a single OSI string. In fact, doing so would tend 
to break BIOSes that haven't yet been updated for newer versions of 
Windows.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
