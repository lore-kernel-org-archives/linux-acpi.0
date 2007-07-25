From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC][PATCH 0/5] ACPI: acer_acpi
Date: Wed, 25 Jul 2007 12:12:23 +0200
Message-ID: <1185358343.3968.57.camel@noname>
References: <200707171544.57004.cathectic@gmail.com>
	 <200707182058.40193.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39202 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757081AbXGYKLp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 06:11:45 -0400
In-Reply-To: <200707182058.40193.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Carlos Corbacho <cathectic@gmail.com>, linux-acpi@vger.kernel.org

On Wed, 2007-07-18 at 20:58 -0400, Len Brown wrote:
> On Tuesday 17 July 2007 10:44, Carlos Corbacho wrote:
> > Hello all,
> > 
> > The following five patches (against acpi test) add support for Acer laptops
> > (2005 and newer) that define the PNP0C14 _HID device in ACPI (aka the Windows
> > Management Instrumentation Device).
> 
> no, PNP0C14 is not specific to acer,
> and a platform-specific driver should not be necessary to handle it.
> 
> I started a wmi.c a while back, and planned to get it out on the
> list by the end of July.  I've got only one laptop that I can
> test it on (an HP).  Perhaps you can help me test a generic wmi.c
> on your Acer?

Add me on the list of volunteers.
If I find some time, I am eager to give it a test...

Here a list of machines I found having a PNP0C14 device:

HP: nx5000, nx6310, nx6125, nx6325, nx8220, nx9105, nx9420, nx9105,
Presario m2000, nc6230, nc6400, dv8000, ...

Acer: Aspire 5050, 1360 wlmi, Ferrari F5000, ...

FSC: Some Amilos (at least M3438G)

There are probably much more, maybe someone finding his laptop on this
list also wants to help and try things out...

   Thomas

