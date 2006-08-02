From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Generic battery interface
Date: Wed, 2 Aug 2006 09:18:41 +0200
Message-ID: <20060802091841.8585a72a.khali@linux-fr.org>
References: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	<20060727232427.GA4907@suse.cz>
	<41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	<20060728074202.GA4757@suse.cz>
	<41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	<20060728202359.GB5313@suse.cz>
	<41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	<41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	<41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	<20060731233536.92b39035.khali@linux-fr.org>
	<20060731230145.GF3612@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:16652 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751307AbWHBHSg
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Aug 2006 03:18:36 -0400
In-Reply-To: <20060731230145.GF3612@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>, Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>

Hi Pavel,

> > frequently it can read from the chip. And no hardware monitoring chip I
> > know of can tell when the monitored value has changed - you have to read
> > the chip registers to know.
> 
> ACPI battery can tell when values change in significant way. (Like
> battery becoming critical).

Ah, good to know. But is there a practical use for this? I'd suspect
that the user wants to know the battery charge% all the time anyway,
critical or not.

-- 
Jean Delvare
