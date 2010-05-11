From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Automatic S1 sleep
Date: Tue, 11 May 2010 14:43:25 -0400
Message-ID: <4BE9A54D.2060500@cfl.rr.com>
References: <4BE97FC9.4040302@cfl.rr.com> <20100511171900.GA17704@srcf.ucam.org> <4BE99F59.1010100@cfl.rr.com> <20100511182129.GA19264@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exhub016-3.exch016.msoutlookonline.net ([207.5.72.226]:12165
	"EHLO EXHUB016-3.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870Ab0EKSn3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 May 2010 14:43:29 -0400
In-Reply-To: <20100511182129.GA19264@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On 5/11/2010 2:21 PM, Matthew Garrett wrote:
> The exact meaning of PM_STANDBY_SUSPEND isn't defined. The sanest 
> approach might be to add a callback in the platform_suspend_ops 
> structure, pass the sleep state to that and then use that to decide 
> whether or not devices need to sleep.

Sounds reasonable.  Maybe I'll take a crack at writing a patch to do that.

> Putting a video card into D1 is either going to turn off the output or 
> do nothing, so I don't think that's terribly compatible with what you 
> want here. But to answer your question, the PCI core will decide what 
> state to put devices in based on the sleep type provided.

Actually after looking at some ATI specs it seems that there are several
configuration options of exactly what should be powered down in D1 and
D2 but the DAC output did not seem to be one of them.  It seems to be
intended to do things like stop the GPU clocks but otherwise leave the
display on.  I assumed that the card was in D1 last night while the
system was in S1, and the display remained visible.  If D1 does stop the
DVI output then it must not have been set to D1.

How does the PCI core get called when changing state?  I would think it
would be when suspend_devices_and_enter() calls
dpm_suspend_start(PMESG_SUSPEND) but that does not differentiate between
S1 and S3, so I would think that currently it would result in placing
the device in D3, and that if I remove the PMESG_SUSPEND for
PM_SUSPEND_STANDBY that it would result in leaving devices in D0.
