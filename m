From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI and power failure
Date: Fri, 16 Feb 2007 12:59:54 -0500
Message-ID: <200702161259.54485.lenb@kernel.org>
References: <45D5E55D.4000802@vision-gaming.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51773 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946133AbXBPSBL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 13:01:11 -0500
In-Reply-To: <45D5E55D.4000802@vision-gaming.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Dufresne <jdufresne@vision-gaming.com>
Cc: linux-acpi@vger.kernel.org

On Friday 16 February 2007 12:09, Jon Dufresne wrote:
> Hi,
> 
> Is there anything ACPI related that deals with a AC power fail in the 
> system?

nope, not that i'm aware of.

Often the system firmware can detect a powerfail vs graceful poweroff
and give you the option (eg. via BIOS SETUP) when the power is restored
to either stay off, power on, or return to the whatever the state
was before the power fail.

This, however, is a platform feature that is not visible to ACPI
or the OS.

-Len

> I am developing an embedded system that has very limited writes to a 
> flash device, other than that all file systems are read only. I want to 
> turn this device on and off with one main switch that will cut the AC 
> power. Turning it on this way is not a problem. When I turn it off I am 
> a bit worried that if in the middle of a write the r/w file system may 
> be corrupted. I am curious if there is anything ACPI related that can 
> detect an AC power fail and in the 1-5 ms before DC power is lost 
> quickly do the bare essentials of house keeping to prevent fs corruption.
> 
> Any input on this would be helpful.
> 
> Thanks,
> Jon
