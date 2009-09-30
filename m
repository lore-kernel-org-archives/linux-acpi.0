From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPI: Add EC event managerment functions into header
 file
Date: Wed, 30 Sep 2009 22:12:55 +0400
Message-ID: <4AC39FA7.8000204@gmail.com>
References: <1254173448-18362-1-git-send-email-ike.pan@canonical.com> <4AC135AC.2010407@gmail.com> <4AC170DA.3000907@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:48961 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbZI3SMy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Sep 2009 14:12:54 -0400
In-Reply-To: <4AC170DA.3000907@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Ike Panhc =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> I had sent a new driver for Lenovo SL series laptops [1], and it uses=
 those
> functions to detect hotkeys. Since it has been exported for other mod=
ules,
> I think it is reasonable to write in header file to make sure everyon=
e has
> the same definition.
>
> [1] http://patchwork.kernel.org/patch/49912/
>  =20
If you need these functions to be visible, you should mention that in=20
patch description.
You should also add a comment that if someone adds notification handler=
,=20
the original one
is not going to be executed until handler is un-registered. This was no=
t=20
needed while it was internal interface,
but with it becoming public, it needs some warnings/descriptions.

Regards,
Alex.

BTW, what is wrong with default hotkey handlers?
> Alexey Starikovskiy wrote:
>  =20
>> These functions are never used anywhere, but sbshc.c.
>> What is the reason to make them known to the whole kernel?
>>
>> Ike Panhc =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>    =20
>>> There are two functions for add/remove EC query handler functions, =
which
>>> exported without any definition in header files
>>>
>>> Patch against current checkout of linux-acpi 2.6.31 is below.
>>>
>>> In this patch, the following definitions has been added into
>>> include/linux/acpi.h
>>>  - typedef: acpi_ec_query_func
>>>  - struct: acpi_ec
>>>  - fucntions: acpi_ec_add_query_handler, acpi_ec_remove_query_handl=
er
>>>
>>> And the following definitions has been removed from driver/acpi/ec.=
c
>>>  - typedef: acpi_ec_query_func
>>>  - struct: acpi_ec
>>>
>>> So that, the following externs and typedef could be remove from
>>> drivers/acpi/sbshc.c
>>>  - typedef: acpi_ec_query_func
>>>  - externs: acpi_ec_add_query_handler, acpi_ec_remove_query_handler
>>>
>>> Signed-off-by: Ike Panhc <ike.pan@canonical.com>
>>> ---
>>>  drivers/acpi/ec.c    |   22 +++++-----------------
>>>  drivers/acpi/sbshc.c |    8 --------
>>>  include/linux/acpi.h |   21 +++++++++++++++++++++
>>>  3 files changed, 26 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>> index f707960..8950c4f 100644
>>> --- a/drivers/acpi/ec.c
>>> +++ b/drivers/acpi/ec.c
>>> @@ -43,6 +43,7 @@
>>>  #include <acpi/acpi_bus.h>
>>>  #include <acpi/acpi_drivers.h>
>>>  #include <linux/dmi.h>
>>> +#include <linux/acpi.h>
>>> =20
>>>  #define ACPI_EC_CLASS            "embedded_controller"
>>>  #define ACPI_EC_DEVICE_NAME        "Embedded Controller"
>>> @@ -80,10 +81,6 @@ enum {
>>>                       * OpReg are installed */
>>>  };
>>> =20
>>> -/* If we find an EC via the ECDT, we need to keep a ptr to its
>>> context */
>>> -/* External interfaces use first EC only, so remember */
>>> -typedef int (*acpi_ec_query_func) (void *data);
>>> -
>>>  struct acpi_ec_query_handler {
>>>      struct list_head node;
>>>      acpi_ec_query_func func;
>>> @@ -104,19 +101,10 @@ struct transaction {
>>>      bool done;
>>>  };
>>> =20
>>> -static struct acpi_ec {
>>> -    acpi_handle handle;
>>> -    unsigned long gpe;
>>> -    unsigned long command_addr;
>>> -    unsigned long data_addr;
>>> -    unsigned long global_lock;
>>> -    unsigned long flags;
>>> -    struct mutex lock;
>>> -    wait_queue_head_t wait;
>>> -    struct list_head list;
>>> -    struct transaction *curr;
>>> -    spinlock_t curr_lock;
>>> -} *boot_ec, *first_ec;
>>> +/* If we find an EC via the ECDT, we need to keep a ptr to its
>>> context */
>>> +/* External interfaces use first EC only, so remember */
>>> +static struct acpi_ec *boot_ec;
>>> +static struct acpi_ec *first_ec;
>>> =20
>>>  static int EC_FLAGS_MSI; /* Out-of-spec MSI controller */
>>> =20
>>> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
>>> index d933980..d5550a5 100644
>>> --- a/drivers/acpi/sbshc.c
>>> +++ b/drivers/acpi/sbshc.c
>>> @@ -250,12 +250,6 @@ static int smbus_alarm(void *context)
>>>      return 0;
>>>  }
>>> =20
>>> -typedef int (*acpi_ec_query_func) (void *data);
>>> -
>>> -extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_=
bit,
>>> -                  acpi_handle handle, acpi_ec_query_func func,
>>> -                  void *data);
>>> -
>>>  static int acpi_smbus_hc_add(struct acpi_device *device)
>>>  {
>>>      int status;
>>> @@ -292,8 +286,6 @@ static int acpi_smbus_hc_add(struct acpi_device
>>> *device)
>>>      return 0;
>>>  }
>>> =20
>>> -extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8
>>> query_bit);
>>> -
>>>  static int acpi_smbus_hc_remove(struct acpi_device *device, int ty=
pe)
>>>  {
>>>      struct acpi_smb_hc *hc;
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index dfcd920..259eacb 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -145,12 +145,33 @@ struct acpi_pci_driver {
>>>  int acpi_pci_register_driver(struct acpi_pci_driver *driver);
>>>  void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
>>> =20
>>> +typedef int (*acpi_ec_query_func) (void *data);
>>> +
>>> +struct acpi_ec {
>>> +    acpi_handle handle;
>>> +    unsigned long gpe;
>>> +    unsigned long command_addr;
>>> +    unsigned long data_addr;
>>> +    unsigned long global_lock;
>>> +    unsigned long flags;
>>> +    struct mutex lock;
>>> +    wait_queue_head_t wait;
>>> +    struct list_head list;
>>> +    struct transaction *curr;
>>> +    spinlock_t curr_lock;
>>> +};
>>> +
>>>  extern int ec_read(u8 addr, u8 *val);
>>>  extern int ec_write(u8 addr, u8 val);
>>>  extern int ec_transaction(u8 command,
>>>                            const u8 *wdata, unsigned wdata_len,
>>>                            u8 *rdata, unsigned rdata_len,
>>>                int force_poll);
>>> +extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_=
bit,
>>> +                      acpi_handle handle,
>>> +                      acpi_ec_query_func func, void *data);
>>> +extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8
>>> query_bit);
>>> +
>>> =20
>>>  #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
>>> =20
>>>  =20
>>>      =20
>>    =20
>
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
