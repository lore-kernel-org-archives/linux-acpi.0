From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: a question about lid input device
Date: Sun, 13 Jun 2010 23:01:27 -0300
Message-ID: <20100614020127.GA30773@khazad-dum.debian.net>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40552 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755200Ab0FNCBd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jun 2010 22:01:33 -0400
Content-Disposition: inline
In-Reply-To: <1276412011.19052.19294.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: dmitry.torokhov@gmail.com, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <lenb@kernel.org>

On Sun, 13 Jun 2010, Zhang Rui wrote:
> Then we update the lid switch status when a Lid notification comes.
> right?

Yes.

> Then, IMO, userspace can get the lid status
> via /sys/class/input/inputX/uevent, right?

No, only through an IOCTL.

> /sys/class/input/input1/uevent:EV==21

That's an bitmap of al EV_EV it supports.

> /sys/class/input/input1/uevent:SW==1

That's an bitmap of al EV_SW it supports.

> Lid is opened but SW is set, I tried to close/open the lid and found
> that this bit never changes. is there something I misunderstand? can we
> get the lid status in userspace?

IOCTL(), only.

Since nobody got a input-utils standard package (or added something to
util-linux) yet to do that (AFAIK anyway), it is a MAJOR annoyance for
shell scripts that want to query EV_SW state...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
