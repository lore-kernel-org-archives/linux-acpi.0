From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v3 13/17] ACPI: identify device tree root by null
	parent pointer, not ACPI_BUS_TYPE
Date: Wed, 23 Sep 2009 21:31:32 -0600
Message-ID: <1253763092.12653.14.camel@dc7800.home>
References: <20090921192656.21322.23072.stgit@bob.kio>
	 <20090921192950.21322.63040.stgit@bob.kio>
	 <1253675384.3609.361.camel@localhost.localdomain>
	 <200909231014.47116.bjorn.helgaas@hp.com>
	 <1253758238.3609.414.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:21933 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbZIXDd6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2009 23:33:58 -0400
In-Reply-To: <1253758238.3609.414.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-09-24 at 10:10 +0800, ykzhao wrote:
> On Thu, 2009-09-24 at 00:14 +0800, Bjorn Helgaas wrote:
> > On Tuesday 22 September 2009 09:09:44 pm ykzhao wrote:
> > > On Tue, 2009-09-22 at 03:29 +0800, Bjorn Helgaas wrote:
> > > > We can identify the root of the ACPI device tree by the fact that it
> > > > has no parent.  This is simpler than passing around ACPI_BUS_TYPE_SYSTEM
> > > > and will help remove special treatment of the device tree root.
> > > > 
> > > > Currently, we add the root by hand with ACPI_BUS_TYPE_SYSTEM.  If we
> > > > traverse the tree treating the root as just another device and use
> > > > acpi_get_type(), the root shows up as ACPI_TYPE_DEVICE.
> > > > 
> > > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > > ---
> > > >  drivers/acpi/scan.c     |   20 +++++++++++++-------
> > > >  include/acpi/acpi_bus.h |    1 -
> > > >  2 files changed, 13 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > > index 27d2dec..0b5aaf0 100644
> > > > --- a/drivers/acpi/scan.c
> > > > +++ b/drivers/acpi/scan.c
> > > > @@ -22,6 +22,8 @@ extern struct acpi_device *acpi_root;
> > > >  #define ACPI_BUS_HID			"LNXSYBUS"
> > > >  #define ACPI_BUS_DEVICE_NAME		"System Bus"
> > > >  
> > > > +#define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
> > 
> > > the following definition will be better
> > >    #define ACPI_IS_ROOT_DEVICE(device)  \
> > > 				(device->handle == ACPI_ROOT_OBJECT)
> > 
> > I wish you'd given me a clue about *why* you think it's better to
> > check the handle.
> Every acpi device has its corresponding acpi_handle. We can use this
> info to check whether the device is the root device. 
> 
> Of course it is also ok to check whether the device is the root device
> by using device->parent.
> > 
> > I considered checking the handle, but I used the parent pointer
> > because:
> > 
> >   1) There are synonyms for the root handle: ACPI_ROOT_OBJECT is the
> >      special-case #define to allow ACPICA users to start traversing
> >      the namespace before they know any handles, but acpi_gbl_root_node
> >      is the real root handle.  In fact, if you call acpi_get_parent()
> >      on a child of the root, it returns acpi_gbl_root_node, not
> >      ACPI_ROOT_OBJECT.  This is a bit messy, and it seems safest to
> >      me to just avoid testing against ACPI_ROOT_OBJECT at all.
> > 
> >   2) It's a reminder that the acpi_device tree data structure should
> >      be a proper fully-connected tree with exactly one root.  If we
> >      assume a valid tree, there's exactly one node with no parent.
> >      That's more fundamental than the handle, where you have to
> >      analyze more code to make sure we don't assign ACPI_ROOT_OBJECT
> >      to several nodes.
> > 
> >      (There is existing code that allows disconnected trees to be built.
> >      For example, dock_create_acpi_device() can call acpi_bus_add()
> >      with a NULL parent pointer.  This "shouldn't happen," but I
> >      consider the fact that the interface allows this to be a bug.
> >      That's one reason I'm removing the "parent" argument from
> >      acpi_add_single_object() and related interfaces.)
> > 
> >   3) We build acpi_devices for things with no handle, e.g., functional
> >      fixed hardware.  Their handles happen to be NULL but I prefer to
> >      think of them as undefined and not rely on them at all.
>        Is it possible to build the acpi_device without acpi handle? It
> seems that now we won't create a new acpi device for the functional
> fixed hardware.For example: the acpi handle is NULL when we add the acpi
> device for fixed power/sleep button.  In such case it is still different
> with the ACPI

This paragraph looks truncated, so maybe you didn't quite finish it.  In
any case, we do build acpi_devices for functional fixed hardware in
acpi_bus_scan_fixed(), and those devices have a NULL handle.

> >   4) acpi_walk_namespace(..., ACPI_ROOT_OBJECT, ...) doesn't actually
> >      visit the root node; it starts with the children.  I consider
> >      this a bug.  If it were ever fixed, we would probably call the
> >      callback with acpi_gbl_root_node, not ACPI_ROOT_OBJECT, so the
> >      root acpi_device handle would no longer be ACPI_ROOT_OBJECT.
>        When the ACPI_ROOT_OBJECT is passed to acpi_walk_namespace, then
> it will start from acpi_gbl_root_node(this is changed in the function of
> acpi_ns_walk_namespace).

Yes.  But the callback is never called for the root node, only for the
*children* of that node.  That's why, in patch 14/17 of this series,
where I convert acpi_bus_scan() to use acpi_walk_namespace(), I have to
call acpi_bus_check_add() once by hand on the root of the tree, followed
by acpi_walk_namespace() to walk the rest of the tree.

Bjorn

> > > > +
> > > >  static LIST_HEAD(acpi_device_list);
> > > >  static LIST_HEAD(acpi_bus_id_list);
> > > >  DEFINE_MUTEX(acpi_device_lock);
> > > > @@ -955,10 +957,12 @@ static void acpi_device_get_busid(struct acpi_device *device)
> > > >  	 * The device's Bus ID is simply the object name.
> > > >  	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
> > > >  	 */
> > > > -	switch (device->device_type) {
> > > > -	case ACPI_BUS_TYPE_SYSTEM:
> > > > +	if (ACPI_IS_ROOT_DEVICE(device)) {
> > > >  		strcpy(device->pnp.bus_id, "ACPI");
> > > > -		break;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	switch (device->device_type) {
> > > >  	case ACPI_BUS_TYPE_POWER_BUTTON:
> > > >  		strcpy(device->pnp.bus_id, "PWRF");
> > > >  		break;
> > > > @@ -1093,6 +1097,11 @@ static void acpi_device_set_id(struct acpi_device *device)
> > > >  
> > > >  	switch (device->device_type) {
> > > >  	case ACPI_BUS_TYPE_DEVICE:
> > > > +		if (ACPI_IS_ROOT_DEVICE(device)) {
> > > > +			hid = ACPI_SYSTEM_HID;
> > > > +			break;
> > > > +		}
> > > > +
> > > >  		status = acpi_get_object_info(device->handle, &info);
> > > >  		if (ACPI_FAILURE(status)) {
> > > >  			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
> > > > @@ -1129,9 +1138,6 @@ static void acpi_device_set_id(struct acpi_device *device)
> > > >  	case ACPI_BUS_TYPE_PROCESSOR:
> > > >  		hid = ACPI_PROCESSOR_OBJECT_HID;
> > > >  		break;
> > > > -	case ACPI_BUS_TYPE_SYSTEM:
> > > > -		hid = ACPI_SYSTEM_HID;
> > > > -		break;
> > > >  	case ACPI_BUS_TYPE_THERMAL:
> > > >  		hid = ACPI_THERMAL_HID;
> > > >  		break;
> > > > @@ -1643,7 +1649,7 @@ int __init acpi_scan_init(void)
> > > >  	 * Create the root device in the bus's device tree
> > > >  	 */
> > > >  	result = acpi_add_single_object(&acpi_root, ACPI_ROOT_OBJECT,
> > > > -					ACPI_BUS_TYPE_SYSTEM, &ops);
> > > > +					ACPI_BUS_TYPE_DEVICE, &ops);
> > > >  	if (result)
> > > >  		goto Done;
> > > >  
> > > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > > index 8e39b3e..ef1cb23 100644
> > > > --- a/include/acpi/acpi_bus.h
> > > > +++ b/include/acpi/acpi_bus.h
> > > > @@ -70,7 +70,6 @@ enum acpi_bus_device_type {
> > > >  	ACPI_BUS_TYPE_POWER,
> > > >  	ACPI_BUS_TYPE_PROCESSOR,
> > > >  	ACPI_BUS_TYPE_THERMAL,
> > > > -	ACPI_BUS_TYPE_SYSTEM,
> > > >  	ACPI_BUS_TYPE_POWER_BUTTON,
> > > >  	ACPI_BUS_TYPE_SLEEP_BUTTON,
> > > >  	ACPI_BUS_DEVICE_TYPE_COUNT
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > 
> > 
> 

