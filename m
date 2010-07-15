From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH_v7 2/2] ACPI/IPMI: Add the IPMI opregion driver to
	enable ACPI to access BMC controller
Date: Thu, 15 Jul 2010 09:31:06 +0800
Message-ID: <1279157466.3660.52.camel@localhost.localdomain>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com>
	 <1279112094-16749-2-git-send-email-yakui.zhao@intel.com>
	 <1279112094-16749-3-git-send-email-yakui.zhao@intel.com>
	 <201007141124.57495.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11765 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758066Ab0GOBev (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 21:34:51 -0400
In-Reply-To: <201007141124.57495.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>

On Thu, 2010-07-15 at 01:24 +0800, Bjorn Helgaas wrote:
> On Wednesday, July 14, 2010 06:54:54 am yakui.zhao@intel.com wrote:
> > +config ACPI_IPMI
> > +	tristate "IPMI"
> > +	depends on EXPERIMENTAL && IPMI_SI && IPMI_HANDLER
> > +	default n
> > +	help
> > +	  This driver enables the ACPI to access the BMC controller. And it
> > +	  uses the IPMI request/response message to communicate with BMC
> > +	  controller, which can be found on on the server.
> > +
> > +	  To compile this driver as a module, choose M here:
> 
> This is missing the usual "the module will be called acpi_ipmi"
> text.

Will you please look at this thread
http://marc.info/?l=linux-acpi&m=127608894610765&w=4?

Before this patch, I followed your comment and put the ACPI IPMI
opregion code into the IPMI_SI module. 

But in fact the IPMI opregion code has nothing to do with the ipmi
system interface. It is enough to use the IPMI API interface. In such
case maybe it is a better choice to put the IPMI opregion code into the
separate file. (In fact Corey suggests that the IPMI opregion code be
put into the separate file). 

> 
> But I don't think this is the right design.  I think it's fine to
> put all this code in a separate file and have a separate config
> option for it.
> 
> However, I don't think acpi_ipmi and ipmi_si should be different
> modules, because they both want to be connected to the same ACPI
> device.  Making acpi_ipmi a separate module means you have to
> mess around with PNP core things that drivers shouldn't be using.
> For example, you have match_device(), pnp_ipmi_match(), and
> acpi_add_ipmi_devices() below.  These all reimplement things
> the PNP core already does.

If we decide to put the IPMI opregion code into the separate file, the
next is how to *correctly* create the IPMI user interface between ACPI
subsystem and the corresponding BMC controller.The user interface is the
communication channel used to send/receive IPMI message to/from the BMC
controller. 
In such case we will use the IPMI smi watcher to create/destroy the IPMI
user interface between ACPI and the corresponding BMC controller. But it
is noted that we should assure whether the corresponding IPMI BMC
controller is registered by using ACPI detection mechanism when creating
the relationship between ACPI and IPMI BMC controller. This is realized
by comparing the "device handle". And before comparing the "device
handle", maybe we will have to get the corresponding device lists with
the device id "IPI0001".

Do you have other idea about how to *correctly* create the user
interface between ACPI and IPMI BMC controller?

> 
> The problem with replicating this in acpi_ipmi is that it breaks
> the modularity of PNP.  It means that hotplug of ACPI devices
> won't work right, because acpi_ipmi won't find out about additions
> or removals of IPI0001 devices.
> 
> This ACPI opregion stuff is basically an optional feature of
> whatever driver claims IPI0001 devices, and I think we need to
> set up and tear down the opregion handler at the same point we
> claim and release the IPI0001 devices, i.e., in ipmi_si_intf.c

Thanks for your comments about the following code style. I will do some
cleanup next time. But the prerequisite is whether it is necessary to
put the IPMI opregion code  into the separate file. 

> 
> > +static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
> > +		acpi_integer *value, int timeout)
> > +{
> > +	struct acpi_ipmi_buffer *buffer;
> > +
> > +	/*
> > +	 * value is also used as output parameter. It represents the response
> > +	 * IPMI message returned by IPMI command.
> > +	 */
> > +	buffer = (struct acpi_ipmi_buffer *)value;
> > +	if (!timeout && !msg->msg_done) {
> > +		buffer->status = ACPI_IPMI_TIMEOUT;
> > +		return;
> > +	}
> > +	/*
> > +	 * If the flag of msg_done is not set or the recv length is zero, it
> > +	 * means that the IPMI command is not executed correctly.
> > +	 * The status code will be ACPI_IPMI_UNKNOWN.
> > +	 */
> > +	if (!msg->msg_done || !msg->rx_len) {
> > +		buffer->status = ACPI_IPMI_UNKNOWN;
> > +		return;
> > +	}
> > +	/*
> > +	 * If the IPMI response message is obtained correctly, the status code
> > +	 * will be ACPI_IPMI_OK
> > +	 */
> > +	buffer->status = ACPI_IPMI_OK;
> > +	buffer->length = msg->rx_len;
> > +	memcpy(buffer->data, msg->rx_data, msg->rx_len);
> > +	return;
> 
> You never need a "return" at the end of a void function.
> 
> > +}
> > +static void ipmi_destroy_tx_msg(struct acpi_ipmi_device *ipmi)
> > +{
> > +	struct acpi_ipmi_msg *tx_msg = NULL, *temp;
> 
> No need to initialize tx_msg here; list_for_each_entry_safe()
> always sets it before you can use it.
> 
> > +	int count = 20;
> > +	struct pnp_dev *pnp_dev = ipmi->pnp_dev;
> > +
> > +	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
> > +		/* wake up the sleep thread on the Tx msg */
> > +		complete(&tx_msg->tx_complete);
> > +	}
> > +
> > +	/* wait for about 20 ticks to flush the tx message list */
> > +	while (count--) {
> > +		if (list_empty(&ipmi->tx_msg_list))
> > +			break;
> > +		schedule_timeout(1);
> 
> The length of time this waits depends on the arch's jiffy length.
> The jiffy length is completely independent of how long it might
> take to flush the message list.  Instead of waiting for "1" jiffy,
> you should use some expression involving HZ, or maybe use
> msecs_to_jiffies().
> 
> > +	}
> > +	if (!list_empty(&ipmi->tx_msg_list))
> > +		dev_warn(&pnp_dev->dev, "tx msg list is not NULL\n");
> > +
> > +}
> > +
> > +static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
> > +{
> > +	struct acpi_ipmi_device *ipmi_device =
> > +			(struct acpi_ipmi_device *)user_msg_data;
> 
> You don't need a cast here, since user_msg_data is a "void *".
> 
> > +	int msg_found = 0;
> > +	struct acpi_ipmi_msg *tx_msg = NULL;
> 
> No need to initialize tx_msg here.
> 
> > +	struct pnp_dev *pnp_dev = ipmi_device->pnp_dev;
> > +
> > +	if (msg->user != ipmi_device->user_interface) {
> > +		dev_warn(&pnp_dev->dev, "Incorrect IPMI user\n");
> 
> Include the user info here, e.g.,
> 
>     dev_warn(..., "unexpected user %#x (expected %#x)\n", msg->user,
>              ipmi_device->user_interface);
> 
> > +		ipmi_free_recv_msg(msg);
> > +		return;
> > +	}
> > +	mutex_lock(&ipmi_device->mutex_lock);
> > +	list_for_each_entry(tx_msg, &ipmi_device->tx_msg_list, head) {
> > +		if (msg->msgid == tx_msg->tx_msgid) {
> > +			/* find the message id */
> 
> Superfluous comment; remove it.
> 
> > +			msg_found = 1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&ipmi_device->mutex_lock);
> > +	if (!msg_found) {
> > +		/* no matched msg is found . But we should free it */
> 
> Superfluous comment; remove it.
> 
> > +		ipmi_free_recv_msg(msg);
> > +		dev_warn(&pnp_dev->dev, "Incorrect MSG is found\n");
> 
> Move the dev_warn() up a line and make it say something like this:
> 
>     dev_warn(..., "unexpected response (msg ID %#x)\n", msg->msgid);
> 
> > +		return;
> > +	}
> > +
> > +	if (msg->msg.data_len) {
> > +		/* copy the response data to Rx_data buffer */
> > +		memcpy(tx_msg->rx_data, msg->msg_data, msg->msg.data_len);
> > +		tx_msg->rx_len = msg->msg.data_len;
> > +		tx_msg->msg_done = 1;
> > +	}
> > +	complete(&tx_msg->tx_complete);
> > +	ipmi_free_recv_msg(msg);
> > +};
> > +
> > +static void ipmi_register_bmc(int iface, struct device *dev)
> > +{
> > +	struct acpi_ipmi_device *ipmi_device;
> > +	struct pnp_dev *device;
> > +	ipmi_user_t		user;
> > +	int err;
> > +
> > +	if (list_empty(&driver_data.ipmi_devices))
> > +		return;
> 
> You don't need to test for list_empty before using
> list_for_each_entry().
> 
> > +
> > +	list_for_each_entry(ipmi_device, &driver_data.ipmi_devices, head) {
> > +		if (ipmi_device->user_interface) {
> > +			/*
> > +			 * Only one user interface is allowed to be registered
> > +			 * for one IPMI device.
> > +			 * If we already create the user interface for
> > +			 * one IPMI device, skip it
> > +			 */
> > +			continue;
> > +		}
> > +		device = ipmi_device->pnp_dev;
> > +		if (dev == &device->dev) {
> > +			/*
> > +			 * If the dev is identical to the ACPI device,
> > +			 * create the user interface.
> > +			 */
> > +			err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
> > +						ipmi_device, &user);
> > +			if (err == 0) {
> > +				ipmi_device->user_interface = user;
> > +				ipmi_device->ipmi_ifnum = iface;
> > +			}
> > +
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static void ipmi_bmc_gone(int iface)
> > +{
> > +	struct acpi_ipmi_device *ipmi_device, *temp;
> > +
> > +	if (list_empty(&driver_data.ipmi_devices))
> > +		return;
> 
> You don't need to test for list_empty before using
> list_for_each_entry_safe()

IMO it is needed as it does the operation of list deletion.

> 
> > +
> > +	list_for_each_entry_safe(ipmi_device, temp,
> > +				&driver_data.ipmi_devices, head) {
> > +		if (ipmi_device->user_interface &&
> > +			(ipmi_device->ipmi_ifnum == iface)) {
> > +			ipmi_destroy_user(ipmi_device->user_interface);
> > +			ipmi_device->user_interface = NULL;
> > +			ipmi_destroy_tx_msg(ipmi_device);
> > +		}
> > +	}
> > +}
> 
> > +	status = acpi_install_address_space_handler(ipmi->handle,
> > +						    ACPI_ADR_SPACE_IPMI,
> > +						    &acpi_ipmi_space_handler,
> > +						    NULL, ipmi);
> > +	if (ACPI_FAILURE(status)) {
> > +		struct pnp_dev *pnp_dev = ipmi->pnp_dev;
> > +		dev_warn(&pnp_dev->dev, "Can't register IPMI opregion for %s\n",
> > +					pnp_dev_name(pnp_dev));
> 
> I'm actually not sure what pnp_dev_name() is for.  I'd rather not
> add more uses of it.  I think dev_warn() prints all the information
> we need, even without using pnp_dev_name().
> 
> > +static const struct pnp_device_id ipmi_device_ids[] = {
> > +	{"IPI0001", 0},
> > +	{"", 0},
> > +};
> > +
> > +static int match_device(struct pnp_dev *dev, const struct pnp_device_id *ids)
> > +{
> > +	const struct pnp_device_id *id;
> > +	struct pnp_id *pnp_id;
> > +
> > +	for (id = ids;  id->id[0]; id++) {
> > +		pnp_id = dev->id;
> > +		if (!pnp_id)
> > +			return 0;
> > +
> > +		while (pnp_id) {
> > +			if (!strncasecmp(pnp_id->id, (char *)id->id,
> > +					strlen((char *)id->id)))
> > +				return 1;
> > +			pnp_id = pnp_id->next;
> > +		};
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int pnp_ipmi_match(struct device *dev, void *data)
> > +{
> > +	struct pnp_dev *pnp_dev;
> > +	struct acpi_ipmi_device *ipmi_device;
> > +	struct acpi_device *acpi_dev;
> > +
> > +	pnp_dev = to_pnp_dev(dev);
> > +
> > +	if (!match_device(pnp_dev, ipmi_device_ids))
> > +		return 0;
> > +
> > +	ipmi_device = kzalloc(sizeof(*ipmi_device), GFP_KERNEL);
> > +	if (!ipmi_device) {
> > +		dev_warn(dev, "Can't allocate memory for acpi_ipmi_device\n");
> > +		return -ENOMEM;
> > +	}
> > +	acpi_dev = pnp_acpi_device(pnp_dev);
> > +	INIT_LIST_HEAD(&ipmi_device->head);
> > +	ipmi_device->pnp_dev = pnp_dev;
> > +	ipmi_device->handle = acpi_dev->handle;
> > +
> > +	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> > +	return 0;
> > +}
> > +
> > +static void acpi_add_ipmi_devices(void)
> > +{
> > +	struct acpi_ipmi_device *ipmi_device;
> > +
> > +	bus_for_each_dev(&pnp_bus_type, NULL, NULL, pnp_ipmi_match);
> > +	if (list_empty(&driver_data.ipmi_devices))
> > +		return;
> 
> You don't need to test for an empty list here.
> 
> > +
> > +	list_for_each_entry(ipmi_device, &driver_data.ipmi_devices, head) {
> > +		mutex_init(&ipmi_device->mutex_lock);
> > +		INIT_LIST_HEAD(&ipmi_device->tx_msg_list);
> > +		ipmi_install_handler(ipmi_device);
> > +	}
> > +}
> > +
> > +static void acpi_remove_ipmi_handlers(void)
> > +{
> > +	struct acpi_ipmi_device *ipmi_device, *temp;
> > +
> > +	list_for_each_entry_safe(ipmi_device, temp, &driver_data.ipmi_devices,
> > +					head) {
> > +		if (ipmi_device->user_interface) {
> > +			/*
> > +			 * If the IPMI user interface is created, it
> > +			 * should be destroyed.
> > +			 */
> > +			ipmi_destroy_user(ipmi_device->user_interface);
> > +			ipmi_device->user_interface = NULL;
> > +		}
> > +		list_del(&ipmi_device->head);
> > +		if (!list_empty(&ipmi_device->tx_msg_list)) {
> > +			/* destroy the Tx_msg list */
> > +			ipmi_destroy_tx_msg(ipmi_device);
> > +		}
> > +		ipmi_remove_handler(ipmi_device);
> > +		kfree(ipmi_device);
> > +	}
> > +	return;
> 
> No "return" needed here.
> 
> > +}
> > +
> > +static int __init acpi_ipmi_init(void)
> > +{
> > +	int result = 0;
> > +
> > +	if (acpi_disabled)
> > +		return result;
> > +
> > +	acpi_add_ipmi_devices();
> > +
> > +	result = ipmi_smi_watcher_register(&driver_data.bmc_events);
> > +
> > +	if (result)
> > +		acpi_remove_ipmi_handlers();
> > +
> > +	return result;
> > +}
> > +
> > +static void __exit acpi_ipmi_exit(void)
> > +{
> > +	if (acpi_disabled)
> > +		return;
> > +
> > +	acpi_remove_ipmi_handlers();
> > +	ipmi_smi_watcher_unregister(&driver_data.bmc_events);
> > +
> > +	return;
> 
> No "return" needed here.
> 
> > +}
> > +
> > +module_init(acpi_ipmi_init);
> > +module_exit(acpi_ipmi_exit);
> > 

