From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/3] Generic sysfs support for ACPI ALS and other ALS
	devices
Date: Wed, 05 Aug 2009 09:04:52 +0800
Message-ID: <1249434292.2670.388.camel@rzhang-dt>
References: <1249290657.2670.250.camel@rzhang-dt>
	 <20090804132129.GH18974@elf.ucw.cz> <20090804151042.GA20276@kroah.com>
	 <19631.1249406664@turing-police.cc.vt.edu>
	 <20090804173627.GA23848@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35439 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932632AbZHEBFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Aug 2009 21:05:19 -0400
In-Reply-To: <20090804173627.GA23848@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>, Pavel Machek <pavel@ucw.cz>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>

On Wed, 2009-08-05 at 01:36 +0800, Greg KH wrote:
> On Tue, Aug 04, 2009 at 01:24:24PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 04 Aug 2009 08:10:42 PDT, Greg KH said:
> > > On Tue, Aug 04, 2009 at 03:21:29PM +0200, Pavel Machek wrote:
> > > > On Mon 2009-08-03 17:10:57, Zhang Rui wrote:
> > 
> > > > > 	cat /sys/class/als/als0/mappings
> > > > > 	???Illuminance	Adjustment
> > > > > 	          0	       70
> > > > > 	         10	       73
> > > > > 	         80	       85
> > > > > 	        300	      100
> > > > > 	       1000	      150
> > > > 
> > > > There's one value per file for sysfs... You should definitely have the
> > > > header. 
> > > 
> > > No, no "header", just don't do this, it's not allowed. Again,
> > > one-value-per-sysfs-file is the rule, please do not violate it.
> > 
> > What's the intended sysfs solution here, then? Make 'mappings' a directory,
> > and populate it with files called 0, 10, 80, 300, 1000, each with one number
> > in them?
> 
> That's one acceptable solution.  Or how about files in this directory
> called "mapping_0", "mapping_10", and so on, containing the adjustment
> value?
> 
great. that's what I'm going to do.
refreshed patch will be sent out later. :)

thanks,
rui


