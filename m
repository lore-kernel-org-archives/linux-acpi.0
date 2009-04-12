From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control
	brightness with hotkeys
Date: Sun, 12 Apr 2009 13:14:48 -0300
Message-ID: <20090412161448.GC26502@khazad-dum.debian.net>
References: <49E10684.5090101@gmail.com> <20090411150555.8b13ed18.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53931 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750739AbZDLQOw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2009 12:14:52 -0400
Content-Disposition: inline
In-Reply-To: <20090411150555.8b13ed18.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Niel Lambrechts <niel.lambrechts@gmail.com>, "linux.kernel" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, 11 Apr 2009, Andrew Morton wrote:
> > With latest git kernel, I'm no longer able to control my Thinkpad (W500)
> > brightness, although I can still control the backlight, bluetooth etc.

Niels, something just occourred to me.  Is your problem the hotkeys, or the
brightness control itself?  Check /sys/class/backlight/*, please.  What do
you have in there?  Does it work?

If it is the hotkeys, make sure you either have the legacy ACPI events
enabled in kconfig, or that you have something tied to the thinkpad-acpi
input device (no, HAL doesn't do it _yet_, it just forwards the events to
X.org)...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
