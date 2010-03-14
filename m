From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Sun, 14 Mar 2010 16:35:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003141610020.18869@sony>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <201002231211.54403.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:40161 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934983Ab0COBPi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:15:38 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA00CPEU5XUYW6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:15:37 -0500 (CDT)
In-reply-to: <201002231211.54403.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, mjg@redhat.com, rjw@sisk.pl

On Tue, 23 Feb 2010, Thomas Renninger wrote:

> > -	{
> > -	 .callback = force_acpi_ht,
> > -	 .ident = "IBM eserver xSeries 330",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
> > -		     DMI_MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
> > -		     },
> > -	 },

> For this one I can confirm that the blacklist is not needed with latest
> kernel and the BIOS I use.
...
> I'd also vote to remove the blacklist for ACPI test
> (does this branch get synced into linux-next)?

Thanks for the verification, Thomas.
Yes, this one is gone, with all the other force_acpi_ht entries.

Yes, the acpi test branch is included in linux-next.

cheers,
Len Brown, Intel Open Source Technology Center
