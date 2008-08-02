From: Thomas Renninger <trenn@suse.de>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sat, 2 Aug 2008 19:30:04 +0200
Message-ID: <200808021930.05643.trenn@suse.de>
References: <1217632817.4610.6.camel@hidalgo> <200808021848.16457.trenn@suse.de> <20080802173146.GA31166@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:59928 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbYHBSF0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Aug 2008 14:05:26 -0400
In-Reply-To: <20080802173146.GA31166@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Saturday 02 August 2008 07:31:46 pm Matthew Garrett wrote:
> On Sat, Aug 02, 2008 at 06:48:15PM +0200, Thomas Renninger wrote:
> > On Saturday 02 August 2008 06:59:52 pm Matthew Garrett wrote:
> > # Only process this on XP, not on Linux and Vista
> >                            If (LAnd (\WXPF, LNot (\WVIS)))
>
> The only way this statement makes sense is if both WXPF and WVIS can be
> true, which is only possible if Vista responds to all of the _OSI
> requests.
No.
The machines are Linux pre-loaded. They do support Linux!
There is no need to check for both variables for Windows specific code (
there are tons of \WVIS and \WXPF only checking).
The only way this statement makes sense is that they *do* check for Linux.

> > # Only process this on XP, not on Linux and Vista
> >                         If (LAnd (LNot (\WXPF), \WNTF))
>
> Actually, this is "Only execute on 2000, not on XP or higher".
Yes I mixed up XP and NT.


       Thomas
