From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] [PATCH v3 1/2] introduce ALS sysfs class
Date: Tue, 25 Aug 2009 11:36:52 +0800
Message-ID: <1251171412.3483.74.camel@rzhang-dt>
References: <1250671229.17853.51.camel@rzhang-dt>
	 <20090819160144.GB1020@kroah.com> <1250819647.17853.144.camel@rzhang-dt>
	 <20090821150825.GC10667@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17166 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131AbZHYDiP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2009 23:38:15 -0400
In-Reply-To: <20090821150825.GC10667@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>

On Fri, 2009-08-21 at 23:08 +0800, Greg KH wrote:
> On Fri, Aug 21, 2009 at 09:54:07AM +0800, Zhang Rui wrote:
> > ---
> >  Documentation/ABI/testing/sysfs-class-als |   47 +++++
> >  drivers/Kconfig                           |    2 
> >  drivers/Makefile                          |    1 
> >  drivers/als/Kconfig                       |   10 +
> >  drivers/als/Makefile                      |    5 
> >  drivers/als/als_sys.c                     |  256 ++++++++++++++++++++++++++++++
> >  include/linux/als_sys.h                   |   57 ++++++
> 
> Does this file really need to be in include/linux/ ?
> 
> Or could you just put it into drivers/als/ and it would be fine?
> 
I don't think so, because all the other native ALS drivers like ACPI ALS
driver should depend on this header file.

thanks,
rui

