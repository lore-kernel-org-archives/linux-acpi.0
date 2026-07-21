Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF8374E41;
	Tue, 21 Jul 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641635; cv=none; b=g/k9gRKxrOW8aZ7qjOX3wYabdlC8LwrP06MLrKFofYitMF+v/UM0YVEOQsQck6+WyMlDFKdb7ONRdhV+mrV+LmCuUzTqPVmARmAd8KtsgyqxEDzA67LDjJTYmz5+3mQ/lA7jRJVbQsm4BWEVLKhqG4Ku/rb66030OzbBgC44VSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641635; c=relaxed/simple;
	bh=bbO97aXsSeqp6MAEcOPvX7CRCuYPXOKvn6rx6a9YU+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5ixnCrXdRcLWXtmkSZrMYuVqsRgcBSy1jhvO9G7REalqgEPmg353/jRf9oe5Cp8kpybTqsUVwSwCIkSk8j+KA+FoA1ctRulrlnkrOKDIJz+wDFUob7zg80y1U4a/yfkiODFAr4LU6wu5UGeejTaAIzKh4RAVo5QfRGQNC1Nj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wvxj7mXI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wvxj7mXI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DAC1152B;
	Tue, 21 Jul 2026 06:47:08 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D796D3F58B;
	Tue, 21 Jul 2026 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784641632; bh=bbO97aXsSeqp6MAEcOPvX7CRCuYPXOKvn6rx6a9YU+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wvxj7mXIWHIqo4DHVyoqzCKWs2lrb6c18b+YPgpG+sC4kUrBR6JZ2PVZGqDsnJnCd
	 7j2GBFpzB0IBPo0bdKIyiDaAy6wdmrOMpbmTGaL8GOn3aLTa3jDexdni6Bp4UIQavY
	 TuiQ91NvEoWfUbUiAi3MKKA/ZQjp1OggDD8hpFBM=
Message-ID: <466ebfb5-e29e-4b26-8f6c-5de8b26f4081@arm.com>
Date: Tue, 21 Jul 2026 15:47:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] arm_mpam: detect and enable MPAM-Fb PCC support
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-17-andre.przywara@arm.com>
 <20260710131021.0000361d@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260710131021.0000361d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/10/26 22:10, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 16:45:20 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
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
> Hi Andre,
> 
> A few things inline.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 220b4a06e739..7be98f13dd63 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/irqdesc.h>
>>   #include <linux/list.h>
>>   #include <linux/lockdep.h>
>> +#include <linux/mailbox_client.h>
>>   #include <linux/mutex.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/printk.h>
>> @@ -27,6 +28,9 @@
>>   #include <linux/types.h>
>>   #include <linux/workqueue.h>
>>   
>> +#include <acpi/pcc.h>
>> +#include <acpi/acpi_io.h>
>> +
>>   #include "mpam_internal.h"
>>   
>>   /* Values for the T241 errata workaround */
>> @@ -49,6 +53,88 @@ static LIST_HEAD(mpam_all_msc);
>>   
>>   struct srcu_struct mpam_srcu;
>>   
>> +/* PCC channels might be serving multiple MSCs, so keep a refcounted list. */
>> +static DEFINE_MUTEX(pcc_chan_list_lock);
>> +static LIST_HEAD(pcc_chan_list);
>> +
>> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg)
>> +{
>> +	/* TODO: wake up tasks blocked on this MSC's PCC channel */
> 
> That sounds like as significant todo. Does it matter for now?
> mpam_pcc_chan_get

Meh, looks like cargo-culted from a very early version of this patch 
set. Contrary to what I thought the rx_callback member is optional, and 
since we do synchronous sends only, and the agent never calls back on 
its own, we can just drop that.

>> +}
>> +
>> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
>> +					       int subspace_id)
>> +{
>> +	struct mpam_pcc_chan *cur;
>> +
>> +	mutex_lock(&pcc_chan_list_lock);
> 
> guard()
> 
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
> 
> guard()
> 
>> +
>> +	list_for_each_entry_safe(cur, tmp, &pcc_chan_list, pcc_chans) {
>> +		if (cur == pcc_chan) {
>> +			if (!--cur->refcount) {
> 
> Maybe embed a kref_t? Then release. As much as anything acts as documentation
> that this is reference counting.
> 
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
>>   /*
>>    * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
>>    * can be enabled.
>> @@ -2208,6 +2294,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>>   {
>>   	struct mpam_msc *msc = platform_get_drvdata(pdev);
>>   
>> +	mpam_pcc_chan_put(msc->pcc_chan);
>> +
>>   	mutex_lock(&mpam_list_lock);
>>   	mpam_msc_destroy(msc);
>>   	mutex_unlock(&mpam_list_lock);
>> @@ -2218,7 +2306,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>>   static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>   {
>>   	int err;
>> -	u32 tmp;
>> +	u32 pcc_subspace_id;
>>   	struct mpam_msc *msc;
>>   	struct resource *msc_res;
>>   	struct device *dev = &pdev->dev;
>> @@ -2263,7 +2351,8 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>   	if (err)
>>   		return ERR_PTR(err);
>>   
>> -	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
>> +	if (device_property_read_u32(&pdev->dev, "pcc-channel",
>> +				     &pcc_subspace_id))
>>   		msc->iface = MPAM_IFACE_MMIO;
>>   	else
>>   		msc->iface = MPAM_IFACE_PCC;
>> @@ -2279,6 +2368,39 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>   		}
>>   		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>>   		mcc->mapped_hwpage = io;
>> +	} else if (msc->iface == MPAM_IFACE_PCC) {
>> +		u32 msc_id;
>> +		int ret;
>> +
>> +		if (device_property_read_u32(&pdev->dev, "msc-id", &msc_id)) {
> 
> earlier patch included of.h, should have been property.h given quite correctly
> you are using the generic firmware accessors.
> 
>> +			pr_err("missing MPAM-Fb MSC identifier\n");
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +		msc->mpam_fb_msc_id = msc_id;
>> +
>> +		msc->pcc_chan = mpam_pcc_chan_get(&pdev->dev, pcc_subspace_id);
>> +		if (IS_ERR(msc->pcc_chan)) {
>> +			pr_err("Failed to request MSC PCC channel\n");
>> +			return (void *)msc->pcc_chan;
> 
> ERR_CAST()
> 
>> +		}
>> +
>> +		if (msc->pcc_chan->pcc_chan->shmem_size < MPAM_FB_MAX_MSG_SIZE) {
>> +			pr_err("MPAM-Fb PCC channel size too small.\n");
>> +			mpam_pcc_chan_put(msc->pcc_chan);
>> +			return ERR_PTR(-ENOMEM);
>> +		}
> 
> Blank line here as next bit is unrelated to the bit above.
> 
>> +		ret = mpam_fb_get_protocol_version(msc);
>> +		if (ret < 0) {
>> +			pr_err("Cannot query MPAM-Fb protocol version.\n");
>> +			mpam_pcc_chan_put(msc->pcc_chan);
>> +			return ERR_PTR(-EIO);
> If there is a good reason to eat the error code, then add a comment. If not.
> 			return ERR_PTR(ret);

The error code is from the MPAM-Fb spec, so this replaces it with a 
Linux error code. This is the first time we communicate with the agent, 
and if this call fails, we consider the whole thing broken.

ACK to the rest, have changed that.

Cheers,
Andre

> 
>> +		}
>> +		if ((ret >> 16) != 1) {
>> +			pr_err("Incompatible MPAM-Fb protocol version %d.%d\n",
>> +			       ret >> 16, ret & 0xffff);
>> +			mpam_pcc_chan_put(msc->pcc_chan);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>>   	} else {
>>   		return ERR_PTR(-EINVAL);
>>   	}
> 

