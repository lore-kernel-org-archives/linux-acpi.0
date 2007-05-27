From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: allow hotkey to input event map to be modified
Date: Sun, 27 May 2007 15:07:29 -0300
Message-ID: <20070527180729.GA4507@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <11802006652128-git-send-email-hmh@hmh.eng.br> <11802006652058-git-send-email-hmh@hmh.eng.br> <200705262338.19137.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56433 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752806AbXE0SHf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 May 2007 14:07:35 -0400
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

I have fixed this to use the standard keycode, keycodesize and other such
stuff, now.  I am working with 2.6.20/2.6.21 as my base, so there is no
getkeycodes() and setkeycode(), but that is not a problem.  It is trivial
enough that I will just maintain two sets of the code for now.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
