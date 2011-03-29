From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/3] acpi: Split out custom_method functionality into an own driver
Date: Tue, 29 Mar 2011 23:11:09 +0200
Message-ID: <201103292311.10991.trenn@suse.de>
References: <1301401990-35469-1-git-send-email-trenn@suse.de> <1301401990-35469-4-git-send-email-trenn@suse.de> <201103292136.50214.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35029 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab1C2VLW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2011 17:11:22 -0400
In-Reply-To: <201103292136.50214.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Tuesday 29 March 2011 21:36:50 Rafael J. Wysocki wrote:
> On Tuesday, March 29, 2011, Thomas Renninger wrote:
> > With /sys/kernel/debug/acpi/custom_method root can write
> > to arbitrary memory and increase his priveleges, even if
> > these are restricted.
> > 
> > -> Make this an own debug .config option and warn about the
> > security issue in the config description.
> > 
> > -> Still keep acpi/debugfs.c which now only creates and empty
> >    /sys/kernel/debug/acpi directory. There might be other
> >    users of it later.
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: Rafael J. Wysocki <rjw@sisk.pl>
> > CC: lenb@kernel.org
> > CC: rui.zhang@intel.com
> > CC: linux-acpi@vger.kernel.org
> 
> OK, but you don't need to move custom_method to a separate file.  Why
> are you doing that, exactly?
Because there may come other acpi debugfs stuff added there and then
it either needs ugly #ifdef logics inside the file or the split will be done then.
Separating the code belonging to this option into an own
file looks like the cleanest way to me.
 
> > +config ACPI_CUSTOM_METHOD
> > +	tristate "ACPI function runtime override debug utility (SECURITY ALERT)"
> 
> I wouldn't put the "SECURITY ALERT" in the option string.  I'd call it
> "Allow ACPI methods to be inserted/replaced at run time"
I agree.
> 
> > +	depends on DEBUG_FS
> > +	default n
> > +	help
> > +	  This is an ACPI debug facility:
> 
> Here, I'd say:
> "This debug facility allows ACPI AML methods to me inserted and/or replaced
> without rebooting the system.  For details refer to "
Yep, I'll fix the wording of this one and the rest and will resubmit tomorrow.

Thanks,

    Thomas
