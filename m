Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67236F906;
	Tue, 28 Jul 2026 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255573; cv=none; b=lQDSUINWe6K9jRlybmRsiq86c/TymkP5yJjaEmtxFExf09E+EzGSNkZV1jC1I4bc+vUYoHkt4fmrXI1dR4mN+OQ/2KOzUBB0TP2xW9/FrPMDORwg1PNuLmj8vMeJGTM8Z2P+y+K2odYXmlc+AhUyesls9FN2tigsQlJcwFrqIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255573; c=relaxed/simple;
	bh=sfp06OhXOiL+rR5JnyS0hVX5IlvUH8emx0S5amMJwYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY30DzShUttqs0fbKMzLheiML23nEecLpxhVYttNoE0qKZm+UFRSETsBHpD+dd4MWT2b5yZ2zRrrNIU2tCnTUtffDIiWzzPBb8J7zkftvRhZnfdb3q7vdsHmkSHhIY2ZlWm5FyDt6xFmH34nczPlplRBBQ9594syMsYLQLycZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wp3NWVcD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wp3NWVcD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C36169E;
	Tue, 28 Jul 2026 09:19:26 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10BF13F763;
	Tue, 28 Jul 2026 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785255570; bh=sfp06OhXOiL+rR5JnyS0hVX5IlvUH8emx0S5amMJwYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wp3NWVcD8Bi/ubJgeZHqLWy+1hmR63cN19Au4oyFOdWMZ90weC8U2YzK51AHtno+v
	 8GCRMPgp992WV+6sw0GIMVg8T9DB8Ztn9olU5U5jdy405UqqvinPR3jAKmeaLi0saJ
	 Id2wh2+AF/SZ230JQQ0npEiIkDGF2jqvS2G+hktU=
Message-ID: <80ec14a4-1991-4586-a292-7029706890bf@arm.com>
Date: Tue, 28 Jul 2026 18:19:25 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
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
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-9-andre.przywara@arm.com>
 <8daee801-ec05-4206-8816-ef7a5d527f98@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <8daee801-ec05-4206-8816-ef7a5d527f98@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Srivathsa,

thanks for having a look!

On 7/28/26 08:27, Srivathsa L Rao wrote:
> Hi Andre,
> 
> On 7/23/2026 9:24 PM, Andre Przywara wrote:
>> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
>> alternative way of accessing the "Memory System Components" (MSC) in an
>> MPAM enabled system.
>>
>> Normally the MSCs are MMIO mapped, but in some implementations this
>> might not be possible (MSC located outside of the local socket, MSC
>> mapped secure-only) or desirable (direct MMIO access too slow or needs
>> to be mediated through a control processor). MPAM-fb standardises a
>> protocol to abstract MSC accesses, building on the SCMI protocol.
>>
>> Add functions that do an MSC read or write access by redirecting the
>> request through a firmware interface. For now this done via an ACPI
>> PCC shared memory and mailbox combination.
>>
>> Since the protocol used is only a small subset of the full SCMI spec,
>> and the SCMI protocol has no full ACPI support anyway, open-code the
>> (simple) SCMI message generation, for just the fields we need.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/Makefile        |   2 +-
>>   drivers/resctrl/mpam_devices.c  |  27 ++++-
>>   drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  20 ++++
>>   include/linux/arm_mpam.h        |   2 +-
>>   5 files changed, 240 insertions(+), 8 deletions(-)
>>   create mode 100644 drivers/resctrl/mpam_fb.c

[ ... ]

>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> new file mode 100644
>> index 000000000000..ec4bf0dd9182
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_fb.c
>> @@ -0,0 +1,197 @@

[ ... ]

>> +static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 
>> msc_id,
>> +                u16 reg, u32 *result, int mpam_fb_command)
>> +{
>> +    unsigned int token = atomic_inc_return(&mpam_fb_token);
>> +    struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
>> +    struct pcc_mbox_chan *chan;
>> +    void __iomem *payload_ofs;
>> +    u32 status;
>> +    int ret;
>> +
>> +    if (!pcc_chan)
>> +        return -ENODEV;
>> +
>> +    chan = pcc_chan->pcc_chan;
>> +
>> +    /* prune token to fit into the 10 bits inside the command 
>> register */
>> +    token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
>> +              FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
>> +
>> +    guard(mutex)(&pcc_chan->pcc_chan_lock);
>> +
>> +    switch (mpam_fb_command) {
>> +    case MPAM_MSC_WRITE_CMD:
>> +        mpam_fb_build_write_message(msc_id, reg, *result,
>> +                        token, chan->shmem);
>> +        break;
>> +    case MPAM_MSC_READ_CMD:
>> +        mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
>> +        break;
>> +    case MPAM_PROTOCOL_VERSION:
>> +        mpam_fb_build_version_message(token, chan->shmem);
>> +        break;
>> +    }
> 
> The switch here has no default case. If an unrecognised command value is
> passed (in future), it maybe safer and future proof to have a default case?

Well, mpam_fb_send_request is a static function, and all callers pass in 
constant values, so this wouldn't easily happen and be more a compile 
time error.
But I can of course add a defensive default check.

Cheers,
Andre

>      default:
>          return -EINVAL; ?> +
>> +    ret = mbox_send_message(chan->mchan, NULL);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    pcc_shmem = chan->shmem;
>> +    payload_ofs = chan->shmem + sizeof(*pcc_shmem);
>> +    status = readl(&pcc_shmem->command);
>> +    if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token)
>> +        return -ETIMEDOUT;
>> +
>> +    ret = readl(payload_ofs + 0x0);
>> +    if (ret < 0) {
>> +        switch (ret) {
>> +        case MPAM_FB_ERR_NOT_SUPPORTED:
>> +            return -EOPNOTSUPP;
>> +        case MPAM_FB_ERR_INVALID_PARAMETERS:
>> +            return -EINVAL;
>> +        case MPAM_FB_ERR_NOT_FOUND:
>> +            return -ENOENT;
>> +        case MPAM_FB_ERR_OUT_OF_RANGE:
>> +            return -ERANGE;
>> +        default:
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
>> +        *result = readl(payload_ofs + 0x4);
>> +
>> +    return 0;
>> +}
>> +
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 
>> *result)
>> +{
>> +    return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
>> +                    reg, result, MPAM_MSC_READ_CMD);
>> +}
>> +
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
>> +{
>> +    return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
>> +                    reg, &value, MPAM_MSC_WRITE_CMD);
>> +}
>> +
>> +int mpam_fb_get_protocol_version(struct mpam_msc *msc)
>> +{
>> +    u32 version;
>> +    int ret;
>> +
>> +    ret = mpam_fb_send_request(msc->pcc_chan, 0,
>> +                   0, &version, MPAM_PROTOCOL_VERSION);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return version;
>> +}
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/ 
>> mpam_internal.h
>> index b3a6ed9ed175..e4686ff0ba2e 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/io.h>
>>   #include <linux/jump_label.h>
>>   #include <linux/llist.h>
>> +#include <linux/mailbox_client.h>
>>   #include <linux/mutex.h>
>>   #include <linux/resctrl.h>
>>   #include <linux/spinlock.h>
>> @@ -57,6 +58,15 @@ struct mpam_garbage {
>>       struct platform_device    *pdev;
>>   };
>> +struct mpam_pcc_chan {
>> +    struct list_head    pcc_chans;
>> +    struct mbox_client    pcc_cl;
>> +    struct pcc_mbox_chan    *pcc_chan;
>> +    struct mutex        pcc_chan_lock; /* only one message at a time */
>> +    struct kref        refcount;
>> +    int            subspace_id;
>> +};
>> +
>>   struct mpam_msc {
>>       /* member of mpam_all_msc */
>>       struct list_head    all_msc_list;
>> @@ -66,6 +76,8 @@ struct mpam_msc {
>>       /* Not modified after mpam_is_enabled() becomes true */
>>       enum mpam_msc_iface    iface;
>> +    struct mpam_pcc_chan    *pcc_chan;
>> +    int            mpam_fb_msc_id;    /* in its own name space */
>>       u32            nrdy_usec;
>>       cpumask_t        accessibility;
>>       bool            has_extd_esr;
>> @@ -511,6 +523,14 @@ static inline void 
>> mpam_resctrl_offline_cpu(unsigned int cpu) { }
>>   static inline void mpam_resctrl_teardown_class(struct mpam_class 
>> *class) { }
>>   #endif /* CONFIG_RESCTRL_FS */
>> +/* MPAM-Fb Firmware-backed protocol wrappers */
>> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 
>> *result);
>> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 
>> value);
>> +int mpam_fb_get_protocol_version(struct mpam_msc *msc);
>> +
>> +#define MPAM_FB_PROT_HEADER_LEN    sizeof(u32)
>> +#define MPAM_FB_MAX_MSG_SIZE    (MPAM_FB_PROT_HEADER_LEN + 4 * 
>> sizeof(u32))
>> +
>>   /*
>>    * MPAM MSCs have the following register layout. See:
>>    * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
>> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
>> index f92a36187a52..002f56e15362 100644
>> --- a/include/linux/arm_mpam.h
>> +++ b/include/linux/arm_mpam.h
>> @@ -12,7 +12,7 @@ struct mpam_msc;
>>   enum mpam_msc_iface {
>>       MPAM_IFACE_MMIO,    /* a real MPAM MSC */
>> -    MPAM_IFACE_PCC,        /* a fake MPAM MSC */
>> +    MPAM_IFACE_PCC,        /* using the MPAM-Fb firmware redirection */
>>   };
>>   enum mpam_class_types {
> 
> Best Regards,
> Srivathsa

