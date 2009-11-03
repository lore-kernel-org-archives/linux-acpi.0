From: Andy Isaacson <adi@hexapodia.org>
Subject: Re: [mjg@redhat.com: [PATCH] From: Rezwanul Kabir <Rezwanul_Kabir@dell.com>]
Date: Tue, 3 Nov 2009 12:51:01 -0800
Message-ID: <20091103205101.GZ25713@hexapodia.org>
References: <20091102174748.GA21342@srcf.ucam.org> <20091103034212.GF31712@vmware.com> <20091102174748.GA21342@srcf.ucam.org> <20091103040525.GY25713@hexapodia.org> <20091103143637.GA7673@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from straum.hexapodia.org ([64.81.70.185]:8240 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbZKCUu6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Nov 2009 15:50:58 -0500
Content-Disposition: inline
In-Reply-To: <20091103143637.GA7673@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Right, so, brown paper bag time... my testing last night was with
completely the wrong kernel, with a previous version of the patch.

> Hm. 241 is KEY_VIDEO_NEXT - I thought I'd changed that to be 
> KEY_SWITCHVIDEOMODE? 240 is KEY_UNKNOWN. I don't think we've currently 
> got an appropriate key to map the ALS button to.

Verified with the correct kernel on E4300 with GMA, I get 227 on the WMI
input event device and 227 on the ACPI Video Bus device.

> > I don't know what event causes the "event 0x11" complaint.  It seems to
> > be purely cosmetic and not directly tied to user interaction?
> 
> On my test system, that's the "battery with lightning flash" key. I have 
> no idea what it's meant to do, or how we're meant to interpret that 
> event.

Yes, Fn-F2 (battery with lighting bolt) is the trigger for the "Received
unknown WMI event (0x11)" message.  It also toggles battery charge -- if
I press it when the battery is charging, the battery stops charging:
grep 'charging state' /proc/acpi/battery/BAT0/state
charging state:           charged

Pressing Fn-F2 again gets the battery charging again and triggers
another "unknown WMI event (0x11)" message.

> > Fn-F8, Display Toggle, gives code 241 on the WMI event8 *and* code 227
> > on /dev/input/event4 "Video Bus".  That seems ... wrong.
> 
> Yup. Unfortunately on my system, it only gets delivered via WMI and not 
> via ACPI, so doing the same thing as for the brightness keys doesn't 
> look like it'll work.

On an E6400 with NVidia graphics, I do get 227 on WMI and do not have a 
Video Bus object (but the VID1 event does show up in acpi_listen).
Appears to be a difference between laptops with Intel GMA versus NVidia,
sigh.

so... condition delivery of KEY_SWITCHVIDEOMODE on whether the videobus
object is present?  Seems kinda nasty...

-andy
