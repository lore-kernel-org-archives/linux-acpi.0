From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: Quirking acpi_enforce_resources
Date: Mon, 01 Mar 2010 17:15:26 -0500
Message-ID: <1267481726.22999.13.camel@cndougla-ubuntu>
References: <1267477297.15581.152.camel@cndougla-ubuntu>
	 <20100301220418.GA24957@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:54968 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab0CAWPb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 17:15:31 -0500
In-Reply-To: <20100301220418.GA24957@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Mon, 2010-03-01 at 22:04 +0000, Matthew Garrett wrote:
> On Mon, Mar 01, 2010 at 04:01:37PM -0500, Chase Douglas wrote:
> > Thus, I'm wondering if it would be worthwhile to whitelist machines 
> > that are known to work OK even with the resources being doubly held by 
> > both the acpi driver and a legacy driver. It certainly does not seem 
> > prudent to set acpi_enforce_resources=lax across the board, but the 
> > change to strict resource checking seems to have done more harm than 
> > good for the average user.
> 
> The average user now has no chance of this causing a spurious system 
> shutdown due to a false temperature reading, and also no chance of this 
> causing invalid values to be written to a device causing it to brick the 
> hardware. If users are willing to accept the (admittedly small) risk, 
> they get to pass the argument. It's not reasonable for the upstream 
> kernel to do this.

I understand your points, but from the user's perspective they had
something that worked perfectly fine before, and now it doesn't. Have
there been any reports of anyone's hardware being adversely affected by
doubly acquiring the acpi region? Beyond that, have there been any
reports of any adverse affects of any kind?

I'm not advocating for enabling acpi_enforce_resources=lax across the
board. That would be foolish, especially since there is an existing acpi
driver that would be harmed. However, a whitelist of known-working
hardware would allow us to cater to users needs while still being fairly
careful.

Thanks,
Chase

