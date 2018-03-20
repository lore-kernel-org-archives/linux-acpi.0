From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI / scan: Send the change uevent with offine
 environmental data
Date: Tue, 20 Mar 2018 13:52:54 +0800
Message-ID: <20180320055254.GJ15088@linux-l9pv.suse>
References: <20180302063508.15818-1-jlee@suse.com>
 <12390857.1FYhrZHzGj@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12390857.1FYhrZHzGj@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael, 

On Mon, Mar 19, 2018 at 11:02:32AM +0100, Rafael J. Wysocki wrote:
> On Friday, March 2, 2018 7:35:08 AM CET Lee, Chun-Yi wrote:
> > In current design of ACPI container offline, Kernel emits
> > KOBJ_CHANGE uevent to user space to indidate that the ejection of
> > the container was triggered by platform. (caa73ea15 patch)
> > 
> > A pure KOBJ_CHANGE uevent is not enough for user space to identify
> > the purpose. For example, a "udevadm trigger" command can also
> > be used to emit change event to all udev rules. A udev rule can not
> > identify that the event is from kernel for offline or from udevadm
> > for other purpose. Then the offline action in udev rule may also be
> > triggered by udevadm tool.
> > 
> > So, similar to the change uevent of dock, kernel sends the
> > KOBJ_CHANGE uevent with a offline environmental data to indicate
> > purpose. It's useful by udev rule for using ENV{EVENT} filter.
> > 
> > Cc: Michal Hocko <mhocko@kernel.org> 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> 
> > Cc: Len Brown <lenb@kernel.org> 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  drivers/acpi/scan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 8e63d93..f6dca9b 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -116,6 +116,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
> >  {
> >  	struct acpi_device_physical_node *pn;
> >  	bool offline = true;
> > +	static const char *envp[] = { "EVENT=offline", NULL };
> >  
> >  	/*
> >  	 * acpi_container_offline() calls this for all of the container's
> > @@ -126,7 +127,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
> >  	list_for_each_entry(pn, &adev->physical_node_list, node)
> >  		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
> >  			if (uevent)
> > -				kobject_uevent(&pn->dev->kobj, KOBJ_CHANGE);
> > +				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
> >  
> >  			offline = false;
> >  			break;
> > 
> 
> This causes build issues when applied, please fix.
> 

I just sent the v2 patch. Thanks for your review!

Joey Lee 
