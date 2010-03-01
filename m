From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: Quirking acpi_enforce_resources
Date: Mon, 01 Mar 2010 17:35:31 -0500
Message-ID: <1267482931.22999.43.camel@cndougla-ubuntu>
References: <1267477297.15581.152.camel@cndougla-ubuntu>
	 <20100301220418.GA24957@srcf.ucam.org>
	 <1267481726.22999.13.camel@cndougla-ubuntu>
	 <20100301222202.GA25116@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:59367 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab0CAWfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 17:35:37 -0500
In-Reply-To: <20100301222202.GA25116@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Mon, 2010-03-01 at 22:22 +0000, Matthew Garrett wrote:
> On Mon, Mar 01, 2010 at 05:15:26PM -0500, Chase Douglas wrote:
> 
> > I understand your points, but from the user's perspective they had
> > something that worked perfectly fine before, and now it doesn't. Have
> > there been any reports of anyone's hardware being adversely affected by
> > doubly acquiring the acpi region? Beyond that, have there been any
> > reports of any adverse affects of any kind?
> 
> I really don't understand your position here. Like I said, the 
> probability of a collision between ACPI and the OS is low. On the other 
> hand, the potential outcome of such a collision is hardware damage. This 
> isn't even close to being something that should be considered.
> 
> > I'm not advocating for enabling acpi_enforce_resources=lax across the
> > board. That would be foolish, especially since there is an existing acpi
> > driver that would be harmed. However, a whitelist of known-working
> > hardware would allow us to cater to users needs while still being fairly
> > careful.
> 
> How are you defining "known-working"? You've verified that the system 
> management code on the hardware in question makes no accesses to the 
> smbus?

I'm defining "known-working" to refer to the amount of bugs opened
related to the fact that their drivers used to work fine, but now they
don't.

As are many things, this is a risk-reward tradeoff. If there was even
one single instance of anyone being harmed by native hwmon drivers, I
wouldn't have attempted to bring this up. However, I am bringing this up
not necessarily because I believe this is the best way, but because I
think we should at least get a discussion out in the open so that others
can contemplate the issue.

If consensus is that the risk is not worth it, then I can go back to end
users and say "The gurus say this is too risky and could harm your
hardware, please wait for proper ACPI drivers." If the consensus is that
it will be too hard to determine a proper whitelist of working devices,
then I can go back with that as well. Right now though, there's no
stance that's been taken by anyone, so we just have users who are upset
that their hardware/software isn't working "right".

P.S. I also don't want to drown out a discussion on the log level of the
message produced. Please see the first message of this thread for
details.

Thanks,
Chase

