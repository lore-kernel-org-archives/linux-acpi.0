From: Len Brown <lenb@kernel.org>
Subject: Re: sony-laptop: ACPI Exception when a Fn-Key is pressed
Date: Tue, 07 Apr 2009 00:54:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904070052260.5698@localhost.localdomain>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
 <20090406110154.GA25085@kamineko.org>
 <7a3045780904060613x4ba373c6o7447e511d3841cfa@mail.gmail.com>
 <1239070397.3582.171.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:52910 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZDGEy5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 00:54:57 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHP00ELTSBFA2Y6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 06 Apr 2009 23:54:51 -0500 (CDT)
In-reply-to: <1239070397.3582.171.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Rodrigo Luiz <rodrigo@gus-mg.org>, Mattia Dongili <malattia@linux.it>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>




On Tue, 7 Apr 2009, yakui_zhao wrote:

> On Mon, 2009-04-06 at 21:13 +0800, Rodrigo Luiz wrote:
> > On Mon, Apr 6, 2009 at 8:01 AM, Mattia Dongili <malattia@linux.it> wrote:
> > >
> > > Does booting with acpi_osi=Linux makes things any worse? (it should fix
> > > the above error but might make some other functionality behave
> > > differently).
> > > Or eventually also see if there is a bios upgrade available for your
> > > laptop.
> > >
> > 
> Does the warning message exist when booting the previous kernel? For
> example: 2.6.28 kernel.
> 
> Will you please try the following commit patch and see whether this issue still exists?
>    >commit 7b46ecd5fcebf381a7bde966db352d8fb1b8e944
>    >Author: Len Brown <len.brown@intel.com>
>    >Date:   Wed Feb 25 18:00:18 2009 -0500
>      >Revert "ACPI: make some IO ports off-limits to AML"

That commit shipped in 2.6.29, so Rodrigo should already have it.

ie. 2.6.29 should behave just like 2.6.28.

by "latest git", i assume Rodrigo means 2.6.29-git*, ie 2.6.30 merge 
window.

thanks,
Len Brown, Intel Open Source Technology Center

