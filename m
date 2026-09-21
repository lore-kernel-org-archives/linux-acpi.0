Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0494BD34F;
	Mon, 21 Sep 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006973; cv=none; b=AJf5d2Y/taw+QO/8kO2anez9teTyoqsRZ3tXnJINemLXyeBHRSkDtdTWwEz1DvSyrzjPhL0/UVkNeC4+zw/7V1rBmJxkcpb4l/j1poCLWov24m/cU/Iv0BfISftXpy7KTrkrT4LEOutvkIuUf5vBW96wsXMxK4UPmSPXnBf0LV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006973; c=relaxed/simple;
	bh=bPWRp4q1aY5wrR5ZyhjF7sAuMRcvXD2G648sTqoPMWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arZbhnL8RMAySmciH7rcrNnT3uMhjnTTCI1r4xB6fZKcg8yHfFNxmYOPI0vmTa6HwodNa09tuhrARo9QR5EefenvOaxN7VOpDy/FcIWyyPUUCVevNjbspoSItTHF32X33fP6nIpUkT8/Fts/m7F50mB3R7tyo5SOqpOQxCoWiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZoyGwkvJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZoyGwkvJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C92176C;
	Mon, 21 Sep 2026 09:09:27 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03CA63F86C;
	Mon, 21 Sep 2026 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790006971; bh=bPWRp4q1aY5wrR5ZyhjF7sAuMRcvXD2G648sTqoPMWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZoyGwkvJv5whhIQOeavnPGAGbb+qcEEX1zSFB5h3B1SyUnjHF46vTeComXbqQPXQJ
	 eXFYoCoHSLDh0Ug7MbQJYeXZ66rKYDE9S3d8Lb0algdfC5xWxpygE6sf4mtFYq/J0w
	 22G+oSaM4ev6YyF54+T84HQTS3sGwmleRAcQv8ho=
Message-ID: <a314ee8f-4152-4b29-8348-6cd750eced40@arm.com>
Date: Mon, 21 Sep 2026 18:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/14] arm_mpam: detect and enable MPAM-Fb PCC support
To: Ben Horgan <ben.horgan@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260911112835.714162-1-andre.przywara@arm.com>
 <20260911112835.714162-13-andre.przywara@arm.com>
 <3e7bdafd-d6ea-422c-82ff-e278a17280ff@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <3e7bdafd-d6ea-422c-82ff-e278a17280ff@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 9/11/26 17:09, Ben Horgan wrote:
> Hi Andre,
> 
> On 11/09/2026 12:28, Andre Przywara wrote:
>> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
>> registers through a firmware interface. This requires a shared memory
>> region to hold the message, and a mailbox to trigger the access.
>> For ACPI this is wrapped as a PCC channel, described using existing
>> ACPI abstractions.
>>
>> Add code to parse those PCC table descriptions associated with an MSC,
>> and store the parsed information in the MSC struct.
>> There can be multiple PCC channels, and each channel can serve multiple
>> MSCs, so we need to keep track of the channel usage, using a list and
>> a refcount.
>>
>> This will be used by the MPAM-Fb access wrapper code.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com> # on Arm AGI CPU
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> Tested-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
>> Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/resctrl/Kconfig         |   1 +
>>   drivers/resctrl/mpam_devices.c  | 119 +++++++++++++++++++++++++++++++-
>>   drivers/resctrl/mpam_fb.c       |  41 +++++++++++
>>   drivers/resctrl/mpam_internal.h |   2 +
>>   4 files changed, 161 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
>> index 9591d792736e5..3f81638f57be3 100644
>> --- a/drivers/resctrl/Kconfig
>> +++ b/drivers/resctrl/Kconfig
>> @@ -2,6 +2,7 @@ menuconfig ARM64_MPAM_DRIVER
>>   	bool "MPAM driver"
>>   	depends on ARM64 && ARM64_MPAM
>>   	select ACPI_MPAM if ACPI
>> +	select PCC if ACPI
>>   	select MAILBOX
>>   	help
>>   	  Memory System Resource Partitioning and Monitoring (MPAM) driver for
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 14dc8461e4b8f..150a529458388 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -20,14 +20,19 @@
>>   #include <linux/irqdesc.h>
>>   #include <linux/list.h>
>>   #include <linux/lockdep.h>
>> +#include <linux/mailbox_client.h>
>>   #include <linux/mutex.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/printk.h>
>> +#include <linux/property.h>
>>   #include <linux/srcu.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/types.h>
>>   #include <linux/workqueue.h>
>>   
>> +#include <acpi/pcc.h>
>> +#include <acpi/acpi_io.h>
>> +
>>   #include "mpam_internal.h"
>>   
>>   /* Values for the T241 errata workaround */
>> @@ -50,6 +55,87 @@ static LIST_HEAD(mpam_all_msc);
>>   
>>   struct srcu_struct mpam_srcu;
>>   
>> +/* PCC channels might be serving multiple MSCs, so keep a refcounted list. */
>> +static DEFINE_MUTEX(pcc_chan_list_lock);
>> +static LIST_HEAD(pcc_chan_list);
>> +
>> +static void mpam_pcc_chan_release(struct kref *ref)
>> +{
>> +	struct mpam_pcc_chan *cur = container_of(ref, struct mpam_pcc_chan,
>> +						 refcount);
>> +
>> +	pcc_mbox_free_channel(cur->pcc_chan);
>> +	list_del(&cur->pcc_chans);
>> +	mutex_destroy(&cur->pcc_chan_lock);
>> +	kfree(cur);
>> +}
>> +
>> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
>> +					       int subspace_id)
>> +{
>> +	struct mpam_pcc_chan *cur;
>> +
>> +	guard(mutex)(&pcc_chan_list_lock);
>> +
>> +	list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
>> +		if (cur->subspace_id == subspace_id) {
>> +			kref_get(&cur->refcount);
>> +
>> +			return cur;
>> +		}
>> +	}
>> +
>> +	cur = kzalloc_obj(*cur);
>> +	if (!cur)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cur->pcc_cl.tx_block = true;
>> +
>> +	cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
>> +	if (IS_ERR(cur->pcc_chan)) {
>> +		long err = PTR_ERR(cur->pcc_chan);
>> +
>> +		kfree(cur);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	/*
>> +	 * Timeout based on the "nominal latency" in us, from the
>> +	 * PCC ACPI table. tx_tout is in ms.
>> +	 * Add some margin here to be on the safe side.
>> +	 */
>> +	cur->pcc_cl.tx_tout = DIV_ROUND_UP(cur->pcc_chan->latency * 5, 1000);
>> +
>> +	mutex_init(&cur->pcc_chan_lock);
>> +
>> +	cur->subspace_id = subspace_id;
>> +	kref_init(&cur->refcount);
>> +
>> +	list_add_tail(&cur->pcc_chans, &pcc_chan_list);
>> +
>> +	return cur;
>> +}
>> +
>> +static int mpam_pcc_chan_put(struct mpam_pcc_chan *pcc_chan)
>> +{
>> +	struct mpam_pcc_chan *cur, *tmp;
>> +
>> +	if (!pcc_chan)
>> +		return 0;
>> +
>> +	guard(mutex)(&pcc_chan_list_lock);
>> +
>> +	list_for_each_entry_safe(cur, tmp, &pcc_chan_list, pcc_chans) {
>> +		if (cur == pcc_chan) {
>> +			kref_put(&cur->refcount, mpam_pcc_chan_release);
>> +
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>>   /*
>>    * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
>>    * can be enabled.
>> @@ -2285,6 +2371,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>>   	if (!msc)
>>   		return;
>>   
>> +	mpam_pcc_chan_put(msc->pcc_chan);
>> +
>>   	mutex_lock(&mpam_list_lock);
>>   	mpam_msc_destroy(msc);
>>   	mutex_unlock(&mpam_list_lock);
>> @@ -2295,7 +2383,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>>   static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>   {
>>   	int err;
>> -	u32 tmp;
>> +	u32 pcc_subspace_id;
>>   	struct mpam_msc *msc;
>>   	struct resource *msc_res;
>>   	struct device *dev = &pdev->dev;
>> @@ -2339,7 +2427,7 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>   	if (err)
>>   		return ERR_PTR(err);
>>   
>> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
>> +	if (device_property_read_u32(dev, "pcc-channel", &pcc_subspace_id))
>>   		msc->iface = MPAM_IFACE_MMIO;
>>   	else
>>   		msc->iface = MPAM_IFACE_PCC;
>> @@ -2360,6 +2448,33 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>   		}
>>   		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>>   		msc->mapped_hwpage = io;
>> +	} else if (msc->iface == MPAM_IFACE_PCC) {
>> +		u32 mpam_fb_msc_id;
>> +
>> +		msc->pcc_chan = mpam_pcc_chan_get(dev, pcc_subspace_id);
>> +		if (IS_ERR(msc->pcc_chan)) {
>> +			pr_err("Failed to request MSC PCC channel\n");
>> +			return ERR_CAST(msc->pcc_chan);
>> +		}
>> +
>> +		err = mpam_fb_check_shared_buffer_size(msc);
>> +		if (err) {
>> +			mpam_pcc_chan_put(msc->pcc_chan);
>> +
>> +			return ERR_PTR(err);
>> +		}
>> +
>> +		err = mpam_fb_check_protocol_version(msc);
>> +		if (err) {
>> +			mpam_pcc_chan_put(msc->pcc_chan);
>> +
>> +			return ERR_PTR(err);
>> +		}
>> +
>> +		if (device_property_read_u32(&pdev->dev, "mpam-fb-msc-id",
>> +					     &mpam_fb_msc_id))
>> +			mpam_fb_msc_id = msc->id;
>> +		msc->mpam_fb_msc_id = mpam_fb_msc_id;
> 
> This looks like the change earlier in the series to drivers/acpi/arm64/mpam.c makes no functional
> effect unless the proposed spec changes are accepted; the default is msc->id. I'd just move the

Yes, but it reduces churn, and more importantly, is more true to the 
MPAM-Fb spec, which says:
"The MSC identifiers are sequential and start from 0 for each agent 
which uses this protocol."
So this requires that we have per-channel IDs for the MSCs, that's why I 
think it's justified to introduce this already now, even when it's 
somewhat redundant as the code stands now, as we always assign the 
system-wide ID to it.

I can of course move that out (and have that already on top of v9, 
internally), but wanted to check this with you.

> earlier drivers/acpi/arm64/mpam.c to your last patch and introduce this device_property_read_u32()
> their too (or a separate patch if it's easier for anyone). That way all but the last two patches can
> be considered for merging without knowing what's going to happen with the spec.

Well, sure, though I think a separation of MPAM-FB MSC IDs and 
system-wide MSC IDs is inevitable, regardless of which spec is changed 
and how the numbers are assigned, exactly.

> The struct msc property mpam_fb_msc_id is a bit long. Better as msc->fb_id?

Sure, can shorten that.

Cheers,
Andre.

>>   	} else {
>>   		return ERR_PTR(-EINVAL);
>>   	}
>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> index 98212f761de38..8fc1d78a7b5ab 100644
>> --- a/drivers/resctrl/mpam_fb.c
>> +++ b/drivers/resctrl/mpam_fb.c
>> @@ -20,10 +20,15 @@
>>   #define MPAM_FB_PROTOCOL_ID		0x1a
>>   
>>   #define MPAM_PROTOCOL_VERSION_CMD	0x0
>> +#define MPAM_FB_VERSION_MAJOR_MASK		GENMASK_U32(31, 16)
>> +#define MPAM_FB_VERSION_MINOR_MASK		GENMASK_U32(15, 0)
>> +
>>   #define MPAM_MSC_READ_CMD		0x4
>>   #define MPAM_MSC_WRITE_CMD		0x5
>>   
>>   #define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
>> +/* The longest message is MPAM_MSC_WRITE, with 4 parameters. */
>> +#define MPAM_FB_MAX_MSG_SIZE		(4 * sizeof(u32))
>>   
>>   #define MPAM_FB_SUCCESS		 0
>>   #define MPAM_FB_ERR_NOT_SUPPORTED	-1
>> @@ -209,3 +214,39 @@ int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
>>   	return mpam_fb_send_request(msc, msc->mpam_fb_msc_id, reg, &value,
>>   				    MPAM_MSC_WRITE_CMD);
>>   }
>> +
>> +/* We only support MPAM-Fb protocol version 1.x */
>> +int mpam_fb_check_protocol_version(struct mpam_msc *msc)
>> +{
>> +	u32 version;
>> +	int ret;
>> +
>> +	ret = mpam_fb_send_request(msc, 0, 0, &version,
>> +				   MPAM_PROTOCOL_VERSION_CMD);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version) != 1) {
>> +		pr_err("Incompatible MPAM-Fb protocol version %d.%d\n",
>> +		       FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version),
>> +		       FIELD_GET(MPAM_FB_VERSION_MINOR_MASK, version));
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc)
>> +{
>> +	int min_buffer_size = MPAM_FB_MAX_MSG_SIZE +
>> +			      sizeof(struct acpi_pcct_ext_pcc_shared_memory);
>> +
>> +	if (msc->pcc_chan->pcc_chan->shmem_size < min_buffer_size) {
>> +		pr_err("MPAM-Fb PCC channel size too small.\n");
>> +
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index e5a2804facd2d..314d3b48ca9fd 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -538,6 +538,8 @@ static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
>>   /* MPAM-Fb Firmware-backed protocol wrappers */
>>   int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
>>   int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
>> +int mpam_fb_check_protocol_version(struct mpam_msc *msc);
>> +int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc);
>>   
>>   /*
>>    * MPAM MSCs have the following register layout. See:
> 

