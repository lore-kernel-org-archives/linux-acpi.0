From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Tue, 23 Feb 2010 12:11:54 +0100
Message-ID: <201002231211.54403.trenn@suse.de>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43908 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab0BWLL5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Feb 2010 06:11:57 -0500
In-Reply-To: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, mjg@redhat.com, rjw@sisk.pl

Hi,

On Tuesday 02 February 2010 23:37:59 akpm@linux-foundation.org wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> The kernel has a set of blacklist entries that disable ACPI functionality
> on various machines.  These all seem to date from pre-git days and most
> have no indication of what they were meant to fix.  Let's work on the
> assumption that we've fixed whatever it was that was broken before and so
> remove most of the entries.

> -	{
> -	 .callback = force_acpi_ht,
> -	 .ident = "IBM eserver xSeries 330",
> -	 .matches = {
> -		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
> -		     DMI_MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
> -		     },
> -	 },
For this one I can confirm that the blacklist is not needed with latest
kernel and the BIOS I use.
Beside the fact that this machine did not boot correctly due to wrongly
set up SCI irq since 2.6.31 (fixed via stable kernels now), the blacklist does
not match for my machine at all as only "System Information" and not the
"Base Board Information" used in the blacklist is filled in BIOS DMI data:

System Information
        Manufacturer: IBM
        Product Name: eserver xSeries 330 -[867411X]-

Base Board Information
        Manufacturer: IBM
        Product Name: Not Specified
 

I did not test whether the BIOS is up to date, though (and won't update, sorry):
Release Date: 09/20/2002

I'd also vote to remove the blacklist for ACPI test
(does this branch get synced into linux-next)?

    Thomas
