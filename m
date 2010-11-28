From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Input event for blocking touchpad
Date: Sun, 28 Nov 2010 14:38:44 +0000
Message-ID: <1290955125.819.4.camel@novo.hadess.net>
References: <20101126211056.GD3819@barata.holoscopio.com>
	 <20101128080743.GE14499@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:41354 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab0K1OjP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Nov 2010 09:39:15 -0500
In-Reply-To: <20101128080743.GE14499@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 2010-11-28 at 00:07 -0800, Dmitry Torokhov wrote:
> On Fri, Nov 26, 2010 at 07:10:57PM -0200, Thadeu Lima de Souza Cascardo wrote:
> > Hello,
> > 
> > I have a notebook with an ACPI system that notifies about the pressing
> > of the key for blocking touchpad. However, it does not notify it by
> > itself. I was considering sending the event to userspace and let it does
> > the blocking.
> > 
> > Since other keys are also notified by this same ACPI object, it's even
> > more natural that I use an input device to send this to userspace.
> > 
> > The problem is: there seems to be no event to represent this. Any
> > suggestions?
> > 
> 
> I have the patch below from Bastien that I will be queueing shortly.

Note that KEY_TOUCHPAD_{ON,OFF} are for when:
1) Your touchpad disables in hardware
2) You can know for certain the status of the device

You'll need to use KEY_TOUCHPAD_TOGGLE in your patch (and make changes
to udev's keyboard remap scripts to map KEY_TOUCHPAD_TOGGLE to F21 until
X can get access to those keycodes.

Cheers

