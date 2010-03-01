From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Quirking acpi_enforce_resources
Date: Mon, 1 Mar 2010 22:22:02 +0000
Message-ID: <20100301222202.GA25116@srcf.ucam.org>
References: <1267477297.15581.152.camel@cndougla-ubuntu> <20100301220418.GA24957@srcf.ucam.org> <1267481726.22999.13.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53402 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0CAWWJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 17:22:09 -0500
Content-Disposition: inline
In-Reply-To: <1267481726.22999.13.camel@cndougla-ubuntu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Mar 01, 2010 at 05:15:26PM -0500, Chase Douglas wrote:

> I understand your points, but from the user's perspective they had
> something that worked perfectly fine before, and now it doesn't. Have
> there been any reports of anyone's hardware being adversely affected by
> doubly acquiring the acpi region? Beyond that, have there been any
> reports of any adverse affects of any kind?

I really don't understand your position here. Like I said, the 
probability of a collision between ACPI and the OS is low. On the other 
hand, the potential outcome of such a collision is hardware damage. This 
isn't even close to being something that should be considered.

> I'm not advocating for enabling acpi_enforce_resources=lax across the
> board. That would be foolish, especially since there is an existing acpi
> driver that would be harmed. However, a whitelist of known-working
> hardware would allow us to cater to users needs while still being fairly
> careful.

How are you defining "known-working"? You've verified that the system 
management code on the hardware in question makes no accesses to the 
smbus?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
