From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Wakeup and S states
Date: Thu, 16 Jun 2011 15:15:18 +0100
Message-ID: <20110616141517.GB15242@srcf.ucam.org>
References: <4DF8CBC3.5070801@cfl.rr.com>
 <20110615154457.GA13863@srcf.ucam.org>
 <4DFA09CB.9040909@iradimed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45258 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758137Ab1FPOPV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2011 10:15:21 -0400
Content-Disposition: inline
In-Reply-To: <4DFA09CB.9040909@iradimed.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@iradimed.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Jun 16, 2011 at 09:48:59AM -0400, Phillip Susi wrote:
> On 06/15/2011 11:44 AM, Matthew Garrett wrote:
> >Well, that's the usual use-case for WoL. If you don't want a device to
> >wake up from a specific sleep state, disable that device before entering
> >that sleep state.
> 
> I am reading reports from some users that their laptop keeps the
> ethernet interface powered on and runs down the battery after shutting
> down.  It seems they are capable of waking the system from S5.  It
> appears that if the interface is not ethdown'ed in /etc/init.d/halt,
> then it remains on.  Are you saying that it is up to userspace to
> disable WOL and down the interface before shutting down?

Yes. How would the kernel know that you don't want WoL in that case?

> Also strangely, ethtool reports that WOL is enabled for magic packet
> ( which I guess comes from the bios default, I checked my desktop
> and it also appears to default to wol: g, but can only wakeup from
> s4 ), but /proc/acpi/wakeup claims wakeup for the device is
> disabled.  They should always agree shouldn't they?

They should - failure to do so seems like a bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
