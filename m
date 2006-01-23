From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.16-rc1  will not boot on msi rs480m2 when either acpi orapic is enabled
Date: Mon, 23 Jan 2006 14:17:03 -0700
Message-ID: <200601231417.03619.bjorn.helgaas@hp.com>
References: <43D4FE2F.5080700@clifford.net> <43D528A0.8030704@clifford.net> <43D534C3.5020900@clifford.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:55763 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1030191AbWAWVRM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 16:17:12 -0500
In-Reply-To: <43D534C3.5020900@clifford.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Raphael Clifford <raphael@clifford.net>
Cc: linux-acpi@vger.kernel.org

On Monday 23 January 2006 12:55, Raphael Clifford wrote:
>> It seems I made a brown paper bag error in my testing and 2.6.16-rc1 
> *does* in fact boot now with BOTH acpi and apic enabled (previous kernel 
> versions didn't and you must have both enabled both for it to boot)!

Whew, that's a relief.  I didn't have any good ideas about where
to look.  Sorry, I can't help with the other stuff you mention below.

> The only remaining signs of problems it seems are
> 
> "APIC error on CPU0: 04(40)"
> 
> and
> 
> "Losing some ticks... checking if CPU frequency changed.
> Your time source seems to be instable or some driver is hogging interupts
> rip ext3_reserve_inode_write+0x3a/0x94
> "
> 
> The system is still jerky and jumpy when ripping a DVD for example with 
> 50-70% "si" in top.

