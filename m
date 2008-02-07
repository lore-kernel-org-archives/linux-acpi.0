From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 110/112] ACPI: update intrd DSDT override console messages
Date: Thu, 7 Feb 2008 13:44:04 -0500
Message-ID: <200802071344.04447.lenb@kernel.org>
References: <47AAE619.4070108@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58419 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbYBGSoT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 13:44:19 -0500
In-Reply-To: <47AAE619.4070108@tremplin-utc.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Piel <eric.piel@tremplin-utc.net>
Cc: linux-acpi@vger.kernel.org

On Thursday 07 February 2008 06:06, Eric Piel wrote:
> (sorry for not keeping the message id, I'm not subscribed to linux-acpi)
> > From: Len Brown <len.brown@intel.com>
> > 
> > also, address some checkpatch.pl violations
> > 
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---
> >  drivers/acpi/osl.c |   33 ++++++++++++++++++---------------
> >  1 files changed, 18 insertions(+), 15 deletions(-)
> :
> >  
> > -	printk(KERN_INFO PREFIX "Looking for DSDT in initramfs... ");
> > +	printk(KERN_INFO PREFIX "Checking initramfs for custom DSDT");
> You need to also add a \n here. Otherwise in case of error it will look 
> ugly ;-)

got it.

thanks,
-len
