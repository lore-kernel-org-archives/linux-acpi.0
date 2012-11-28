From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 217/493] acpi: remove use of __devinit
Date: Wed, 28 Nov 2012 11:00:02 -0800
Message-ID: <20121128190002.GA30743@kroah.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-217-git-send-email-wfp5p@virginia.edu>
 <3003032.3Hm8RaEcML@vostro.rjw.lan>
 <11689359.E4tRqmmlBk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58313 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755696Ab2K1TAI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2012 14:00:08 -0500
Content-Disposition: inline
In-Reply-To: <11689359.E4tRqmmlBk@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bill Pemberton <wfp5p@virginia.edu>, linux-acpi@vger.kernel.org

On Thu, Nov 22, 2012 at 01:18:09AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, November 21, 2012 01:46:36 AM Rafael J. Wysocki wrote:
> > On Monday, November 19, 2012 01:22:46 PM Bill Pemberton wrote:
> > > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > > needed.
> > 
> > Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.
> 
> And dropped, because it causes build problems to happen in
> acpi_pci_root_add() in my tree.

What kind of problems?  If CONFIG_HOTPLUG is enabled __devinit defines
away to nothing, so this shouldn't have broken anything.

thanks,

greg k-h
