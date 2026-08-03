Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03B378D74;
	Mon,  3 Aug 2026 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764233; cv=none; b=h9ub6GgpMx3NyJTM/EybS5yYjZjaI4mKEk1UhKXzrxdgkohRNYYi51HcftqKSMBDjQFD2TWb2cJJ27V0SPG38gYoR9D7piO61h131WauXNreboJ4pVII8GDpzDcylU+ThUalCqoxBz2cmEekrp4d+U7+hmHx0suDERMHmSOM1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764233; c=relaxed/simple;
	bh=InfRE0gi1+KHSKi+HCk1WCbf+V45IQbOr7iEhNMk5ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdRWjpTad2AabggCqTB7zyUPO+wypUx54DB3QVzI57YGrtbr19zb2Bah91nQVEW6k1Xx2o0eT0Q1lR82Jh7X21/l+A+myeroud2P6K5llEje9r6kD+k3i0sgvXm57Vnbi3BFi9nJIPB6hn61Ac5PFC6kIz0Av98SocRrr7E4wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ly0NzEmr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ly0NzEmr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5241476;
	Mon,  3 Aug 2026 06:37:06 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0A213F66F;
	Mon,  3 Aug 2026 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785764230; bh=InfRE0gi1+KHSKi+HCk1WCbf+V45IQbOr7iEhNMk5ZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ly0NzEmr73+ZaEiENORtOr/I/J37kYwQJE8u346zgjTYk8dW/JHdO5+ZjzJc7g7Ya
	 fy1v+jbLmvDjsGzIvdGHP/Ry9VbQihKMOADIypbz/E44HR1OPAWVx+5ADM2RXG5lzr
	 D/790lXtT6rg32nMsRKQDwpi6wbaobFBooHdIaNw=
Message-ID: <21d9c35b-58e8-4b99-a764-58fe45160cf6@arm.com>
Date: Mon, 3 Aug 2026 15:37:04 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] arm_mpam: detect and enable MPAM-Fb PCC support
To: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-12-andre.przywara@arm.com>
 <dd4d5ddc-e198-4747-85ce-aef4c569c593@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <dd4d5ddc-e198-4747-85ce-aef4c569c593@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Srivathsa,

On 8/3/26 12:49, Srivathsa L Rao wrote:
> Hi Andre,
> 
> On 7/31/2026 10:33 PM, Andre Przywara wrote:
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
>> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c  | 113 +++++++++++++++++++++++++++++++-
>>   drivers/resctrl/mpam_fb.c       |  41 ++++++++++++
>>   drivers/resctrl/mpam_internal.h |   2 +
>>   3 files changed, 154 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/ 
>> mpam_devices.c
>> index b238feb559d4..40b247a89f8e 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -19,14 +19,19 @@
>>   #include <linux/irqdesc.h>
>>   #include <linux/list.h>
>>   #include <linux/lockdep.h>
>> +#include <linux/mailbox_client.h>
>>   #include <linux/mutex.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/printk.h>
>> +#include <linux/property.h>
>>   #include <linux/srcu.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/types.h>
>>   #include <linux/workqueue.h>
>> +#include <acpi/pcc.h>
>> +#include <acpi/acpi_io.h>
>> +
>>   #include "mpam_internal.h"
>>   /* Values for the T241 errata workaround */
>> @@ -49,6 +54,88 @@ static LIST_HEAD(mpam_all_msc);
>>   struct srcu_struct mpam_srcu;
>> +/* PCC channels might be serving multiple MSCs, so keep a refcounted 
>> list. */
>> +static DEFINE_MUTEX(pcc_chan_list_lock);
>> +static LIST_HEAD(pcc_chan_list);
>> +
>> +static void mpam_pcc_chan_release(struct kref *ref)
>> +{
>> +    struct mpam_pcc_chan *cur = container_of(ref, struct mpam_pcc_chan,
>> +                         refcount);
>> +
>> +    pcc_mbox_free_channel(cur->pcc_chan);
>> +    list_del(&cur->pcc_chans);
>> +    mutex_destroy(&cur->pcc_chan_lock);
>> +    kfree(cur);
>> +}
>> +
>> +static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
>> +                           int subspace_id)
>> +{
>> +    struct mpam_pcc_chan *cur;
>> +
>> +    guard(mutex)(&pcc_chan_list_lock);
>> +
>> +    list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
>> +        if (cur->subspace_id == subspace_id) {
>> +            kref_get(&cur->refcount);
>> +
>> +            return cur;
>> +        }
>> +    }
>> +
>> +    cur = kzalloc_obj(*cur);
>> +    if (!cur)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    cur->pcc_cl.dev = dev;
> 
> While testing v7 with multiple PCC MSCs sharing a single PCC channel, I
> noticed that pcc_cl.dev is set once at channel creation time (from the
> first MSC's device) and never updated when subsequent MSCs reuse the
> channel.In mpam_pcc_chan_get(), the first call sets:
>   cur->pcc_cl.dev = dev;
> 
> Subsequent calls return the existing channel without updating 
> pcc_cl.dev. Here dev_err() calls through the channel report errors 
> against the first MSC's device, even when a different MSC triggered them.

Mmh, that's true, but I don't think there is much we can do about it? 
Ultimately it's a channel shared between multiple devices.
And I am less concerned about our own dev_err() (we can easily - and 
actually should - replace this with pr_err()), but more about the mbox 
uses of the dev pointer. Did you by any chance find more critical users 
of the dev pointer other than dev_err() prints, in the mailbox code?

I don't know if the correct MSC attribution really matters, or if we can 
live with just a valid reference to some "related" device, but ...

> I reproduced this with four PCC MSCs sharing subspace 0. After unbinding
> the first MSC (kref 4→3), triggering dev_err() via a test hook showed 
> the device prefix change from "mpam_msc mpam_msc.1:" to "platform 
> mpam_msc.1:"

Mmmh, interesting, where does the change come from? I would think that 
would result in a use after free?
Which means we should make sure that some other MSC donates their dev 
pointer if the first MSC goes away? I will have a look into that 
direction, though it still feels a bit odd.

> A simple fix maybe to use the MSC's own device for error messages in
> mpam_fb_send_request() instead of pcc_chan->pcc_cl.dev

But we don't have that pointer at this time, do we?  But as mentioned, 
we could just revert to a simple pr_err() instead.

Thanks for the heads up anyway!
Cheers,
Andre


> 
>> +    cur->pcc_cl.tx_block = true;
>> +
>> +    cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
>> +    if (IS_ERR(cur->pcc_chan)) {
>> +        long err = PTR_ERR(cur->pcc_chan);
>> +
>> +        kfree(cur);
>> +        return ERR_PTR(err);
>> +    }
>> +
>> +    /*
>> +     * Timeout based on the "nominal latency" in us, from the
>> +     * PCC ACPI table. tx_tout is in ms.
>> +     * Add some margin here to be on the safe side.
>> +     */
>> +    cur->pcc_cl.tx_tout = DIV_ROUND_UP(cur->pcc_chan->latency * 5, 
>> 1000);
>> +
>> +    mutex_init(&cur->pcc_chan_lock);
>> +
>> +    cur->subspace_id = subspace_id;
>> +    kref_init(&cur->refcount);
>> +
>> +    list_add_tail(&cur->pcc_chans, &pcc_chan_list);
>> +
>> +    return cur;
>> +}
>> +
>> +static int mpam_pcc_chan_put(struct mpam_pcc_chan *pcc_chan)
>> +{
>> +    struct mpam_pcc_chan *cur, *tmp;
>> +
>> +    if (!pcc_chan)
>> +        return 0;
>> +
>> +    guard(mutex)(&pcc_chan_list_lock);
>> +
>> +    list_for_each_entry_safe(cur, tmp, &pcc_chan_list, pcc_chans) {
>> +        if (cur == pcc_chan) {
>> +            kref_put(&cur->refcount, mpam_pcc_chan_release);
>> +
>> +            return 0;
>> +        }
>> +    }
>> +
>> +    return -ENOENT;
>> +}
>> +
>>   /*
>>    * Number of MSCs that have been probed. Once all MSCs have been 
>> probed MPAM
>>    * can be enabled.
>> @@ -2274,6 +2361,8 @@ static void mpam_msc_drv_remove(struct 
>> platform_device *pdev)
>>   {
>>       struct mpam_msc *msc = platform_get_drvdata(pdev);
>> +    mpam_pcc_chan_put(msc->pcc_chan);
>> +
>>       mutex_lock(&mpam_list_lock);
>>       mpam_msc_destroy(msc);
>>       mutex_unlock(&mpam_list_lock);
>> @@ -2284,7 +2373,7 @@ static void mpam_msc_drv_remove(struct 
>> platform_device *pdev)
>>   static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device 
>> *pdev)
>>   {
>>       int err;
>> -    u32 tmp;
>> +    u32 pcc_subspace_id;
>>       struct mpam_msc *msc;
>>       struct resource *msc_res;
>>       struct device *dev = &pdev->dev;
>> @@ -2328,7 +2417,7 @@ static struct mpam_msc 
>> *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>       if (err)
>>           return ERR_PTR(err);
>> -    if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
>> +    if (device_property_read_u32(dev, "pcc-channel", &pcc_subspace_id))
>>           msc->iface = MPAM_IFACE_MMIO;
>>       else
>>           msc->iface = MPAM_IFACE_PCC;
>> @@ -2349,6 +2438,26 @@ static struct mpam_msc 
>> *do_mpam_msc_drv_probe(struct platform_device *pdev)
>>           }
>>           msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
>>           msc->mapped_hwpage = io;
>> +    } else if (msc->iface == MPAM_IFACE_PCC) {
>> +        msc->pcc_chan = mpam_pcc_chan_get(dev, pcc_subspace_id);
>> +        if (IS_ERR(msc->pcc_chan)) {
>> +            pr_err("Failed to request MSC PCC channel\n");
>> +            return ERR_CAST(msc->pcc_chan);
>> +        }
>> +
>> +        err = mpam_fb_check_shared_buffer_size(msc);
>> +        if (err) {
>> +            mpam_pcc_chan_put(msc->pcc_chan);
>> +
>> +            return ERR_PTR(err);
>> +        }
>> +
>> +        err = mpam_fb_check_protocol_version(msc);
>> +        if (err) {
>> +            mpam_pcc_chan_put(msc->pcc_chan);
>> +
>> +            return ERR_PTR(err);
>> +        }
>>       } else {
>>           return ERR_PTR(-EINVAL);
>>       }
>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> index 61a91c6cec0a..7a7fb6d067ba 100644
>> --- a/drivers/resctrl/mpam_fb.c
>> +++ b/drivers/resctrl/mpam_fb.c
>> @@ -37,6 +37,11 @@
>>   #define MPAM_MSC_TOKEN_MASK        GENMASK(27, 18)
>>   #define MPAM_FB_PROT_HEADER_LEN        sizeof(u32)
>> +/* The longest message is MPAM_MSC_WRITE, with 4 parameters. */
>> +#define MPAM_FB_MAX_MSG_SIZE        (4 * sizeof(u32))
>> +
>> +#define MPAM_FB_VERSION_MAJOR_MASK    GENMASK(31, 16)
>> +#define MPAM_FB_VERSION_MINOR_MASK    GENMASK(15, 0)
>>   static atomic_t mpam_fb_token = ATOMIC_INIT(0);
>> @@ -207,3 +212,39 @@ int mpam_fb_send_write_request(struct mpam_msc 
>> *msc, u16 reg, u32 value)
>>       return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, &value,
>>                       MPAM_MSC_WRITE_CMD);
>>   }
>> +
>> +/* We only support MPAM-Fb protocol version 1.x */
>> +int mpam_fb_check_protocol_version(struct mpam_msc *msc)
>> +{
>> +    u32 version;
>> +    int ret;
>> +
>> +    ret = mpam_fb_send_request(msc->pcc_chan, 0,
>> +                   0, &version, MPAM_PROTOCOL_VERSION_CMD);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version) != 1) {
>> +        pr_err("Incompatible MPAM-Fb protocol version %ld.%ld\n",
>> +               FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version),
>> +               FIELD_GET(MPAM_FB_VERSION_MINOR_MASK, version));
>> +
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc)
>> +{
>> +    int min_buffer_size = MPAM_FB_MAX_MSG_SIZE +
>> +                  sizeof(struct acpi_pcct_ext_pcc_shared_memory);
>> +
>> +    if (msc->pcc_chan->pcc_chan->shmem_size < min_buffer_size) {
>> +        pr_err("MPAM-Fb PCC channel size too small.\n");
>> +
>> +        return -ENOMEM;
>> +    }
>> +
>> +    return 0;
>> +}
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/ 
>> mpam_internal.h
>> index f13a79a84c58..8859189088f3 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -528,6 +528,8 @@ static inline void 
>> mpam_resctrl_teardown_class(struct mpam_class *class) { }
>>   /* MPAM-Fb Firmware-backed protocol wrappers */
>>   int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 
>> *result);
>>   int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 
>> value);
>> +int mpam_fb_check_protocol_version(struct mpam_msc *msc);
>> +int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc);
>>   /*
>>    * MPAM MSCs have the following register layout. See:
> 
> -- 
> Best Regards,
> Srivathsa
> 

