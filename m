From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode to linux-acpi@vger.kernel.org - SANTA ROSA CRB
Date: Sun, 20 Jan 2008 19:37:25 -0500
Message-ID: <200801201937.25476.lenb@kernel.org>
References: <471DF1ED.7090107@gmx.de> <200801182352.18426.lenb@kernel.org> <47923589.9090506@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54782 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755697AbYAUAhr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 19:37:47 -0500
In-Reply-To: <47923589.9090506@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sur3 <sur3@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 12:38, Sur3 wrote:
> Len Brown schrieb:
> > is this a production system?
> > If yes, can you upgrade to a production BIOS?
> > 
> > then...
> > 
> > Do you notice any functional difference when booting with
> > 
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> > 
> > Also, please send me the output from acpidump.
> > 
> > thanks,
> > -Len
> > 
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> 
> 
> hi Len,
> the acpidump is in the attachment.
> what do you mean by "production system"?

This system seems to be running the BIOS from an Intel example design,
which is an example implementation for our customers, not intended
really for retail systems.

> it's kind of a normal laptop.

I'm curious what brand and what model it is.

> i'll check for differences with the different boot-params the next days...

You don't have to, OSI(Linux) is a NOP in this BIOS.
Like many others, it sets LINX, but never uses it.

It does remind me to ping the BIOS group and verify
that they've delted this from their latest BIOS.

maybe I should update the dmesg to say:

BIOS BUG: Please tell your BIOS vendor not to query _OSI(Linux)

thanks,
-Len
