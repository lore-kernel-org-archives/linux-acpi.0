From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: dock: Don't eval _STA on every show_docked sysfs
 read
Date: Fri, 6 Feb 2009 19:18:39 -0800
Message-ID: <20090206191839.6c96e375.akpm@linux-foundation.org>
References: <1232450304.5286.4.camel@homac.suse.de>
	<20090127130455.2c1b0cd4.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0902062209270.26256@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40344 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754807AbZBGDTc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 22:19:32 -0500
In-Reply-To: <alpine.LFD.2.00.0902062209270.26256@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: hmacht@suse.de, linux-acpi@vger.kernel.org, stable@kernel.org, Li@suse.de, shaohua.li@intel.com, marvin@mydatex.cz

On Fri, 06 Feb 2009 22:11:15 -0500 (EST) Len Brown <lenb@kernel.org> wrote:

> 
> 
> --
> Len Brown, Intel Open Source Technology Center
> 
> On Tue, 27 Jan 2009, Andrew Morton wrote:
> 
> > On Tue, 20 Jan 2009 12:18:24 +0100
> > Holger Macht <hmacht@suse.de> wrote:
> > 
> > > Cc: stable@kernel.org
> > 
> > The patch applied OK to 2.6.28 but not to any earlier kernel.  If we
> > decide that it should be backported to 2.6.27 or earlier, a new patch
> > might be needed for that.
> > 
> > > Some devices trigger a DEVICE_CHECK on every evalutation of _STA. This
> > > can also be seen in commit 8b59560a3baf2e7c24e0fb92ea5d09eca92805db
> > > (ACPI: dock: avoid check _STA method).  If an undock is processed, the
> > > dock driver sends a uevent and userspace might read the show_docked
> > > property in sysfs. This causes an evaluation of _STA of the particular
> > > device which causes the dock driver to immediately dock again.
> > > 
> > > In any case, evaluation of _STA (show_docked) does not necessarily mean
> > > that we are docked, so check with the internal device structure.
> > > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=12360
> > > 
> > > Signed-off-by: Holger Macht <hmacht@suse.de>
> > > ---
> > > 
> > > diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> > > index 5b30b8d..afd5db3 100644
> > > --- a/drivers/acpi/dock.c
> > > +++ b/drivers/acpi/dock.c
> > > @@ -855,10 +855,14 @@ fdd_out:
> > >  static ssize_t show_docked(struct device *dev,
> > >  			   struct device_attribute *attr, char *buf)
> > >  {
> > > +	struct acpi_device *tmp;
> > > +
> > >  	struct dock_station *dock_station = *((struct dock_station **)
> > >  		dev->platform_data);
> > > -	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
> > >  
> > > +	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
> > > +		return snprintf(buf, PAGE_SIZE, "1\n");
> > > +	return snprintf(buf, PAGE_SIZE, "0\n");
> > >  }
> > >  static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
> > 
> > That seems a little overwrought.  Won't plain old strcpy suffice?
> > 
> > 
> > --- a/drivers/acpi/dock.c~acpi-dock-dont-eval-_sta-on-every-show_docked-sysfs-read-simplification
> > +++ a/drivers/acpi/dock.c
> > @@ -861,8 +861,8 @@ static ssize_t show_docked(struct device
> >  		dev->platform_data);
> >  
> >  	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
> > -		return snprintf(buf, PAGE_SIZE, "1\n");
> > -	return snprintf(buf, PAGE_SIZE, "0\n");
> > +		return strcpy(buf, "1\n");
> > +	return strcpy(buf, "0\n");
> >  }
> >  static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
> >  
> > _
> > 
> 
> sure, strcpy is fine b/c the src and dest are known to not be in danger of 
> overlow.  applied to acpi misc branch.

argh, sorry, don't apply the strcpy() version - it's buggy.  It returns
the address of the string (and a compile warning) rather than the
amount-of-data-available.

