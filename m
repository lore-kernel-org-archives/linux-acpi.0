From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: serial port discovery on a motion computing tablet
Date: Wed, 14 Mar 2007 13:43:23 +0000
Message-ID: <20070314134323.GC1467@srcf.ucam.org>
References: <45F7688B.8000101@elevating.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:55529 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904AbXCNNnr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2007 09:43:47 -0400
Content-Disposition: inline
In-Reply-To: <45F7688B.8000101@elevating.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bret Hughes <bhughes@elevating.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Mar 13, 2007 at 10:14:19PM -0500, Bret Hughes wrote:
> I am evaluating a motion computing LE1600 tablet for possible use with 
> linux using Centos 4.4 since that is what we use for several servers and 
> had the installation media handy.  This device uses a TouchKO serial 
> touchscreen that has been used by linux in the past but the issue I am 
> facing is that the bios does not expose the serial ports.  I spoke with 
> an engineer at TouchKO familiar with the LE1600 project an he told me I 
> would have to access the serial port via acpi.  Hmm says I, I guess I 
> have some reading to do.  DO after a day or so of trying to get up to 
> speed, I feel I can ask a fairly decent question or two. 

It sounds like it ought to be exposed via ACPIPNP. If you do cat 
/sys/bus/pnp/devices/*/id, do any of them look plausibly linked to the 
tablet device? If so, add the id to drivers/serial/8250_pnp.c, build it, 
see if that binds and gives you a serial port and if so send a patch.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
