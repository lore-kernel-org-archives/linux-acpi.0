From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Automatic S1 sleep
Date: Tue, 11 May 2010 19:21:29 +0100
Message-ID: <20100511182129.GA19264@srcf.ucam.org>
References: <4BE97FC9.4040302@cfl.rr.com> <20100511171900.GA17704@srcf.ucam.org> <4BE99F59.1010100@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33370 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983Ab0EKSVh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2010 14:21:37 -0400
Content-Disposition: inline
In-Reply-To: <4BE99F59.1010100@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-acpi@vger.kernel.org

On Tue, May 11, 2010 at 02:18:01PM -0400, Phillip Susi wrote:
> On 5/11/2010 1:19 PM, Matthew Garrett wrote:
> > Just have suspend_devices_and_enter conditionalise the device suspend on 
> > whether or not it's PM_SUSPEND_STANDBY.
> 
> Ahh, that looks like the place.  Is there a reason why it does not
> already do that?

The exact meaning of PM_STANDBY_SUSPEND isn't defined. The sanest 
approach might be to add a callback in the platform_suspend_ops 
structure, pass the sleep state to that and then use that to decide 
whether or not devices need to sleep.

> Also Documentation/power/states.txt says that S1 puts devices that
> support it into D1.  I would think the code to do that would be here in
> suspend_devices_and_enter() but I don't see it.  Do you know where that
> is?  I checked and my ATI Radeon video card supports D1 and D2 so could
> potentially save a good bit of power by using these states.

Putting a video card into D1 is either going to turn off the output or 
do nothing, so I don't think that's terribly compatible with what you 
want here. But to answer your question, the PCI core will decide what 
state to put devices in based on the sleep type provided.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
