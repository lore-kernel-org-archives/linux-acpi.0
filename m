From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] ACPI / PM: Expose lists of device power resources to user space
Date: Wed, 23 Jan 2013 01:08:54 +0100
Message-ID: <4110339.gOkm8VAsyn@vostro.rjw.lan>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan> <1477263.uvKKInuF7l@vostro.rjw.lan> <20130122235624.GF694@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130122235624.GF694@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 22, 2013 03:56:24 PM Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2013 at 03:28:23AM +0100, Rafael J. Wysocki wrote:
> > +static struct attribute *attrs[] = {
> > +	NULL,
> > +};
> 
> That's "odd"...

Well, I don't really need file attributes here (at least at the moment),
but sysfs_create_group() will complain if I just pass NULL in there.

> > +static void acpi_power_hide_list(struct acpi_device *adev,
> > +				 struct acpi_device_power_state *ps,
> > +				 const char *group_name)
> >  {
> > -	if (adev->power.flags.power_resources) {
> > -		struct acpi_device_power_state *ps;
> > -		struct acpi_power_resource_entry *entry;
> > -
> > -		ps = &adev->power.states[ACPI_STATE_D0];
> > -		list_for_each_entry(entry, &ps->resources, node) {
> > -			struct acpi_power_resource *resource = entry->resource;
> > -
> > -			if (add)
> > -				acpi_power_add_dependent(resource, adev);
> > -			else
> > -				acpi_power_remove_dependent(resource, adev);
> > +	struct attribute_group attr_group = {
> > +		.name	= group_name,
> > +		.attrs	= attrs,
> > +	};
> 
> This is on the stack, which seems like it would not be good...
> 
> > +	struct acpi_power_resource_entry *entry;
> > +
> > +	list_for_each_entry_reverse(entry, &ps->resources, node) {
> > +		struct acpi_device *res_dev = &entry->resource->device;
> > +
> > +		sysfs_remove_link_from_group(&adev->dev.kobj, group_name,
> > +					     dev_name(&res_dev->dev));
> > +	}
> > +	sysfs_remove_group(&adev->dev.kobj, &attr_group);
> 
> You aren't removing the same group that you created.  Well, kind of, but
> that's strange, it really works?

Yes, it does, as far as I can say.

> > +static void acpi_power_expose_list(struct acpi_device *adev,
> > +				   struct acpi_device_power_state *ps,
> > +				   const char *group_name)
> > +{
> > +	struct attribute_group attr_group = {
> > +		.name	= group_name,
> > +		.attrs	= attrs,
> > +	};
> 
> again a structure on the stack.
> 
> Why not just create the attribute groups as static, instead of
> "pseudo-dynamically" like you are doing here?

Basically because I'm lazy. :-)

They can be static if that's better.

> I have no idea if sysfs
> can properly cope with an attribute group pointer that disappears after
> it has been registered with the sysfs core.  That seems ripe for
> problems, don't you agree?

I don't think so having looked at the code, but I very well might overlook
something.  I'll change that.

> Oh, and same question about racing userspace, you will have problems
> here in that the symlinks will be showing up after the device is
> created.  Perhaps, to make the whole thing easier, you just change the
> acpi core code to hold off on the notification until you get all of
> these links and files set up and then tell userspace.  That's probably
> an easier fix.

I suppose so.

How can I do that?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
