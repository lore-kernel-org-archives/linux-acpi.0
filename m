From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Overriding DSDT and ignored resources
Date: Wed, 28 Jan 2015 17:48:21 +0100
Message-ID: <20150128174821.725b64da4c840a3541e51866@ao2.it>
References: <20150122145729.281f038e8326019a50612e37@ao2.it>
	<20150128102157.GC1451@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:18929 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934401AbbDVIto (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Apr 2015 04:49:44 -0400
Received: from jcn (82.61.46.181) by smtp205.alice.it (8.6.060.28)
        id 552F94760157A06E for linux-acpi@vger.kernel.org; Wed, 22 Apr 2015 10:44:14 +0200
In-Reply-To: <20150128102157.GC1451@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, 28 Jan 2015 12:21:57 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Thu, Jan 22, 2015 at 02:57:29PM +0100, Antonio Ospite wrote:
> > Hi,
> > 
> > it looks like linux can't use the correct PCI host resources when using
> > an overridden DSDT table, even with an _unmodified_ one.
> > 
> > I am using 3.19-rc5 rather vanilla (no acpi changes anyways) on a Bay
> > Trail tablet.
> > 
> > When I override the DSDT table I get these messages, and most of the
> > devices don't work anymore:
> > 
[...]

> Are you using the latest ACPICA?
>

acpica-tools 20141107

> > Can anyone else reproduce that?
> 
> Nope, but I have done several times following:
> 
>  1) Take the DSDT dump
>  2) iasl -d DSDT
>  3) iasl -tc DSDT.dsl
> 
>  (the above will make .hex file)
> 
>  4) Edit your .config and add:
> 
>  CONFIG_STANDALONE=n
>  CONFIG_ACPI_CUSTOM_DSDT_FILE="/path/to/your/DSDT.hex"
> 
>  5) Rebuild and reboot
> 
> That typically works for me.

OK, that was not necessary, the initrd method works just fine.

Once I knew you couldn't replicate it, I redid all the steps and now it
works. It was obviously something wrong on my side, the difference
between a working an a non working DSDT in my case is basically this:

-    OperationRegion (GNVS, SystemMemory, 0x7C22BA98, 0x0334)
+    OperationRegion (GNVS, SystemMemory, 0x7BEBAA98, 0x0334)

Probably I was using a dump from a firmware version different than the
one I was trying to override.

Sorry for the noise.

BTW, in my previous attempts I also ended up patching the pin numbers
in the original DSDT by hand and fixing up the checksum as an
experiment, if anyone ever needed to do that here is a trivial tool to
calculate and verify the checksum of a DSDT table:
http://git.ao2.it/experiments/ACPI.git/blob/HEAD:/acpi_table_checksum.py

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
