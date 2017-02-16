From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/2] acpi: Fix the mapping handle in case of declaring
 processors using the Device operator
Date: Thu, 16 Feb 2017 21:06:21 +0800
Message-ID: <2ba0b2be-f858-18c5-1b12-105df4c2962a@linaro.org>
References: <1487241492-30005-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487241492-30005-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, rjw@rjwysocki.net, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2017/2/16 18:38, Dou Liyang wrote:
> In ACPI spec, we can declare processors using both Processor and
> Device operator. But now, we just handle the mapping of processors
> which are declared by Processor operator.
>
> It misses the processors declared by Device operator.
>
> The patch adds this case of the Device operator.
>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  drivers/acpi/processor_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 611a558..1aab5b0 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -344,8 +344,10 @@ void __init acpi_set_processor_mapping(void)
>  {
>  	/* Set persistent cpu <-> node mapping for all processors. */
>  	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
> -			    ACPI_UINT32_MAX, set_processor_node_mapping,
> -			    NULL, NULL, NULL);
> +				ACPI_UINT32_MAX, set_processor_node_mapping,
> +				NULL, NULL, NULL);

no need to update the code above.

> +	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, set_processor_node_mapping,
> +				NULL, NULL);

It makes sense to me to add support for Processor devices of setting
persistent cpu <-> node mapping, but I just wondering if there is no
Processor device or Processor Operator for a processor entry(such as
local apic, the spec didn't say it's a mandatory) in MADT, how do we
set the mappings?

BTW, multi places in the ACPI driver are using the same pattern here
to scan all the processors, maybe we can add a function then call it
to reduce some lines of code?

Thanks
Hanjun
