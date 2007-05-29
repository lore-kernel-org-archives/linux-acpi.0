From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: allow hotkey to input event map to be modified
Date: Mon, 28 May 2007 23:08:44 -0400
Message-ID: <200705282308.45828.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262338.19137.dtor@insightbb.com> <20070527120319.GB19562@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:4007 "EHLO
	asav05.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbXE2DId (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2007 23:08:33 -0400
In-Reply-To: <20070527120319.GB19562@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org

Hi,

On Sunday 27 May 2007 08:03, Henrique de Moraes Holschuh wrote:
> On Sat, 26 May 2007, Dmitry Torokhov wrote:
> > On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> > > Add a sysfs interface to allow userspace to modify the mapping between
> > > ThinkPad hotkeys and the keycode input events they generate.
> > 
> > No, please do not do that. We have a standard way to adjust keymap for
> > an input device via EVIOCGKEYCODE/EVIOCSKEYCODE ioctls on corresponding
> > event device; there is no need to invent another interface. Just define
> > getkeycodes() and setkeycode() methods for your input device and be done
> > with it.
> 
> Sure, I will change to the IOCTLs.  Such stuff is exactly why I sent out a
> partway-done "don't merge it yet" patch set: I had a hunch that the code
> would need some changes as the documentation on how to use the input device
> in-kernel API is worth very little.
> 
> IMO if there is an API that is dedicated to drivers (and not, say, kernel
> core), full documentation and keeping it up-to-date should be non-negotiable
> requirements for the initial merge in mainline, and any subsequent patches
> that touch it.  Oh well.   I am reading the corgikbd driver now, it looks
> sane enough to use as documentation.
> 

Documentation/input/input-programming.txt gives some pointers.

> On that topic, am I to send SYNC events between key-press and key-release
> events? 

Yes. The application is allowed to "accumulate" input events until it gets
EV_SYN/SYN_REPORT so if you don't send sync in-between some applications
may not see a button press.

> Just after a key-press+key release event?  Or not at all for a 
> EV_KEY ? And exactly what should go in the hardware port descriptor? I used
> module name/input device number relative to the module.

Are you talking about "phys"? Then it is supposed to have an unique path
to the input device. For devices on BUS_HOST module name + relative input
device numbers seems to be the best choice.

-- 
Dmitry
