From: Len Brown <lenb@kernel.org>
Subject: Re: Questions about ACPI and PCI interrupt routing
Date: Tue, 05 Oct 2010 00:39:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010050033460.23093@localhost.localdomain>
References: <AANLkTinoAuRE5nmwpUo9gjc-qda6y08gEZxEUvOkN2GL@mail.gmail.com>
 <alpine.LFD.2.00.1010010229120.7033@localhost.localdomain>
 <AANLkTimHKWSomkH7DDNJdu24M83w_dKEjhmYiuMnH=_F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:65245 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab0JEEjr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Oct 2010 00:39:47 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9S008ITVLYCPL2@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 04 Oct 2010 23:39:47 -0500 (CDT)
In-reply-to: <AANLkTimHKWSomkH7DDNJdu24M83w_dKEjhmYiuMnH=_F@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thawan Kooburat <kthawan@gmail.com>
Cc: linux-acpi@vger.kernel.org

> For unloading drivers and re-probing devices, I found that hotplugging
> is very useful if the bus controller is compatible. However, I
> discovered that a new device does not work properly after using rescan
> because the kernel try to setup an interrupt using the old routing
> information.
>
> Is it possible to re-configure interrupt via ACPI? My current
> understanding is that ACPI layer is configured during boot process by
> reading various tables and create handlers for various method to
> handle devices. So my initial thought is that routing via IOAPIC is a
> simpler model and easier to tackle at first.
> 
> Any suggestion is welcome.

I suggest resuming the image on hardware identical to where it 
suspended:-)

This concept has come up before -- mostly in terms of handling
things that might be un/plugged while suspended.  However, nobody
has proposed replacing the motherboard itself while suspended.

cheers,
-Len
