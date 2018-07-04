From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date: Wed, 4 Jul 2018 09:07:25 +0530
Message-ID: <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com> <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>, Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Sudeep, Andy,

Yes, This patch is to get of_device_id and then fetch data pointer.

To add ACPI support in multiple drivers which are device-tree based
and has list of of_device_ids, by using this function
very minimal changes and can avoid acpi_device_id list in the driver.
I will send driver changes where this function used to add ACPI
support in following patches.

Below are the changes added to add ACPI support in sdhci iproc driver
using this function.

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index db40218..f1ecac97 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -15,6 +15,7 @@
  * iProc SDHCI platform driver
  */

+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
@@ -267,8 +268,13 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
        int ret;

        match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
-       if (!match)
-               return -EINVAL;
+       if (!match) {
+               match = acpi_match_of_device_id(sdhci_iproc_of_match,
+                                               &pdev->dev);
+               if (!match)
+                       return -EINVAL;
+       }
+
        iproc_data = match->data;

        host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));

Regards,
Srinath.



On Tue, Jul 3, 2018 at 11:11 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 12:22 PM, Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>> This patch provides a function, to get of_device_id after
>> matching with ACPI device _DSD object compatible property
>> in the case driver does not contain acpi_device_id list
>> and driver probe called for ACPI device ID PRP0001 with
>> compatible property match with of_device_id compatible.
>
> I don't see any usefulness of this function. Care to provide a real use case?
>
> --
> With Best Regards,
> Andy Shevchenko
