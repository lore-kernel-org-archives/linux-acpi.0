From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: dock: Don't eval _STA on every show_docked sysfs read
Date: Fri, 06 Feb 2009 22:11:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902062209270.26256@localhost.localdomain>
References: <1232450304.5286.4.camel@homac.suse.de>
 <20090127130455.2c1b0cd4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:16081 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbZBGELd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 23:11:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00EOPE6VGDC2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 06 Feb 2009 21:11:20 -0600 (CST)
In-reply-to: <20090127130455.2c1b0cd4.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hmacht@suse.de, linux-acpi@vger.kernel.org, stable@kernel.org, Li@suse.de, shaohua.li@intel.com, marvin@mydatex.cz



--
Len Brown, Intel Open Source Technology Center

On Tue, 27 Jan 2009, Andrew Morton wrote:

> On Tue, 20 Jan 2009 12:18:24 +0100
> Holger Macht <hmacht@suse.de> wrote:
> 
> > Cc: stable@kernel.org
> 
> The patch applied OK to 2.6.28 but not to any earlier kernel.  If we
> decide that it should be backported to 2.6.27 or earlier, a new patch
> might be needed for that.
> 
> > Some devices trigger a DEVICE_CHECK on every evalutation of _STA. This
> > can also be seen in commit 8b59560a3baf2e7c24e0fb92ea5d09eca92805db
> > (ACPI: dock: avoid check _STA method).  If an undock is processed, the
> > dock driver sends a uevent and userspace might read the show_docked
> > property in sysfs. This causes an evaluation of _STA of the particular
> > device which causes the dock driver to immediately dock again.
> > 
> > In any case, evaluation of _STA (show_docked) does not necessarily mean
> > that we are docked, so check with the internal device structure.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=12360
> > 
> > Signed-off-by: Holger Macht <hmacht@suse.de>
> > ---
> > 
> > diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> > index 5b30b8d..afd5db3 100644
> > --- a/drivers/acpi/dock.c
> > +++ b/drivers/acpi/dock.c
> > @@ -855,10 +855,14 @@ fdd_out:
> >  static ssize_t show_docked(struct device *dev,
> >  			   struct device_attribute *attr, char *buf)
> >  {
> > +	struct acpi_device *tmp;
> > +
> >  	struct dock_station *dock_station = *((struct dock_station **)
> >  		dev->platform_data);
> > -	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
> >  
> > +	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
> > +		return snprintf(buf, PAGE_SIZE, "1\n");
> > +	return snprintf(buf, PAGE_SIZE, "0\n");
> >  }
> >  static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
> 
> That seems a little overwrought.  Won't plain old strcpy suffice?
> 
> 
> --- a/drivers/acpi/dock.c~acpi-dock-dont-eval-_sta-on-every-show_docked-sysfs-read-simplification
> +++ a/drivers/acpi/dock.c
> @@ -861,8 +861,8 @@ static ssize_t show_docked(struct device
>  		dev->platform_data);
>  
>  	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
> -		return snprintf(buf, PAGE_SIZE, "1\n");
> -	return snprintf(buf, PAGE_SIZE, "0\n");
> +		return strcpy(buf, "1\n");
> +	return strcpy(buf, "0\n");
>  }
>  static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
>  
> _
> 

sure, strcpy is fine b/c the src and dest are known to not be in danger of 
overlow.  applied to acpi misc branch.

thanks,
-Len

