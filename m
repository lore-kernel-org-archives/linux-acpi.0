From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Quirking acpi_enforce_resources
Date: Mon, 1 Mar 2010 22:45:26 +0000
Message-ID: <20100301224526.GA25501@srcf.ucam.org>
References: <1267477297.15581.152.camel@cndougla-ubuntu> <20100301220418.GA24957@srcf.ucam.org> <1267481726.22999.13.camel@cndougla-ubuntu> <20100301222202.GA25116@srcf.ucam.org> <1267482931.22999.43.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39663 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab0CAWp1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 17:45:27 -0500
Content-Disposition: inline
In-Reply-To: <1267482931.22999.43.camel@cndougla-ubuntu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Mar 01, 2010 at 05:35:31PM -0500, Chase Douglas wrote:
> On Mon, 2010-03-01 at 22:22 +0000, Matthew Garrett wrote:
> > How are you defining "known-working"? You've verified that the system 
> > management code on the hardware in question makes no accesses to the 
> > smbus?
> 
> I'm defining "known-working" to refer to the amount of bugs opened
> related to the fact that their drivers used to work fine, but now they
> don't.

You're defining "known-working" as "hasn't bricked any hardware yet, as 
far as we know, even though examining the code reveals that it's a 
possibility"? I'm not enthusiastic.

> As are many things, this is a risk-reward tradeoff. If there was even
> one single instance of anyone being harmed by native hwmon drivers, I
> wouldn't have attempted to bring this up. However, I am bringing this up
> not necessarily because I believe this is the best way, but because I
> think we should at least get a discussion out in the open so that others
> can contemplate the issue.

We've had several cases of people having critical thermal shutdowns and 
suffering data loss that were traced back to this issue.

> If consensus is that the risk is not worth it, then I can go back to end
> users and say "The gurus say this is too risky and could harm your
> hardware, please wait for proper ACPI drivers." If the consensus is that
> it will be too hard to determine a proper whitelist of working devices,
> then I can go back with that as well. Right now though, there's no
> stance that's been taken by anyone, so we just have users who are upset
> that their hardware/software isn't working "right".

The stance was made clear by the changing of the default value - if your 
system firmware says that the OS shouldn't touch these resources, the OS 
will not touch those resources.

> P.S. I also don't want to drown out a discussion on the log level of the
> message produced. Please see the first message of this thread for
> details.

I agree that that should probably be KERN_INFO.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
