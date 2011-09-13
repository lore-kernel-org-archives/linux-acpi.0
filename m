From: "canquan.shen" <shencanquan@huawei.com>
Subject: Re: [PATCH v2] acpi: Fix CPU hot removal problem
Date: Tue, 13 Sep 2011 13:58:03 +0800
Message-ID: <4E6EF0EB.2040701@huawei.com>
References: <4E682AC8.7040302@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <4E682AC8.7040302@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: len.brown@intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2011/9/8 10:39, canquan.shen wrote:
> We run Linux as a guest in Xen environment. When used xen tools
> (xm vcpu-set <n>) to hot add and remove vcpu to and from the guest,
> we encountered the failure on vcpu removal. We found the reason is
> that it didn't go to really remove cpu in the cpu removal code path.
>
> This patch adds acpi_bus_trim in acpi_process_hotplug_notify to fix
> this issue. With this patch, it works fine for us.
>
> Signed-off-by: Canquan Shen <shencanquan@huawei.com>
> ---
> drivers/acpi/processor_driver.c | 5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c
> b/drivers/acpi/processor_driver.c
> index a1c564f..114592f 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -678,7 +678,11 @@ static void
> acpi_processor_hotplug_notify(acpi_handle handle,
> return;
> }
>
> + if (acpi_bus_trim(device, 1)) {
> + printk(KERN_ERR PREFIX
> + "Removing device failed\n");
> + return;
> + }
> break;
> default:
> ACPI_DEBUG_PRINT((ACPI_DB_INFO,

Hi Len,
     I just see your email in linux-kernel maillist and known that your 
kernel.org email is kaput, so I resend this email to your intel email 
address.

Thanks,
- Canquan Shen
