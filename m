From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Fri, 19 Jan 2007 14:33:09 -0700
Message-ID: <200701191433.09311.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com> <414cba4e0701190737j110b33aau25789808767953fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:42316 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964924AbXASVdU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jan 2007 16:33:20 -0500
In-Reply-To: <414cba4e0701190737j110b33aau25789808767953fa@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Friday 19 January 2007 08:37, emisca wrote:
> I have posted some days ago, some problems on resume from suspend to
> disk on my motherboard (asus p5ld2 se) related to acpi pnp. The serial
> didn't worked after resume. Using pnpacpi=off it worked.
> Now using this patch what will be the behaviour?

My patches shouldn't change the behavior you're seeing.

Since it seems to be related to PNPACPI, can you post the dmesgs with
and without pnpacpi=off to linux-acpi?  I see the ones on LKML, but
it sounds like there was some user error in collecting them.

Bjorn

