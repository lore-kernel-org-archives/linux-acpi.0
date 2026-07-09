Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2D21638D;
	Thu,  9 Jul 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590133; cv=none; b=R05LQp7ViIwmKY0omBMVOvzwfAAUzWvTyjwHY7RG1RInoH/HFqR9xUOl6ZGUihAaxi12wlxlYuX/snOba7IoGvNjmydkrdzcZd62jDRa1LnDr7c6CZ7nJ493ZiphBV+eP11MVqWa2X7zwgEpzx5PeTt6JcDJWGNLphD11HWSprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590133; c=relaxed/simple;
	bh=cBftvfYKfjyrhkBoYN/QBxyh1X9llmuITuh/+JJ4C4w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qXxfEEuqh1ubyhDGHXzmfz12cgkGghvnYw2tVfF3CoW+2d1GIzHfCmAumHkRavnYrk1BPQFFYjQfXGJVoTfwdSQ55bNVjJL7tNLzGMrqdGsZiQPwteb9EgClakidMlUgYhk/e03K61vZUbmjCZibQ8PSCZf4657mPjd9YMmUWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WiH6vkn6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WiH6vkn6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DF6C357B;
	Thu,  9 Jul 2026 02:42:06 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E6243FDE2;
	Thu,  9 Jul 2026 02:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783590130; bh=cBftvfYKfjyrhkBoYN/QBxyh1X9llmuITuh/+JJ4C4w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=WiH6vkn6b7SXPDUKa1/hnnKeDU9DHSXIplaQy9IF6i2hz3+c58RQvK4xJoM0DzH8V
	 q2E56Y8XKozu7W3HaDr4ra6yOBmnPjIzStuOEBte0ZGXgDX6zJLPmt5FbNtaXaPAMc
	 sAZRfMk0qTjRqvSLd/S8JSnOVk0R2VTm/vAAmhdw=
Message-ID: <299507de-b8f0-4d2f-8845-5266ce495eb1@arm.com>
Date: Thu, 9 Jul 2026 10:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 15/15] arm_mpam: detect and enable MPAM-Fb PCC support
From: Ben Horgan <ben.horgan@arm.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260702162229.4008659-1-andre.przywara@arm.com>
 <20260702162229.4008659-16-andre.przywara@arm.com>
 <df2e5828-5666-463e-84f9-ca1e69955690@arm.com>
Content-Language: en-US
In-Reply-To: <df2e5828-5666-463e-84f9-ca1e69955690@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/3/26 12:00, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/2/26 17:22, Andre Przywara wrote:
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
>> This will be used by the MPAM-Fb access wrapper code.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  drivers/acpi/arm64/mpam.c      |   2 +
>>  drivers/resctrl/mpam_devices.c | 113 ++++++++++++++++++++++++++++++++-
>>  2 files changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> index 84963a20c3e7..64bc84bb2029 100644
>> --- a/drivers/acpi/arm64/mpam.c
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>>  	} else if (iface == MPAM_IFACE_PCC) {
>>  		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>>  							tbl_msc->base_address);
>> +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
>> +							tbl_msc->identifier);

I expect it's easier if changes in this file are a separate patch Just
to help bring this to the attention of the ACPI/arm64 maintainers.

Thanks,

Ben

>>  	}
>>  
>>  	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 4a088e6cd235..35214520bfd4 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/irqdesc.h>
>>  #include <linux/list.h>
>>  #include <linux/lockdep.h>
>> +#include <linux/mailbox_client.h>
>>  #include <linux/mutex.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/printk.h>
>> @@ -27,6 +28,9 @@
>>  #include <linux/types.h>
>>  #include <linux/workqueue.h>
>>  
>> +#include <acpi/pcc.h>
>> +#include <acpi/acpi_io.h>
>> +
>>  #include "mpam_internal.h"
>>  #include "mpam_fb.h"
>>  
>> @@ -50,6 +54,88 @@ static LIST_HEAD(mpam_all_msc);
>>  
>>  struct srcu_struct mpam_srcu;
>>  
>> +/* PCC channels might be serving multiple MSCs, so keep a refcounted list. */
>> +static DEFINE_MUTEX(pcc_chan_list_lock);
>> +static LIST_HEAD(pcc_chan_list);
>> +
>> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg)
>> +{
>> +	/* TODO: wake up tasks blocked on this MSC's PCC channel */
>> +}
>> +
>> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
>> +					       int subspace_id)
>> +{
>> +	struct mpam_pcc_chan *cur;
>> +
>> +	mutex_lock(&pcc_chan_list_lock);
>> +
>> +	list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
>> +		if (cur->subspace_id == subspace_id) {
>> +			cur->refcount++;
>> +			mutex_unlock(&pcc_chan_list_lock);
>> +
>> +			return cur;
>> +		}
>> +	}
>> +
>> +	cur = kzalloc_obj(*cur);
>> +	if (!cur) {
>> +		mutex_unlock(&pcc_chan_list_lock);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	cur->pcc_cl.dev = dev;
>> +	cur->pcc_cl.rx_callback = mpam_pcc_rx_callback;
>> +	cur->pcc_cl.tx_block = true;
>> +	cur->pcc_cl.tx_tout = 1000; /* 1s */
>> +
>> +	cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
>> +	if (IS_ERR(cur->pcc_chan)) {
>> +		long err = PTR_ERR(cur->pcc_chan);
>> +
>> +		kfree(cur);
>> +		mutex_unlock(&pcc_chan_list_lock);
>> +		return ERR_PTR(err);
>> +	}
>> +
>> +	mutex_init(&cur->pcc_chan_lock);
>> +	cur->subspace_id = subspace_id;
>> +	cur->refcount = 1;
>> +
>> +	list_add_tail(&cur->pcc_chans, &pcc_chan_list);
>> +
>> +	mutex_unlock(&pcc_chan_list_lock);
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
>> +	mutex_lock(&pcc_chan_list_lock);
>> +
>> +	list_for_each_entry_safe(cur, tmp, &pcc_chan_list, pcc_chans) {
>> +		if (cur == pcc_chan) {
>> +			if (!--cur->refcount) {
>> +				pcc_mbox_free_channel(cur->pcc_chan);
>> +				list_del(&pcc_chan->pcc_chans);
>> +				kfree(cur);
>> +			}
>> +			mutex_unlock(&pcc_chan_list_lock);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&pcc_chan_list_lock);
>> +
>> +	return -ENOENT;
>> +}
>> +
>>  /*
>>   * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
>>   * can be enabled.
>> @@ -2202,6 +2288,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>>  {
>>  	struct mpam_msc *msc = platform_get_drvdata(pdev);
>>  
>> +	mpam_pcc_chan_put(msc->pcc_chan);
>> +
>>  	mutex_lock(&mpam_list_lock);
>>  	mpam_msc_destroy(msc);
>>  	mutex_unlock(&mpam_list_lock);
>> @@ -2212,7 +2300,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>>  static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>  {
>>  	int err;
>> -	u32 tmp;
>> +	u32 pcc_subspace_id;
>>  	struct mpam_msc *msc;
>>  	struct resource *msc_res;
>>  	struct device *dev = &pdev->dev;
>> @@ -2257,7 +2345,8 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>  	if (err)
>>  		return ERR_PTR(err);
>>  
>> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
>> +	if (device_property_read_u32(&pdev->dev, "pcc-channel",
>> +				     &pcc_subspace_id))
>>  		msc->iface = MPAM_IFACE_MMIO;
>>  	else
>>  		msc->iface = MPAM_IFACE_PCC;
>> @@ -2273,6 +2362,26 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>  		}
>>  		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>>  		msc->mapped_hwpage = io;
>> +	} else if (msc->iface == MPAM_IFACE_PCC) {
>> +		u32 msc_id;
>> +
>> +		if (device_property_read_u32(&pdev->dev, "msc-id", &msc_id)) {
>> +			pr_err("missing MPAM-Fb MSC identifier\n");
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +		msc->mpam_fb_msc_id = msc_id;
>> +
>> +		msc->pcc_chan = mpam_pcc_chan_get(&pdev->dev, pcc_subspace_id);
>> +		if (IS_ERR(msc->pcc_chan)) {
>> +			pr_err("Failed to request MSC PCC channel\n");
>> +			return (void *)msc->pcc_chan;
>> +		}
>> +
>> +		if (msc->pcc_chan->pcc_chan->shmem_size < MPAM_FB_MAX_MSG_SIZE) {
>> +			pr_err("MPAM-Fb PCC channel size too small.\n");
>> +			mpam_pcc_chan_put(msc->pcc_chan);
>> +			return ERR_PTR(-ENOMEM);
>> +		}
> 
> I think we need a version check here just in case a MPAM-Fb 2.x is released.
> 
> Thanks,
> 
> Ben
> 
>>  	} else {
>>  		return ERR_PTR(-EINVAL);
>>  	}
> 

