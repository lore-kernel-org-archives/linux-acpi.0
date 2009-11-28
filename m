From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Backlight device class redesign
Date: Sat, 28 Nov 2009 15:21:27 -0200
Message-ID: <20091128172127.GC28189@khazad-dum.debian.net>
References: <b170af450911271630k63fb857auf8314cecd6219eba@mail.gmail.com>
 <b170af450911280230g4a2f7f8ao64b46ce7e88ec929@mail.gmail.com>
 <20091128122229.GB17894@khazad-dum.debian.net>
 <b170af450911280458v66c3741dy2a1d9c5297c8faf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42852 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752415AbZK1RVW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Nov 2009 12:21:22 -0500
Content-Disposition: inline
In-Reply-To: <b170af450911280458v66c3741dy2a1d9c5297c8faf5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafa?? Mi??ecki <zajec5@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

On Sat, 28 Nov 2009, Rafa?? Mi??ecki wrote:
> > Meanwhile, I'd like a LOT to know how I could parent the backlight device I
> > export in a platform driver to the correct PCI or ACPI device for the main
> > GPU...
> 
> Is actually "parent" used for something? I can see it used in many
> modules, but not sure where we use that pointer (if we do).

For one, you get symlinks in sysfs, which would let userspace know what
backlight is related to what PCI/video/whatever device.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
