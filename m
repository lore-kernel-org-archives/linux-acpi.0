From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/3] Generic sysfs support for ACPI ALS and other ALS
 devices
Date: Tue, 4 Aug 2009 10:36:27 -0700
Message-ID: <20090804173627.GA23848@kroah.com>
References: <1249290657.2670.250.camel@rzhang-dt>
 <20090804132129.GH18974@elf.ucw.cz>
 <20090804151042.GA20276@kroah.com>
 <19631.1249406664@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39851 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932885AbZHDRly (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Aug 2009 13:41:54 -0400
Content-Disposition: inline
In-Reply-To: <19631.1249406664@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, Aug 04, 2009 at 01:24:24PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 04 Aug 2009 08:10:42 PDT, Greg KH said:
> > On Tue, Aug 04, 2009 at 03:21:29PM +0200, Pavel Machek wrote:
> > > On Mon 2009-08-03 17:10:57, Zhang Rui wrote:
> 
> > > > 	cat /sys/class/als/als0/mappings
> > > > 	???Illuminance	Adjustment
> > > > 	          0	       70
> > > > 	         10	       73
> > > > 	         80	       85
> > > > 	        300	      100
> > > > 	       1000	      150
> > > 
> > > There's one value per file for sysfs... You should definitely have the
> > > header. 
> > 
> > No, no "header", just don't do this, it's not allowed. Again,
> > one-value-per-sysfs-file is the rule, please do not violate it.
> 
> What's the intended sysfs solution here, then? Make 'mappings' a directory,
> and populate it with files called 0, 10, 80, 300, 1000, each with one number
> in them?

That's one acceptable solution.  Or how about files in this directory
called "mapping_0", "mapping_10", and so on, containing the adjustment
value?

thanks,

greg k-h
