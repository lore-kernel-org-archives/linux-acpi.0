From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Clear WAK_STS on resume
Date: Mon, 11 Aug 2008 14:51:04 +0200
Message-ID: <200808111451.06343.trenn@suse.de>
References: <20080806175818.GA27134@srcf.ucam.org> <48A0219B.9070907@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:47183 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbYHKMvJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 08:51:09 -0400
In-Reply-To: <48A0219B.9070907@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, len.brown@intel.com, pavel@suse.cz, rjw@sisk.pl

On Monday 11 August 2008 13:25:15 Andi Kleen wrote:
> Matthew Garrett wrote:
> > The leading other brand OS appears to clear the WAK_STS flag on resume.
> > When rebooted, certain BIOSes assume that the system is actually
> > resuming if it's still set and so fail to reboot correctly. Make sure
> > that it's cleared at resume time.
>
> Queued for test thanks.

This sounds like a bug fix, depending on what "fail to reboot correctly" 
exactly means, it sounds like a critical bug.
Shouldn't this still be queued for .27?
Test means for next .28-rc1 cycle?

       Thomas
