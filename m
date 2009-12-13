From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Resend PATCH] ACPI: Add the IPMI opregion driver to enable
	ACPI to access BMC controller
Date: Sun, 13 Dec 2009 18:20:27 +0800
Message-ID: <1260699627.4162.21.camel@localhost.localdomain>
References: <1260323925-25701-1-git-send-email-yakui.zhao@intel.com>
	 <200912090757.41148.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28746 "HELO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751354AbZLMKV7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Dec 2009 05:21:59 -0500
In-Reply-To: <200912090757.41148.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-12-09 at 22:57 +0800, Bjorn Helgaas wrote:
> On Tuesday 08 December 2009 06:58:45 pm yakui.zhao@intel.com wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >
> > Add the IPMI opregion driver so that the AML code can communicate with BMC
> > throught IPMI message.
> >      It will create IPMI user interface for every IPMI device detected
> > in ACPI namespace and install the corresponding IPMI opregion space handler.
> >
> > The following describes how to process the IPMI request in IPMI space handler:
> >     1. format the IPMI message based on the request in AML code.
> >     IPMI system address. Now the address type is SYSTEM_INTERFACE_ADDR_TYPE
> >     IPMI net function & command
> >     IPMI message payload
> >     2. send the IPMI message by using the function of ipmi_request_settime
> >     3. wait for the completion of IPMI message. It can be done in different
> > routes: One is in handled in IPMI user recv callback function. Another is
> > handled in timeout function.
> >     4. format the IPMI response and return it to ACPI AML code.
> 
> I think this should be part of the ipmi_si_intf module, not a separate
> module.  This opregion code is of no use without ipmi_si_intf.  The
> opregion code can still be under its own config option, but I don't
> see the value in having it be a separate module.

This opregion code can't work if the IPMI subsystem is not loaded. this
is right. I also agree with this point.
But this doesn't mean that this must be put into the module of
ipmi_si_intf.
In fact this opregion code only uses the IPMI API function to
communicate with IPMI system interface. At the same time its main
purpose is to handle the request from ACPI AML code. It had better be
put into the ACPI subsystem. I think that it is unnecessary to put it
into the ipmi_si_intf module.


BTW: Several modules(for example: drivers/hwmon/ibmaem.c ,
drivers/hwmon/ibmpex.c) also use the IPMI system interface to
communicate with the IPMI subsystem. But they are the different part of
ipmi_si_intf module.

> The opregion code should definitely not use acpi_bus_register_driver()
> to claim IPI0001 devices.  The ipmi_si_intf driver already uses
> pnp_register_driver() to claim IPI0001 devices.  The fact that Linux
> allows two drivers to claim the same device (one via pnp_register_driver()
> and the other via acpi_bus_register_driver()) is a defect in Linux, and
> we shouldn't take advantage of that.

If you think that this code had better not use the
acpi_bus_register_driver, I will try to enumerate this device from ACPI
device tree directly and then install the IPMI opregion handler for it.

Is this ok to you?

thanks.

> 
> Bjorn
> 
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > ---
> >  drivers/acpi/Kconfig  |   12 +
> >  drivers/acpi/Makefile |    1 +
> >  drivers/acpi/ipmi.c   |  583 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 596 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/acpi/ipmi.c
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 93d2c79..23cd08a 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -204,6 +204,18 @@ config ACPI_PROCESSOR
> >
> >         To compile this driver as a module, choose M here:
> >         the module will be called processor.
> > +config ACPI_IPMI
> > +     tristate "IPMI"
> > +     depends on EXPERIMENTAL
> > +     default n
> > +     select IPMI_HANDLER
> > +     select IPMI_SI
> > +     help
> > +       This driver enables the ACPI to access the BMC controller. And it
> > +       uses the IPMI request/response message to communicate with BMC
> > +       controller, which can be found on on the server.
> > +
> > +       To compile this driver as a module, choose M here:
> >
> >  config ACPI_HOTPLUG_CPU
> >       bool
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index 7702118..61077b7 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -57,6 +57,7 @@ obj-$(CONFIG_ACPI_BATTERY)  += battery.o
> >  obj-$(CONFIG_ACPI_SBS)               += sbshc.o
> >  obj-$(CONFIG_ACPI_SBS)               += sbs.o
> >  obj-$(CONFIG_ACPI_POWER_METER)       += power_meter.o
> > +obj-$(CONFIG_ACPI_IPMI)              += ipmi.o
> >
> >  # processor has its own "processor." module_param namespace
> >  processor-y                  := processor_core.o processor_throttling.o
> > diff --git a/drivers/acpi/ipmi.c b/drivers/acpi/ipmi.c
> > new file mode 100644
> > index 0000000..5c74936
> > --- /dev/null
> > +++ b/drivers/acpi/ipmi.c
> > @@ -0,0 +1,583 @@
> > +/*
> > + *  ipmi.c - ACPI IPMI opregion
> > + *
> > + *  Copyright (C) 2009 Intel Corporation
> > + *  Copyright (C) 2009 Zhao Yakui <yakui.zhao@intel.com>
> > + *
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or (at
> > + *  your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful, but
> > + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License along
> > + *  with this program; if not, write to the Free Software Foundation, Inc.,
> > + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> > + *
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/types.h>
> > +#include <linux/delay.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/list.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/io.h>
> > +#include <acpi/acpi_bus.h>
> > +#include <acpi/acpi_drivers.h>
> > +#include <linux/ipmi.h>
> > +
> > +MODULE_AUTHOR("Zhao Yakui");
> > +MODULE_DESCRIPTION("ACPI IPMI Opregion driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +#define ACPI_IPMI_CLASS                      "IPMI"
> > +#define ACPI_IPMI_DEVICE_NAME                "IPMI_dev"
> > +#define IPMI_FLAGS_HANDLER_INSTALL   0
> > +
> > +#define ACPI_IPMI_OK                 0
> > +#define ACPI_IPMI_TIMEOUT            0x10
> > +#define ACPI_IPMI_UNKNOWN            0x07
> > +/* the IPMI timeout is 30s */
> > +#define IPMI_TIMEOUT                 (30 * HZ)
> > +
> > +
> > +struct acpi_ipmi_device {
> > +     acpi_handle handle;
> > +     struct acpi_device *device;
> > +     int if_type;
> > +     /* the device list attached to driver_data.ipmi_devices */
> > +     struct list_head head;
> > +     ipmi_user_t     user_interface;
> > +     struct mutex    mutex_lock;
> > +     /* the IPMI request message list */
> > +     struct list_head tx_msg_list;
> > +     long curr_msgid;
> > +     /* IPMI flags */
> > +     unsigned long flags;
> > +};
> > +
> > +struct ipmi_driver_data {
> > +     int device_count;
> > +     struct list_head        ipmi_devices;
> > +     struct ipmi_smi_watcher bmc_events;
> > +     struct ipmi_user_hndl   ipmi_hndlrs;
> > +};
> > +
> > +struct acpi_ipmi_msg {
> > +     /* message list */
> > +     struct list_head head;
> > +     /*
> > +      * General speaking the addr type should be SI_ADDR_TYPE. And
> > +      * the addr channel should be BMC.
> > +      * In fact it can also be IPMB type. But we will have to
> > +      * parse it from the Netfn command buffer. It is so complex
> > +      * that it is skipped.
> > +      */
> > +     struct ipmi_addr addr;
> > +     /* tx message id */
> > +     long tx_msgid;
> > +     /* it is used to track whether the IPMI message is finished */
> > +     struct completion tx_complete;
> > +     struct kernel_ipmi_msg tx_message;
> > +     int     msg_done;
> > +     /* tx data . And copy it from ACPI object buffer */
> > +     u8      tx_data[64];
> > +     int     tx_len;
> > +     /* get the response data */
> > +     u8      rx_data[64];
> > +     /* the response length. The netfn & cmd is excluded. */
> > +     int     rx_len;
> > +     struct acpi_ipmi_device *device;
> > +};
> > +
> > +/*
> > + * IPMI request/response buffer.
> > + * The length is 66 bytes.
> > + */
> > +struct acpi_ipmi_buffer {
> > +     /* status code of a given IPMI command */
> > +     u8 status_code;
> > +     /* the length of the payload */
> > +     u8 length;
> > +     /*
> > +      * the payload. Before the operation is carried out, it represents the
> > +      * request message payload. After the opration is carried out, it
> > +      * stores the response message returned by IPMI command.
> > +      */
> > +     u8 data[64];
> > +};
> > +
> > +static void ipmi_register_bmc(int iface, struct device *dev);
> > +static void ipmi_bmc_gone(int iface);
> > +static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data);
> > +
> > +static struct ipmi_driver_data driver_data = {
> > +     .ipmi_devices = LIST_HEAD_INIT(driver_data.ipmi_devices),
> > +     .bmc_events = {
> > +             .owner = THIS_MODULE,
> > +             .new_smi = ipmi_register_bmc,
> > +             .smi_gone = ipmi_bmc_gone,
> > +     },
> > +     .ipmi_hndlrs = {
> > +             .ipmi_recv_hndl = ipmi_msg_handler,
> > +     },
> > +};
> > +
> > +static
> > +struct acpi_ipmi_msg *acpi_alloc_ipmi_msg(struct acpi_ipmi_device *ipmi)
> > +{
> > +     struct acpi_ipmi_msg *ipmi_msg;
> > +
> > +     ipmi_msg = kzalloc(sizeof(struct acpi_ipmi_msg), GFP_KERNEL);
> > +     if (!ipmi_msg)  {
> > +             printk(KERN_DEBUG "Can't allocate memory for ipmi_msg\n");
> > +             return NULL;
> > +     }
> > +     init_completion(&ipmi_msg->tx_complete);
> > +     INIT_LIST_HEAD(&ipmi_msg->head);
> > +     ipmi_msg->device = ipmi;
> > +     return ipmi_msg;
> > +}
> > +
> > +static void acpi_format_ipmi_msg(struct acpi_ipmi_msg *tx_msg,
> > +             acpi_physical_address address,
> > +             acpi_integer *value)
> > +{
> > +     struct kernel_ipmi_msg *msg;
> > +     u8      temp_value;
> > +     struct acpi_ipmi_buffer *buffer;
> > +     struct acpi_ipmi_device *device;
> > +
> > +     msg = &tx_msg->tx_message;
> > +     /* get the netfn */
> > +     temp_value = (address >> 8) & 0xff;
> > +     msg->netfn = temp_value;
> > +     /* get the command */
> > +     temp_value = address & 0xff;
> > +     msg->cmd = temp_value;
> > +     msg->data = tx_msg->tx_data;
> > +     /*
> > +      * value is the parameter passed by the IPMI opregion space handler.
> > +      * It points to the IPMI request message buffer
> > +      */
> > +     buffer = (struct acpi_ipmi_buffer *)value;
> > +     /* copy the tx message data */
> > +     msg->data_len = buffer->length;
> > +     memcpy(tx_msg->tx_data, buffer->data, msg->data_len);
> > +     /*
> > +      * now the default type is SYSTEM_INTERFACE and channel type is BMC.
> > +      * If the netfn is APP_REQUEST and the cmd is SEND_MESSAGE,
> > +      * the addr type should be changed to IPMB.
> > +      */
> > +     tx_msg->addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
> > +     tx_msg->addr.channel = IPMI_BMC_CHANNEL;
> > +     tx_msg->addr.data[0] = 0;
> > +
> > +     /*
> > +      * If the netfn is APP_REQUEST and the cmd is SEND_MESSAGE, we should
> > +      * parse the IPMI request message buffer to get the IPMB address.
> > +      * If so, please fix me.
> > +      */
> > +
> > +     /* Get the msgid */
> > +     device = tx_msg->device;
> > +     mutex_lock(&device->mutex_lock);
> > +     device->curr_msgid++;
> > +     tx_msg->tx_msgid = device->curr_msgid;
> > +     mutex_unlock(&device->mutex_lock);
> > +}
> > +
> > +static void acpi_format_ipmi_response(struct acpi_ipmi_msg *msg,
> > +             acpi_integer *value, int timeout)
> > +{
> > +     struct acpi_ipmi_buffer *buffer;
> > +
> > +     /*
> > +      * value is also used as output parameter. It represents the response
> > +      * IPMI message returned by IPMI command.
> > +      */
> > +     buffer = (struct acpi_ipmi_buffer *)value;
> > +     /* when timeout is zero, it means that the timeout happens */
> > +     if (!timeout) {
> > +             /* the status code is ACPI_IPMI_TIMEOUT */
> > +             buffer->status_code = ACPI_IPMI_TIMEOUT;
> > +             return;
> > +     }
> > +     /*
> > +      * If the flag of msg_done is not set, it means that the IPMI command
> > +      * is not executed correctly.
> > +      * The status code will be ACPI_IPMI_UNKNOWN.
> > +      */
> > +     if (!msg->msg_done) {
> > +             buffer->status_code = ACPI_IPMI_UNKNOWN;
> > +             return;
> > +     }
> > +     /*
> > +      * If the IPMI response message is obtained correctly, the status code
> > +      * will be ACPI_IPMI_OK
> > +      */
> > +     buffer->status_code = ACPI_IPMI_OK;
> > +     buffer->length = msg->rx_len;
> > +     memcpy(buffer->data, msg->rx_data, msg->rx_len);
> > +     return;
> > +}
> > +static void ipmi_destroy_tx_msg(struct acpi_ipmi_device *ipmi)
> > +{
> > +     struct acpi_ipmi_msg *tx_msg = NULL;
> > +     int count = 20;
> > +
> > +     list_for_each_entry(tx_msg, &ipmi->tx_msg_list, head) {
> > +             /* wake up the sleep thread on the Tx msg */
> > +             complete(&tx_msg->tx_complete);
> > +     }
> > +     /* wait for about 20 ticks to flush the tx message list */
> > +     while (count--) {
> > +             if (list_empty(&ipmi->tx_msg_list))
> > +                     break;
> > +             schedule_timeout(1);
> > +     }
> > +     if (!list_empty(&ipmi->tx_msg_list))
> > +             printk(KERN_DEBUG "tx msg list is not NULL\n");
> > +
> > +}
> > +
> > +static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
> > +{
> > +     struct acpi_ipmi_device *ipmi_device =
> > +                     (struct acpi_ipmi_device *)user_msg_data;
> > +     int msg_found = 0;
> > +     struct acpi_ipmi_msg *tx_msg = NULL;
> > +
> > +     if (msg->user != ipmi_device->user_interface) {
> > +             printk(KERN_DEBUG "Incorrect IPMI user\n");
> > +             ipmi_free_recv_msg(msg);
> > +             return;
> > +     }
> > +     mutex_lock(&ipmi_device->mutex_lock);
> > +     list_for_each_entry(tx_msg, &ipmi_device->tx_msg_list, head) {
> > +             if (msg->msgid == tx_msg->tx_msgid) {
> > +                     /* find the message id */
> > +                     msg_found = 1;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     mutex_unlock(&ipmi_device->mutex_lock);
> > +     if (!msg_found) {
> > +             /* no matched msg is found . But we should free it */
> > +             ipmi_free_recv_msg(msg);
> > +             printk(KERN_DEBUG "Incorrect MSG is found \n");
> > +             return;
> > +     }
> > +
> > +     if (msg->msg.data_len > 1) {
> > +             /* copy the response data to Rx_data buffer */
> > +             memcpy(tx_msg->rx_data, msg->msg_data, msg->msg.data_len);
> > +             tx_msg->rx_len = msg->msg.data_len;
> > +             tx_msg->msg_done = 1;
> > +     }
> > +     complete(&tx_msg->tx_complete);
> > +     ipmi_free_recv_msg(msg);
> > +};
> > +
> > +static void ipmi_register_bmc(int iface, struct device *dev)
> > +{
> > +     struct acpi_ipmi_device *ipmi_device;
> > +     struct acpi_device *device;
> > +     ipmi_user_t             user;
> > +     int err;
> > +
> > +     if (list_empty(&driver_data.ipmi_devices))
> > +             return;
> > +
> > +     list_for_each_entry(ipmi_device, &driver_data.ipmi_devices, head) {
> > +             device = ipmi_device->device;
> > +             if (ipmi_device->user_interface) {
> > +                     /*
> > +                      * Only one user interface is allowed to be registered
> > +                      * for one IPMI device.
> > +                      * If we already create the user interface for
> > +                      * one IPMI device, skip it
> > +                      */
> > +                     continue;
> > +             }
> > +             if (dev == &device->dev) {
> > +                     /*
> > +                      * If the dev is identical to the ACPI device,
> > +                      * create the user interface.
> > +                      */
> > +                     err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
> > +                                             ipmi_device, &user);
> > +                     if (err == 0)
> > +                             ipmi_device->user_interface = user;
> > +
> > +                     continue;
> > +             }
> > +             /*
> > +              * In fact maybe the IPMI interface can be registered by
> > +              * other methods. For example: SPMI, DMI, PCI
> > +              * So we should also create the user interface.
> > +              */
> > +             err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
> > +                                             ipmi_device, &user);
> > +             if (err == 0)
> > +                     ipmi_device->user_interface = user;
> > +     }
> > +     return;
> > +}
> > +
> > +static void ipmi_bmc_gone(int iface)
> > +{
> > +     struct acpi_ipmi_device *ipmi_device;
> > +
> > +     if (list_empty(&driver_data.ipmi_devices))
> > +             return;
> > +
> > +     list_for_each_entry(ipmi_device, &driver_data.ipmi_devices, head) {
> > +             if (ipmi_device->user_interface) {
> > +                     ipmi_destroy_user(ipmi_device->user_interface);
> > +                     ipmi_device->user_interface = NULL;
> > +                     /* we should also destory tx msg list */
> > +                     ipmi_destroy_tx_msg(ipmi_device);
> > +             }
> > +     }
> > +}
> > +/* --------------------------------------------------------------------------
> > + *                   Address Space Management
> > +   -------------------------------------------------------------------------- */
> > +/*
> > + * This is the IPMI opregion space handler.
> > + * @function: indicates the read/write. In fact as the IPMI message is driven
> > + * by command, only write is meaningful.
> > + * @address: This contains the netfn/command of IPMI request message.
> > + * @bits   : not used.
> > + * @value  : it is an in/out parameter. It points to the IPMI message buffer.
> > + *        Before the IPMI message is sent, it represents the actual request
> > + *        IPMI message. After the IPMI message is finished, it represents
> > + *        the response IPMI message returned by IPMI command.
> > + * @handler_context: IPMI device context.
> > + */
> > +
> > +static acpi_status
> > +acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
> > +                   u32 bits, acpi_integer *value,
> > +                   void *handler_context, void *region_context)
> > +{
> > +     struct acpi_ipmi_msg *tx_msg = NULL;
> > +     struct acpi_ipmi_device *ipmi_device =
> > +                     (struct acpi_ipmi_device *) handler_context;
> > +     int err;
> > +     acpi_status status;
> > +     /*
> > +      * IPMI opregion message.
> > +      * IPMI message is firstly written to the BMC and system software
> > +      * can get the respsonse. So it is unmeaningful for the IPMI read
> > +      * access.
> > +      */
> > +     if ((function & ACPI_IO_MASK) == ACPI_READ) {
> > +             /* Read function is not supported. AE_TYPE is returned. */
> > +             return AE_TYPE;
> > +     }
> > +     if (!ipmi_device->user_interface) {
> > +             /* there doesn't exist user interface*/
> > +             return AE_NOT_EXIST;
> > +     }
> > +     tx_msg = acpi_alloc_ipmi_msg(ipmi_device);
> > +     if (!tx_msg) {
> > +             /* no memory is allocated */
> > +             return AE_NO_MEMORY;
> > +     }
> > +     acpi_format_ipmi_msg(tx_msg, address, value);
> > +     mutex_lock(&ipmi_device->mutex_lock);
> > +     list_add_tail(&tx_msg->head, &ipmi_device->tx_msg_list);
> > +     mutex_unlock(&ipmi_device->mutex_lock);
> > +     err = ipmi_request_settime(ipmi_device->user_interface,
> > +                                     &tx_msg->addr,
> > +                                     tx_msg->tx_msgid,
> > +                                     &tx_msg->tx_message,
> > +                                     NULL, 0, 0, 0);
> > +     if (err) {
> > +             status = AE_ERROR;
> > +             goto end_label;
> > +     }
> > +     err = wait_for_completion_timeout(&tx_msg->tx_complete, IPMI_TIMEOUT);
> > +
> > +end_label:
> > +     acpi_format_ipmi_response(tx_msg, value, err);
> > +     status = AE_OK;
> > +     mutex_lock(&ipmi_device->mutex_lock);
> > +     list_del(&tx_msg->head);
> > +     mutex_unlock(&ipmi_device->mutex_lock);
> > +     kfree(tx_msg);
> > +     return status;
> > +}
> > +
> > +static void ipmi_remove_handlers(struct acpi_ipmi_device *ipmi)
> > +{
> > +     if (!test_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags))
> > +             return;
> > +     acpi_remove_address_space_handler(ipmi->handle,
> > +                             ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler);
> > +
> > +     clear_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags);
> > +}
> > +
> > +static int ipmi_install_handlers(struct acpi_ipmi_device *ipmi)
> > +{
> > +     acpi_status status;
> > +
> > +     if (test_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags))
> > +             return 0;
> > +
> > +     status = acpi_install_address_space_handler(ipmi->handle,
> > +                                                 ACPI_ADR_SPACE_IPMI,
> > +                                                 &acpi_ipmi_space_handler,
> > +                                                 NULL, ipmi);
> > +     if (ACPI_FAILURE(status)) {
> > +             printk(KERN_DEBUG "Can't register IPMI opregion %s\n",
> > +                                     acpi_device_bid(ipmi->device));
> > +             return -EINVAL;
> > +     }
> > +     set_bit(IPMI_FLAGS_HANDLER_INSTALL, &ipmi->flags);
> > +     return 0;
> > +}
> > +
> > +static int acpi_ipmi_add(struct acpi_device *device)
> > +{
> > +     struct acpi_ipmi_device *ipmi_device;
> > +     acpi_handle handle;
> > +     unsigned long long temp;
> > +     acpi_status status;
> > +     if (!device)
> > +             return -EINVAL;
> > +
> > +     handle = device->handle;
> > +     temp = 0;
> > +     status = acpi_evaluate_integer(handle, "_IFT", NULL, &temp);
> > +     if (ACPI_FAILURE(status)) {
> > +             printk(KERN_DEBUG "Incorrect _IFT object for %s\n",
> > +                             acpi_device_bid(device));
> > +             return -ENODEV;
> > +     }
> > +     ipmi_device = kzalloc(sizeof(struct acpi_ipmi_device), GFP_KERNEL);
> > +     if (!ipmi_device) {
> > +             printk(KERN_DEBUG "Can't allocate memory space\n");
> > +             return -ENOMEM;
> > +     }
> > +     ipmi_device->if_type = temp;
> > +     switch (ipmi_device->if_type) {
> > +     case 1:
> > +     case 2:
> > +     case 3:
> > +             break;
> > +     default:
> > +             printk(KERN_DEBUG "Unknow IPMI:SI interface type %d\n",
> > +                             ipmi_device->if_type);
> > +             kfree(ipmi_device);
> > +             return -EINVAL;
> > +     }
> > +     ipmi_device->handle = device->handle;
> > +     ipmi_device->device = device;
> > +     mutex_init(&ipmi_device->mutex_lock);
> > +     INIT_LIST_HEAD(&ipmi_device->head);
> > +     INIT_LIST_HEAD(&ipmi_device->tx_msg_list);
> > +
> > +     if (ipmi_install_handlers(ipmi_device)) {
> > +             /* can't register the IPMI opregion */
> > +             kfree(ipmi_device);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* add it to the IPMI device list */
> > +     list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> > +     device->driver_data = ipmi_device;
> > +     return 0;
> > +}
> > +
> > +static int acpi_ipmi_remove(struct acpi_device *device, int type)
> > +{
> > +     struct acpi_ipmi_device *ipmi_device;
> > +
> > +     ipmi_device = acpi_driver_data(device);
> > +     if (!ipmi_device)
> > +             return 0;
> > +
> > +     if (ipmi_device->user_interface) {
> > +             /*
> > +              * If the IPMI user interface is created, it should be
> > +              * destroyed.
> > +              */
> > +             ipmi_destroy_user(ipmi_device->user_interface);
> > +             ipmi_device->user_interface = NULL;
> > +     }
> > +     list_del(&ipmi_device->head);
> > +     if (!list_empty(&ipmi_device->tx_msg_list)) {
> > +             /* destroy the Tx_msg list */
> > +             ipmi_destroy_tx_msg(ipmi_device);
> > +     }
> > +     ipmi_remove_handlers(ipmi_device);
> > +     kfree(ipmi_device);
> > +     device->driver_data = NULL;
> > +     return 0;
> > +}
> > +
> > +static const struct acpi_device_id ipmi_device_ids[] = {
> > +     {"IPI0001", 0},
> > +     {"", 0},
> > +};
> > +
> > +static struct acpi_driver acpi_ipmi_driver = {
> > +     .name = "ipmi",
> > +     .class = ACPI_IPMI_CLASS,
> > +     .ids = ipmi_device_ids,
> > +     .ops = {
> > +             .add = acpi_ipmi_add,
> > +             .remove = acpi_ipmi_remove,
> > +             },
> > +};
> > +
> > +static int __init acpi_ipmi_init(void)
> > +{
> > +     int result = 0;
> > +
> > +     if (acpi_disabled)
> > +             return result;
> > +
> > +     result = acpi_bus_register_driver(&acpi_ipmi_driver);
> > +
> > +     if (result)
> > +             return result;
> > +
> > +     result = ipmi_smi_watcher_register(&driver_data.bmc_events);
> > +
> > +     if (result)
> > +             acpi_bus_unregister_driver(&acpi_ipmi_driver);
> > +
> > +     return result;
> > +}
> > +
> > +static void __exit acpi_ipmi_exit(void)
> > +{
> > +     if (acpi_disabled)
> > +             return;
> > +
> > +     ipmi_smi_watcher_unregister(&driver_data.bmc_events);
> > +     acpi_bus_unregister_driver(&acpi_ipmi_driver);
> > +
> > +     return;
> > +}
> > +
> > +module_init(acpi_ipmi_init);
> > +module_exit(acpi_ipmi_exit);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

