From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Wakeup and S states
Date: Wed, 15 Jun 2011 16:44:57 +0100
Message-ID: <20110615154457.GA13863@srcf.ucam.org>
References: <4DF8CBC3.5070801@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46097 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab1FOPpD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2011 11:45:03 -0400
Content-Disposition: inline
In-Reply-To: <4DF8CBC3.5070801@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Jun 15, 2011 at 11:12:03AM -0400, Phillip Susi wrote:

> Conversely, if an ethernet controller is capable of waking up the
> system from S5, that does not mean we want it left powered on and
> capable of doing so when we shut the machine off, but had WOL
> enabled.  Is there no way to enable wakeup only from S3, even though
> the device is capable of lower levels?

Well, that's the usual use-case for WoL. If you don't want a device to 
wake up from a specific sleep state, disable that device before entering 
that sleep state.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
