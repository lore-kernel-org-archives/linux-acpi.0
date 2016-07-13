From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7 6/9] vfio: platform: call _RST method when using ACPI
Date: Wed, 13 Jul 2016 15:39:25 -0400
Message-ID: <276ae4d2-66a2-f41a-3bb4-1d4b87a96e50@codeaurora.org>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
 <1465792001-27960-7-git-send-email-okaya@codeaurora.org>
 <20160623125948.59a8c656@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160623125948.59a8c656@t450s.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, kvm@vger.kernel.org, eric.auger@linaro.org, jcm@redhat.com, timur@codeaurora.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, cov@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 6/23/2016 2:59 PM, Alex Williamson wrote:
> On Mon, 13 Jun 2016 00:26:38 -0400
> Sinan Kaya <okaya@codeaurora.org> wrote:
> 
>> The device tree code checks for the presence of a reset driver and calls
>> the of_reset function pointer by looking up the reset driver as a module.
>>
>> ACPI defines _RST method to perform device level reset. After the _RST
>> method is executed, the OS can resume using the device. _RST method is
>> expected to stop DMA transfers and IRQs.
>>
>> This patch introduces two functions as vfio_platform_acpi_has_reset and
>> vfio_platform_acpi_call_reset. The has reset method is used to declare
>> reset capability via the ioctl flag VFIO_DEVICE_FLAGS_RESET. The call
>> reset function is used to execute the _RST ACPI method.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reviewed-by: Eric Auger <eric.auger@linaro.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c | 51 ++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index e7ce2c2..0ea8c26 100644
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -73,21 +73,66 @@ static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>>  	}
>>  	return 0;
>>  }
>> +
>> +static int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
>> +					 const char **extra_dbg)
>> +{
>> +	struct device *dev = vdev->device;
>> +	acpi_handle handle = ACPI_HANDLE(dev);
>> +	acpi_status acpi_ret;
>> +	unsigned long long val;
>> +
>> +	acpi_ret = acpi_evaluate_integer(handle, "_RST", NULL, &val);
>> +	if (ACPI_FAILURE(acpi_ret)) {
>> +		if (extra_dbg)
>> +			*extra_dbg = acpi_format_exception(acpi_ret);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
>> +{
>> +	struct device *dev = vdev->device;
>> +	acpi_handle handle = ACPI_HANDLE(dev);
>> +
>> +	return acpi_has_method(handle, "_RST");
>> +}
>>  #else
>>  static inline int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>>  					   struct device *dev)
>>  {
>>  	return -ENOENT;
>>  }
>> +
>> +static inline
>> +int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
>> +				  const char **extra_dbg)
>> +{
>> +	return -ENOENT;
>> +}
>> +
>> +static inline
>> +bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
>> +{
>> +	return false;
>> +}
>>  #endif
>>  
>>  static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>>  {
>> +	if (vdev->acpihid)
>> +		return vfio_platform_acpi_has_reset(vdev);
>> +
>>  	return vdev->of_reset ? true : false;
>>  }
>>  
>>  static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>  {
>> +	if (vdev->acpihid)
>> +		return;
>> +
>>  	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>  						    &vdev->reset_module);
>>  	if (!vdev->of_reset) {
>> @@ -99,6 +144,9 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>  
>>  static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>>  {
>> +	if (vdev->acpihid)
>> +		return;
>> +
>>  	if (vdev->of_reset)
>>  		module_put(vdev->reset_module);
>>  }
>> @@ -177,6 +225,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
>>  	if (vdev->of_reset) {
>>  		dev_info(vdev->device, "reset\n");
>>  		return vdev->of_reset(vdev);
>> +	} else if (vdev->acpihid) {
>> +		dev_info(vdev->device, "reset\n");
>> +		return vfio_platform_acpi_call_reset(vdev, extra_dbg);
> 
> 
> nit, all the cases until this one prioritize ACPI over DT, here we have
> the opposite. 

I'll reorder to be consistent.

> Granted we should never have of_reset set when acpihid
> is set.  A macro like
> 
> #define vfio_platform_is_acpi(vdev) (vdev->acpihid != NULL)
> 
> might be useful.

I like your idea. If you don't mind, I like capitals in macros. 

> 
> 
>>  	}
>>  
>>  	dev_warn(vdev->device, "no reset function found!\n");
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
