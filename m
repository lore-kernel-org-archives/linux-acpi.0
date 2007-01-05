From: Mattia Dongili <malattia@linux.it>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 20:10:45 +0100
Message-ID: <20070105191045.GI13533@inferi.kami.home>
References: <459D4051.9020506@tlen.pl> <200701051233.20366.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:49078 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422677AbXAETLW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2007 14:11:22 -0500
Content-Disposition: inline
In-Reply-To: <200701051233.20366.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Cacy Rodney <cacy-rodney-cacy@tlen.pl>, linux-acpi@vger.kernel.org

On Fri, Jan 05, 2007 at 12:33:20PM -0500, Len Brown wrote:
[...]
> With /proc/acpi/ going away, this raises the question of where sony_acpi should put stuff
> that is under development -- as unlike brightness -- it will not have a generic home in sysfs.

I was thinking the same and had 2 options in my mind:

1- debugfs (with proper documentation)

2- turn the SNC into a platform_device driver (as is msi-laptop) and
   eventually  create .config options to enable experimental/debug
   features.

> To do it right,  some analysis of the DSDT which has these vendor methods in them
> will be necessary.  It is conceivable that these methods can be hooked to the generic
> device power management support if the "real" devices in sysfs can be found.

In my DSDT[1] some of the methods (the audio card power setter: AZPW)
references a method in the real device (the same used in
_PS0 and _PS3 for the device) so it's actually a duplicate and the real
device already has the capability. I'd say all the others are playing
with random IO registers or in the EC0 operation region.

[1]: sz72b http://oioio.altervista.org/linux/DSDT.sz72b.dsl

other DSDTs I have:
http://oioio.altervista.org/linux/DSDT.ux50.dsl
http://oioio.altervista.org/linux/DSDT.gr7k.dsl

> A word of warning, which may be totally obvious here, is that the method names above
> are completely arbitrary choices on the part of a BIOS engineer at Sony, and the
> next BIOS engineer can make completely different choices for what names are used
> or what the same names do.

This is already partly happened, at least a known old method name has
mutated.

I'll send a first rush of patches as soon as I decide how to deal with
the different method names.
-- 
mattia
:wq!
