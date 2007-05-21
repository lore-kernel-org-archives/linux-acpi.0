From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Touchpad and i8042
Date: Sun, 20 May 2007 22:35:12 -0400
Message-ID: <200705202235.13742.dtor@insightbb.com>
References: <200705191828.09719.dev.list@mircea.bardac.net> <20070519154220.GA14506@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:45961 "EHLO
	asav17.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXEUCo4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 May 2007 22:44:56 -0400
In-Reply-To: <20070519154220.GA14506@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mircea Bardac <dev.list@mircea.bardac.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday 19 May 2007 11:42, Matthew Garrett wrote:
> On Sat, May 19, 2007 at 06:28:08PM +0300, Mircea Bardac wrote:
> 
> > I've noticed a weird behaviour when monitoring roughly the number of 
> > interrupts fired. The number of interrupts for "i8042" increase dramatically 
> > when I move the pointer using the touchpad.
> 
> The touchpad is attached to an i8042. When you touch it, it sends data 
> and generates interrupts. That's perfectly normal.

Yep. With Synaptics touchpad that by default has 80 pps @ 6 bytes per
packet you should be getting ~480 interrupts per second.

-- 
Dmitry
