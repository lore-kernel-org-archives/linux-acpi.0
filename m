From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: a question about lid input device
Date: Mon, 5 Jul 2010 16:49:45 -0300
Message-ID: <20100705194945.GA11096@khazad-dum.debian.net>
References: <1276412011.19052.19294.camel@rzhang1-desktop> <20100614020127.GA30773@khazad-dum.debian.net> <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain> <20100704083553.GE32427@core.coreip.homeip.net> <1278292140.4537.6088.camel@rzhang1-desktop> <C5204E20-E9CE-40D7-9398-A32D6E993EE0@gmail.com> <1278294444.4537.6134.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36921 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753740Ab0GETtz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2010 15:49:55 -0400
Content-Disposition: inline
In-Reply-To: <1278294444.4537.6134.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 05 Jul 2010, Zhang Rui wrote:
> > I think if you can listen to uevents you can just as easily open /dev/ 
> > input/eventX and listen to proper input events.
> > 
> the question is users may want to get the lid switch STATUS,
> asynchronously.

More often than not, you need to know the current state when dealing
with EV_SW, to be able to do anything sensbile with it in GUIs, etc.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
