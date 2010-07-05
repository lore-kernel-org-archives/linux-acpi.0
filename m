From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: a question about lid input device
Date: Mon, 5 Jul 2010 13:27:32 -0700
Message-ID: <20100705202731.GA17013@core.coreip.homeip.net>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
 <20100614020127.GA30773@khazad-dum.debian.net>
 <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain>
 <20100704083553.GE32427@core.coreip.homeip.net>
 <1278292140.4537.6088.camel@rzhang1-desktop>
 <C5204E20-E9CE-40D7-9398-A32D6E993EE0@gmail.com>
 <1278294444.4537.6134.camel@rzhang1-desktop>
 <20100705194945.GA11096@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52744 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab0GEU1h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2010 16:27:37 -0400
Received: by pwi5 with SMTP id 5so1605545pwi.19
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jul 2010 13:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100705194945.GA11096@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Jul 05, 2010 at 04:49:45PM -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 05 Jul 2010, Zhang Rui wrote:
> > > I think if you can listen to uevents you can just as easily open /dev/ 
> > > input/eventX and listen to proper input events.
> > > 
> > the question is users may want to get the lid switch STATUS,
> > asynchronously.
> 
> More often than not, you need to know the current state when dealing
> with EV_SW, to be able to do anything sensbile with it in GUIs, etc.
> 

I understand the need of getting the current state of a lid
switch/key/etc (and for that someone just need to write a utility
useable from shell scripts). But I do not understand how adding switch
state to uevents (that are emitted normally only when a new device is
created) will help here.

-- 
Dmitry
