From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: allow hotkey to input event map to be modified
Date: Sun, 27 May 2007 09:03:19 -0300
Message-ID: <20070527120319.GB19562@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <11802006652128-git-send-email-hmh@hmh.eng.br> <11802006652058-git-send-email-hmh@hmh.eng.br> <200705262338.19137.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57247 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbXE0MD0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 May 2007 08:03:26 -0400
Content-Disposition: inline
In-Reply-To: <200705262338.19137.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org

On Sat, 26 May 2007, Dmitry Torokhov wrote:
> On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> > Add a sysfs interface to allow userspace to modify the mapping between
> > ThinkPad hotkeys and the keycode input events they generate.
> 
> No, please do not do that. We have a standard way to adjust keymap for
> an input device via EVIOCGKEYCODE/EVIOCSKEYCODE ioctls on corresponding
> event device; there is no need to invent another interface. Just define
> getkeycodes() and setkeycode() methods for your input device and be done
> with it.

Sure, I will change to the IOCTLs.  Such stuff is exactly why I sent out a
partway-done "don't merge it yet" patch set: I had a hunch that the code
would need some changes as the documentation on how to use the input device
in-kernel API is worth very little.

IMO if there is an API that is dedicated to drivers (and not, say, kernel
core), full documentation and keeping it up-to-date should be non-negotiable
requirements for the initial merge in mainline, and any subsequent patches
that touch it.  Oh well.   I am reading the corgikbd driver now, it looks
sane enough to use as documentation.

On that topic, am I to send SYNC events between key-press and key-release
events?  Just after a key-press+key release event?  Or not at all for a
EV_KEY ? And exactly what should go in the hardware port descriptor? I used
module name/input device number relative to the module.  THIS ONE REALLY
NEEDS TO BE DOCUMENTED PROPERLY.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
