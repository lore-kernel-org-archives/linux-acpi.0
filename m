From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Kernel (2.6.26 final) Oops, problem?
Date: Fri, 01 Aug 2008 17:22:28 -0400
Message-ID: <200808011722.28961.gene.heskett@gmail.com>
References: <200807312218.39479.gene.heskett@gmail.com>
 <200807312359.13737.gene.heskett@gmail.com> <20080801190428.GA2828@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:41311 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763602AbYHAVWa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 17:22:30 -0400
In-reply-to: <20080801190428.GA2828@debian>
Content-disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ming.m.lin@intel.com

On Friday 01 August 2008, Rabin Vincent wrote:

[...]
>f88133d76ea38761b7379d6233b752ed82250a4a in current git appears to be a
>fix for this.
>
>Rabin

So I assume that it will be in 2.6.27-rc2?

I've not seen it again, and the machine ran fine till I rebooted after fixing 
the httpd error.log permissions problem in 2.6.27-rc1.

However, I do see in the log that it is loading the rv200 microcode for 
something, but my video card is an rv280 based card, a Radeon 9200SE, using 
that radeon driver.

Does anyone know if this is correct?

The card seems to be ok, and glxgears says its in the low 600 fps at the 
default image size.  Just barely fast enough for google-earth if one isn't 
super-picky.  I also have a 2400-HD, but its not any faster with the radeonhd 
driver.  Neither driver has been updated recently that yumex has told me 
about.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Circumstances rule men; men do not rule circumstances.
		-- Herodotus
