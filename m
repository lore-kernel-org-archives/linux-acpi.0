From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Automatic S1 sleep
Date: Tue, 11 May 2010 14:18:01 -0400
Message-ID: <4BE99F59.1010100@cfl.rr.com>
References: <4BE97FC9.4040302@cfl.rr.com> <20100511171900.GA17704@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exhub016-3.exch016.msoutlookonline.net ([207.5.72.226]:8288
	"EHLO EXHUB016-3.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756909Ab0EKSSG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 May 2010 14:18:06 -0400
In-Reply-To: <20100511171900.GA17704@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On 5/11/2010 1:19 PM, Matthew Garrett wrote:
> You'll need wakeup events on mouse, keyboard, network packets and so on. 
> Some of these are possible, some aren't really.

On some systems, yes, but generally these are widely possible.  Last
night I experimented with S1 on my desktop pc and after using ethtool to
enable wake on lan, the system slept for several seconds, then woke up
when someone spoke on IRC, causing a packet to hit the NIC.  Another
machine I have here has an Intel e100 series NIC and it appears that the
driver for it only supports wake on magic packet, though I checked the
Intel specs on the chip and it is capable of the other wol modes.

> Just have suspend_devices_and_enter conditionalise the device suspend on 
> whether or not it's PM_SUSPEND_STANDBY.

Ahh, that looks like the place.  Is there a reason why it does not
already do that?

Also Documentation/power/states.txt says that S1 puts devices that
support it into D1.  I would think the code to do that would be here in
suspend_devices_and_enter() but I don't see it.  Do you know where that
is?  I checked and my ATI Radeon video card supports D1 and D2 so could
potentially save a good bit of power by using these states.
