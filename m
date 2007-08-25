From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Sat, 25 Aug 2007 02:05:25 -0400
Message-ID: <200708250205.25653.lenb@kernel.org>
References: <200708240042.l7O0gtEe022838@turbo.physics.adelaide.edu.au> <1187927741.2691.43.camel@acpi-hp.sh.intel.com> <20070824041227.GA8002@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55436 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbXHYGMt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Aug 2007 02:12:49 -0400
In-Reply-To: <20070824041227.GA8002@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

On Friday 24 August 2007 00:12, Matthew Garrett wrote:
> On Fri, Aug 24, 2007 at 11:55:41AM +0800, Zhang Rui wrote:
> 
> > I have the same question for ACPI video driver.
> > Take KEY_BRIGHTNESSUP/KEY_BRIGHTNESSDOWN for example, if ACPI video
> > driver gets such a notification, it will change the brightness level
> > first and then send an event to user space.
> 
> The X people would prefer that the kernel not change the brightness 
> itself, where possible. In the cases where drivers know how to control 
> the backlight hardware themselves (most new Intel hardware, nvidia stuff 
> since 2005ish, that sort of thing) it's likely that they'll be able to 
> provide much more control than the level provided via the ACPI 
> interface.
> 
> > I'll send a patch to make ACPI video driver do nothing but export the
> > events to user space in the notify handler if you guys think it's okay.
> 
> I think that's the right thing to do, but you might want to make it a 
> module option to begin with. That way you can printk that the behaviour 
> will change in the future, and then flip the default in a few months.

We must handle two modes:

1. VGA mode, no X

Control the video in the kernel via ACPI methods to talk to the BIOS.
This is known to work on multiple laptops today.

I don't see the utility in sending the hotkey events to user-space
in this mode, but I also don't see the harm, so lets keep them
as an FYI in case some graphics software doesn't know how to
control the video but wants the event to re-probe or something.

2. Graphics mode, X is running

While sometimes programming the video behind X's back
using the kernel and BIOS ACPI entry points works,
this is generally a bad idea.

Here we need to disable the ACPI entry points that control video,
and do nothing but send the input events to user-space
to be picked up by the X server.

Clearly there needs to be a mode bit.
The mode bit should default to case #1 --
as that is what we are running today --
and when X knows to look for the input events
and has the ability to switch modes natively, it should
set the mode bit to switch us to case #2.

The mode bit should probably live in the CONFIG_VIDEO_OUTPUT_CONTROL,
eg. under driers/video/output.c with some generic name that in this
case the acpi video driver registers for.

Rui, can you follow up on this?

thanks,
-Len
