From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Question regarding linux acpi
Date: Thu, 5 Aug 2010 00:34:18 +0100
Message-ID: <20100804233418.GA8167@srcf.ucam.org>
References: <20100804170236.GA32073@srcf.ucam.org> <BLU102-W14E1E8D6FA2F2A23C56E84EBAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49597 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049Ab0HDXeV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2010 19:34:21 -0400
Content-Disposition: inline
In-Reply-To: <BLU102-W14E1E8D6FA2F2A23C56E84EBAF0@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Aug 05, 2010 at 04:13:42AM +0530, Raj Kumar wrote:

>    I have implemented run time power management in my drivers. Do you mean to
>    say
>    In case of ACPI also, again run time power management will get to device
>    in low
>    power mode or full working mode.

Unless you're coding for an ACPIPNP device, you don't need to care about 
ACPI at all in your driver. The code in 2.6.35 and higher will handle 
that for you.

>    The another thing is suppose BIOS is ACPI based, ok as you told that bus
>    will handle
>    all the things do you mean ACPI driver will notify the bus about various
>    device states?

The core ACPI code will inform the PCI code (for instance) that a wakeup 
event has been generated, or the PCI code (for instance) will call the 
appropraite ACPI functions while putting the device in a low power 
state.

>    If yes then what the standard interface between bus driver  and device
>    driver?

It's documented in the runtime pm document I pointed you at.

>    Do you mean if there is ACPI, still ACPI is hooked with standard linux
>    static power management
>    core and run time power management core?

Yes.

>    I mean to say ACPI notify the bus via linux power management core (static
>    and run time)?

Yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
