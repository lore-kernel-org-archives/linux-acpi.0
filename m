From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: CoreDuo Bus-Master-Activity on Core1 ffffffff when idle, no C3
Date: Fri, 9 Feb 2007 17:17:43 -0200
Message-ID: <20070209191743.GD4536@khazad-dum.debian.net>
References: <1170989226.4546.17.camel@localhost> <200702090154.02351.lenb@kernel.org> <20070209142925.GE26414@khazad-dum.debian.net> <1171046151.11522.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50549 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992765AbXBITSI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 14:18:08 -0500
Content-Disposition: inline
In-Reply-To: <1171046151.11522.1.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sascha Heid <saschaheid@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 09 Feb 2007, Sascha Heid wrote:
> Am Freitag, den 09.02.2007, 12:29 -0200 schrieb Henrique de Moraes
> Holschuh:
> > On Fri, 09 Feb 2007, Len Brown wrote:
> > > Try disconnecting usb devices until lsusb shows nothing.
> > 
> > On some ThinkPads, this means removing uhci_hcd and ehci_hcd, because they
> > have internal USB devices (bluetooth, fingerprint reader, etc).
> 
> Thats it, added 1h Battery-Life immediately.

Now, for the golden question:  Should uhci_hcd be causing that much
bus-mastering activity?  And why it causes that *only* when the CPU is idle?
That is extremely weird.

I think there indeed is a real bug at work here.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
