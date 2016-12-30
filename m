From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v5 09/14] ACPI: platform: setup MSI domain for ACPI based
 platform device
Date: Fri, 30 Dec 2016 18:50:44 +0800
Message-ID: <58663C04.9000603@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-10-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0g4AoU-g4UWZFxLgQ_yfTC7KSBnZ_Ve945d+i58e=GuDQ@mail.gmail.com>
 <585E24FB.9050805@huawei.com>
 <CAJZ5v0itKF-uo7vGxK3+-X4OwBVYPdBw-b8v-8-CTBygpKMGoQ@mail.gmail.com>
 <586072E9.3060609@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <586072E9.3060609@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, yimin@huawei.com, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ma Jun <majun258@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 2016/12/26 9:31, Hanjun Guo wrote:
[cut]
>
> +       if (pdevinfo->pre_add_cb)
> +               pdevinfo->pre_add_cb(&pdev->dev);
> +
>>>> -> because it looks like this might be done in acpi_platform_notify()
>>>> for platform devices.
>>> It works and I just simply add the code below:
>>>
>>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>>> index f8d6564..e0cd649 100644
>>> --- a/drivers/acpi/glue.c
>>> +++ b/drivers/acpi/glue.c
>>> @@ -13,6 +13,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/rwsem.h>
>>>  #include <linux/acpi.h>
>>> +#include <linux/acpi_iort.h>
>>>  #include <linux/dma-mapping.h>
>>>
>>>  #include "internal.h"
>>> @@ -315,6 +316,8 @@ static int acpi_platform_notify(struct device *dev)
>>>         if (!adev)
>>>                 goto out;
>>>
>>> + acpi_configure_pmsi_domain(dev);
>>> +
>> But that should apply to platform devices only I suppose?
> Yes, it's only for the platform device.
>
>>>         if (type && type->setup)
>>>                 type->setup(dev);
>>>         else if (adev->handler && adev->handler->bind)
>>>
>>> Do you suggesting to configure the msi domain in this way?
>>> or add the function in the type->setup() callback (which needs
>>> to introduce a new acpi bus type)?
>> A type->setup() would be somewhat cleaner I think, but then it's more
>> code.  Whichever works better I guess. :-)
> Agree, I will demo the type->setup() way and send out the patch for review,
> also I find one minor issue for the IORT code, will update that also for next
> version.

Just demo the code and find out it's seems to cut the feet to the type->setup() code,
because we need a match function (it's ok) and a find_companion() (we don't need that
and make the code worse because we will call the find_companion callback which it not needed
for platform devices:

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 96983c9..654021d9b 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -138,3 +138,31 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
        return pdev;
 }
 EXPORT_SYMBOL_GPL(acpi_create_platform_device);
+
+static bool platform_acpi_bus_match(struct device *dev)
+{
+ return dev->bus == &platform_bus_type;
+}
+
+static struct acpi_device *platform_acpi_bus_find_companion(struct device *dev)
+{
+ /* demo code, do nothing here */
+ return NULL;
+}
+
+static void platform_acpi_setup(struct device *dev)
+{
+ acpi_configure_pmsi_domain(dev);
+}
+
+static struct acpi_bus_type acpi_platform_bus = {
+ .name = "Platform",
+ .match = platform_acpi_bus_match,
+ .find_companion = platform_acpi_bus_find_companion,
+ .setup = platform_acpi_setup,
+};
+
+int acpi_platform_bus_register(void)
+{
+ return register_acpi_bus_type(&acpi_platform_bus);
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 95855cb..0a0a639 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1199,6 +1199,7 @@ static int __init acpi_init(void)
        }
 
        pci_mmcfg_late_init();
+ acpi_platform_bus_register();
        acpi_iort_init();
        acpi_scan_init();
        acpi_ec_init();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 809b536..1d05f92 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -597,6 +597,8 @@ extern bool acpi_driver_match_device(struct device *dev,
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *,
                                                    struct property_entry *);
+int acpi_platform_bus_register(void);
+
 #define ACPI_PTR(_ptr) (_ptr)
 
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)


So how about just add the code as below?

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 11e63dd..37a8dfe 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -316,7 +316,8 @@ static int acpi_platform_notify(struct device *dev)
        if (!adev)
                goto out;
 
+ if (dev->bus == &platform_bus_type)
+         acpi_configure_pmsi_domain(dev);
 
        if (type && type->setup)
                type->setup(dev);

Thanks
Hanjun
