From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC Patch 2/2]IPMI/ACPI: Add the IPMI
	opregion driver to send	IPMI message in AML code
Date: Fri, 09 Oct 2009 09:59:42 +0800
Message-ID: <1255053582.3601.16.camel@localhost.localdomain>
References: <1254202194-7630-1-git-send-email-yakui.zhao@intel.com>
	<1254202194-7630-2-git-send-email-yakui.zhao@intel.com>
	<200909300937.44077.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <200909300937.44077.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2009-09-30 at 23:37 +0800, Bjorn Helgaas wrote:
> On Monday 28 September 2009 11:29:54 pm yakui.zhao@intel.com wrote:
> 
> These are a few coding style nits.  As I mentioned, I think there
> are much bigger issues to worry about first, so please don't just
> fix the coding style problems below and repost this.  Work on the
> bigger things like driver registration first.
Sorry for the late response.
Thanks for your comments.
And it seems that it is mainly about the coding style nits.

Although it is unnecessary to initialize some temporary variables, it is
harmless to initialize them.

Will you please point out the bigger issues you worried about?

Thanks.
> > Index: linux-2.6/drivers/acpi/ipmi.c
> > ===================================================================
> > --- /dev/null 1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6/drivers/acpi/ipmi.c     2009-09-28 15:53:24.000000000 +0800
> > @@ -0,0 +1,567 @@
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
> 
> I know this is common style, but I think it's stupid to add this
> #define since the value is only used once.
> 
> > +#define ACPI_IPMI_DEVICE_NAME                "IPMI_dev"
> 
> This one isn't used at all.
> 
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
> > +     /* General speaking the addr type should be SI_ADDR_TYPE. And
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
IMO it will be better to add some comments for the below definition.
It will be helpful to understand the meaning of acpi IPMI buffer.
for example: the status code. If we don't add the comment, maybe we will
be confusing. Is it the ACPI status code or IPMI status code?
> > +struct acpi_ipmi_buffer {
> > +     /* status code of a given IPMI command */
> 
> Comment is superfluous.
> 
> > +     u8 status_code;
> > +     /* the length of the payload */
> 
> Comment is superfluous.
> 
> > +     u8 length;
> > +     /* the payload. Before the operatin is carried out, it represents the
> > +      * request message payload. After the opration is carried out, it
> > +      * stores the response message returned by IPMI command.
> 
> "Operation" is spelled wrong twice.
> 
> > +      */
> > +     u8 data[64];
> > +};
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
> 
> We don't usually use tabs in local variable lists.
> 
> > +
> > +     msg = &tx_msg->tx_message;
> > +     /* get the netfn */
> > +     temp_value = (address >> 8) & 0xff;
> > +     msg->netfn = temp_value;
> > +     /* get the command */
> > +     temp_value = address & 0xff;
> > +     msg->cmd = temp_value;
> > +     msg->data = tx_msg->tx_data;
> > +     /* value is the parameter passed by the IPMI opregion space handler.
> > +      * It points to the IPMI request message buffer
> > +      */
> 
> Use a consistent comment style, e.g.,
> 
>         /*
>          * Value is ...
>          */
> 
> (Applies many places.)
> 
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
> > +     /* If the netfn is APP_REQUEST and the cmd is SEND_MESSAGE, we should
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
> > +     /* value is also used as output parameter. It represents the response
> > +      * IPMI message returned by IPMI command.
> > +      */
> > +     buffer = (struct acpi_ipmi_buffer *)value;
> > +     /* when timeout is zero, it means that the timeout happens */
> > +     if (!timeout) {
> > +             /* the status code is ACPI_IPMI_TIMEOUT */
> > +             buffer->status_code = ACPI_IPMI_TIMEOUT;
> > +             return;
> > +     }
> > +     /* If the flag of msg_done is not set, it means that the IPMI command
> > +      * is not executed correctly.
> > +      * The status code will be ACPI_IPMI_UNKNOWN.
> > +      */
> > +     if (!msg->msg_done) {
> > +             buffer->status_code = ACPI_IPMI_UNKNOWN;
> > +             return;
> > +     }
> > +     /* If the IPMI response message is obtained correctly, the status code
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
> > +     int count = 5;
> > +
> > +     list_for_each_entry(tx_msg, &ipmi->tx_msg_list, head) {
> > +             /* wake up the sleep thread on the Tx msg */
> > +             complete(&tx_msg->tx_complete);
> > +     }
> > +     while (count--) {
> > +             if (list_empty(&ipmi->tx_msg_list))
> > +                     break;
> > +             schedule_timeout(1);
> > +     }
> > +     if (!list_empty(&ipmi->tx_msg_list))
> > +             printk(KERN_DEBUG "tx msg list is not NULL\n");
> > +
> > +}
> > +static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
> > +{
> > +     struct acpi_ipmi_device *ipmi_device =
> > +                     (struct acpi_ipmi_device *)user_msg_data;
> 
> No cast needed here.
> 
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
> > +                     /* If the dev is identical to the ACPI device,
> > +                      * create the user interface.
> > +                      */
> > +                     err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
> > +                                             ipmi_device, &user);
> > +                     if (err == 0)
> > +                             ipmi_device->user_interface = user;
> > +
> > +                     continue;
> > +             }
> > +             /* In fact maybe the IPMI interface can be registered by
> > +              * other methods. For example: SPMI, DMI, PCI
> > +              * So we should also create the user interface.
> > +              */
> > +             err = ipmi_create_user(iface, &driver_data.ipmi_hndlrs,
> > +                                             ipmi_device, &user);
> > +             ipmi_device->user_interface = user;
> > +     }
> > +     return;
> 
> No "return" statement needed here.
> 
> > +}
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
> 
> No initialization needed.
> 
> > +     struct acpi_ipmi_device *ipmi_device =
> > +                     (struct acpi_ipmi_device *) handler_context;
> 
> No cast needed.
> 
> > +     int err;
> > +     acpi_status status;
> 
> Need a blank line here.
> 
> > +     /*
> > +      * IPMI opregion message.
> > +      * IPMI message is firstly written to the BMC and system software
> > +      * can get the respsonse. So it is unmeaningful for the IPMI read
> > +      * access.
> > +      */
> > +     if ((function & ACPI_IO_MASK) == ACPI_READ) {
> > +             /* AE_TYPE is returned. */
> 
> Superfluous comment.
> 
> > +             return AE_TYPE;
> > +     }
> > +     if (!ipmi_device->user_interface) {
> > +             /* not exist */
> 
> Superfluous comment.
> 
> > +             return AE_NOT_EXIST;
> > +     }
> > +     tx_msg = acpi_alloc_ipmi_msg(ipmi_device);
> > +     if (!tx_msg) {
> > +             /* no memory is allocated */
> 
> Superfluous comment.
> 
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
> 
> I don't think you need to use test_bit(), clear_bit(), and set_bit()
> for this flag.
> 
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
> > +static int acpi_ipmi_add(struct acpi_device *device)
> > +{
> > +     struct acpi_ipmi_device *ipmi_device;
> > +     acpi_handle handle;
> > +     unsigned long long temp;
> > +     acpi_status status;
> 
> Need a blank line here.
> 
> > +     if (!device)
> > +             return -EINVAL;
> 
> No need to test this.
> 
> > +
> > +     handle = device->handle;
> > +     temp = 0;
> 
> No need to initialize "temp".
> 
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
> 
> Superfluous comment.
> 
> > +             kfree(ipmi_device);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* add it to the IPMI device list */
> 
> Superfluous comment.
> 
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
> 
> Put this in the local variable list, e.g.,
> 
>         struct acpi_ipmi_device *ipmi_device = acpi_driver_data(device);
> 
> > +     if (!ipmi_device)
> > +             return 0;
> 
> No need to test this; if we got here, it means acpi_ipmi_add()
> succeeded, and it set the driver_data pointer.
> 
> > +
> > +     if (ipmi_device->user_interface) {
> > +             /*
> > +              * If the IPMI user interface is created, it should be
> > +              * destroyed.
> > +              */
> 
> Superfluous comment.
> 
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
> 
> No need to initialize "result".
> 
> > +
> > +     if (acpi_disabled)
> > +             return result;
> 
> No need to check this; acpi_bus_register_driver() does it already.
> 
> > +
> > +     result = acpi_bus_register_driver(&acpi_ipmi_driver);
> > +
> 
> Remove these blank lines.
> 
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
> 
> Remove this check, too.
> 
> > +
> > +     ipmi_smi_watcher_unregister(&driver_data.bmc_events);
> > +     acpi_bus_unregister_driver(&acpi_ipmi_driver);
> > +
> > +     return;
> 
> No "return" statement needed here.
> 
> > +}
> > +
> > +module_init(acpi_ipmi_init);
> > +module_exit(acpi_ipmi_exit);
> > Index: linux-2.6/drivers/acpi/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/Kconfig       2009-09-27 14:35:38.000000000 +0800
> > +++ linux-2.6/drivers/acpi/Kconfig    2009-09-28 13:10:46.000000000 +0800
> > @@ -204,6 +204,18 @@
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
> 
> "on on" is a typo.
> 
> > +
> > +       To compile this driver as a module, choose M here:
> 
> Looks like you're missing some "module will be called" text here.
Do you mean that the selected modules should also be listed?
> 
> >
> >  config ACPI_HOTPLUG_CPU
> >       bool
> > Index: linux-2.6/drivers/acpi/Makefile
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/Makefile      2009-09-27 14:35:38.000000000 +0800
> > +++ linux-2.6/drivers/acpi/Makefile   2009-09-28 13:09:09.000000000 +0800
> > @@ -57,6 +57,7 @@
> >  obj-$(CONFIG_ACPI_SBS)               += sbshc.o
> >  obj-$(CONFIG_ACPI_SBS)               += sbs.o
> >  obj-$(CONFIG_ACPI_POWER_METER)       += power_meter.o
> > +obj-$(CONFIG_ACPI_IPMI)              += ipmi.o
> >
> >  # processor has its own "processor." module_param namespace
> >  processor-y                  := processor_core.o processor_throttling.o
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
