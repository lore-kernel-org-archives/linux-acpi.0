From: Paul Fox <pgf@laptop.org>
Subject: Re: a question about lid input device
Date: Mon, 05 Jul 2010 16:04:06 -0400
Message-ID: <2022.1278360246@foxharp.boston.ma.us>
References: <1276412011.19052.19294.camel@rzhang1-desktop> <20100614020127.GA30773@khazad-dum.debian.net> <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain> <20100704083553.GE32427@core.coreip.homeip.net> <1278292140.4537.6088.camel@rzhang1-desktop> <C5204E20-E9CE-40D7-9398-A32D6E993EE0@gmail.com> <1278294444.4537.6134.camel@rzhang1-desktop> <20100705194945.GA11096@khazad-dum.debian.net> (sfid-20100705_154958_487997_A01EF40D)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colo4.heeltoe.com ([207.210.93.145]:40520 "EHLO
	colo4.heeltoe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0GEUVp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2010 16:21:45 -0400
Received: from grass.foxharp.boston.ma.us (localhost.localdomain [127.0.0.1])
	by colo4.heeltoe.com (Postfix) with ESMTP id 738AA1280E4
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jul 2010 16:04:05 -0400 (EDT)
Received: from foxharp.boston.ma.us (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 18A242E8336
	for <linux-acpi@vger.kernel.org>; Mon,  5 Jul 2010 16:04:06 -0400 (EDT)
In-reply-to: <20100705194945.GA11096@khazad-dum.debian.net> (sfid-20100705_154958_487997_A01EF40D)
Content-ID: <2019.1278360246.1@foxharp.boston.ma.us>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

henrique de moraes holschuh wrote:
 > On Mon, 05 Jul 2010, Zhang Rui wrote:
 > > > I think if you can listen to uevents you can just as easily open /dev/ 
 > > > input/eventX and listen to proper input events.
 > > > 
 > > the question is users may want to get the lid switch STATUS,
 > > asynchronously.
 > 
 > More often than not, you need to know the current state when dealing
 > with EV_SW, to be able to do anything sensbile with it in GUIs, etc.

indeed, this is true for almost any event-on-change interface -- tablet mode,
AC insertion, etc.  the change event alone is never enough.

paul
=---------------------
 paul fox, pgf@laptop.org
