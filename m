Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BC45A28B;
	Mon, 21 Sep 2026 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984477; cv=none; b=kfeZlpla2fxulA/8wcC1MoKZ3GgtofbQdc4Z+6SxICGvcmMzWjVU5DthcFm5HnvIl+/ik8Yk5qtEjhnxOIcqpQHh3Yf7uTX3plm4YNT2d+/j9P3I+MDoiGZI/Z56swe83xXWTCT0CQ4fXZjghorlrZvAOoZ5oDm4RtROz6vqU74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984477; c=relaxed/simple;
	bh=OAwdXyfVas7QpTQPW+CfXHr3lOSEvjjt1khnkrh06p8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W0zSXq+xwj/dZLuySMEnqgfhxNKEj5QFkl8CtJr4Q8fQlz6TY8+HH3bI2PROMwvErO57DOhR1eKvKAxFoVkGFwairTXr6twP4EFp2qzaRyRJ4R4g2Fb5FL4UAfrnZm0mksxLyD34c0nWteXuTBEfpmW7RXeXDJGWgRwjdFDbQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AM8SilRn; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AM8SilRn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+Mcd4no3UbI4LZC3U6cjCroRtcCSEmK+AcwHgX1z/10=;
	b=AM8SilRnwAQhIli30+gdRB7/GoUQZvPgxLBbtFpQpmguu+Cs3UBMlPZIHmaOO+2wnlPYT2h1V
	tAzOXIh+42kdWcT9wKEQ45L96Joo/3glCIEMjzXQdHFRsZ2o4AcXh/f6Vxvam9FIN9K4rTKJwm8
	J7lFm/cxQ6oiExkwihUz/hM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hpJFW5gx5zmV8f;
	Mon, 21 Sep 2026 17:43:27 +0800 (CST)
Received: from whupemk200014.china.huawei.com (unknown [7.152.185.79])
	by mail.maildlp.com (Postfix) with ESMTPS id B8C804048B;
	Mon, 21 Sep 2026 17:54:29 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 whupemk200014.china.huawei.com (7.152.185.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 21 Sep 2026 17:54:28 +0800
Subject: Re: [PATCH v2 2/3] ACPI: arm64: Add support for the FF-A FFH
 Operation Region (offset 2)
To: Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260901192906.133670-1-jamien@nvidia.com>
 <20260901192906.133670-3-jamien@nvidia.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6ed517b2-90e8-8654-757e-6c0730b7d321@huawei.com>
Date: Mon, 21 Sep 2026 17:54:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260901192906.133670-3-jamien@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk200014.china.huawei.com (7.152.185.79)

On 2026/9/2 3:29, Jamie Nguyen wrote:
> Arm DEN0048D (Functional Fixed Hardware Specification v1.3, March 2026)
> added a third FFH Operation Region flavour. An Operation Region declared
> with an Offset of 0x2 triggers an FFA_MSG_SEND_DIRECT_REQ2 call instead of
> a bare SMC or HVC, and each 64-bit field of the region is one register,
> starting at X0:
> 
>    X0		call status, populated by OSPM on return
>    X1		Bits[15:0] receiver endpoint ID, or zero to have OSPM
> 		resolve it from the service UUID
>    X2-X3		service UUID of the callee partition, written by ACPI
> 		platform firmware using ToUUID()
>    X4-X17	message payload, X4 is always present
> 
> DEN0048D recommends Offset 0x2 for new platforms, since not every OSPM
> implements Offsets 0x0 and 0x1. Linux implements both and rejects anything
> else, so AML using the recommended encoding simply fails today.
> 
> Add the Operation Region side of it. Region length validation, the X0-X17
> layout, the ToUUID() to FF-A UUID byte order conversion and the DEN0048D
> table 3 status codes all live here; they are ACPI semantics, not FF-A
> ones. The call itself goes out through a small set of ops that the FF-A
> driver registers. That indirection is needed because this file is built
> in, while CONFIG_ARM_FFA_TRANSPORT is a tristate.
> 
> Anything that stops the call being made comes back to AML in the X0 status
> field: a malformed region length, or a null service UUID when AML has
> asked OSPM to find the endpoint itself. Once the call has gone out every
> register is copied back, whatever the outcome, which is what DEN0048D
> requires. That also takes care of table 3, because FFA_ERROR reports the
> FF-A error code in X2 and FFH_FFA_CALL_FAILED wants it in the same place.
> A response that is neither FFA_ERROR nor FFA_MSG_SEND_DIRECT_RESP2 is
> handled the same way; the call did complete.
> 
> Assisted-by: Claude:claude-opus-5
> Co-developed-by: Dat Mach <dmach@nvidia.com>
> Signed-off-by: Dat Mach <dmach@nvidia.com>
> Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
> ---
>   drivers/acpi/arm64/ffh.c | 185 +++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h     |  41 +++++++++
>   2 files changed, 226 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/ffh.c b/drivers/acpi/arm64/ffh.c
> index 04380bab193df..9f8a508cf2d4a 100644
> --- a/drivers/acpi/arm64/ffh.c
> +++ b/drivers/acpi/arm64/ffh.c
> @@ -1,7 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   #include <linux/acpi.h>
>   #include <linux/arm-smccc.h>
> +#include <linux/rwsem.h>
>   #include <linux/slab.h>
> +#include <linux/uuid.h>
>   
>   /*
>    * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
> @@ -62,6 +64,183 @@ static bool acpi_ffh_smccc_owner_allowed(u32 fid)
>   	return false;
>   }
>   
> +/*
> + * FFH Operation Regions declared with an Offset of 0x2 trigger an
> + * FFA_MSG_SEND_DIRECT_REQ2 call, as described in Arm DEN0048D (Functional
> + * Fixed Hardware Specification v1.3) section 2.3.1.2. Every 64-bit field of
> + * the region maps to one register, ordered from X0:
> + *
> + *   X0		status, one of the ACPI_FFH_FFA_* codes below, populated by
> + *		OSPM on return
> + *   X1		Bits[15:0] hold the receiver endpoint ID, or zero to have OSPM
> + *		resolve it from the service UUID
> + *   X2-X3	service UUID of the callee partition, written by ACPI platform
> + *		firmware with the ToUUID() ASL operator
> + *   X4-X17	message payload, X4 is always present
> + *
> + * The region Length is "32 + 8 * N" bytes with 1 <= N <= 14, which is X0-X4
> + * at minimum and X0-X17 at most.
> + */
> +#define ACPI_FFH_FFA_HDR_REGS		4	/* X0 - X3 */
> +#define ACPI_FFH_FFA_MAX_PAYLOAD_REGS	14	/* X4 - X17 */
> +#define ACPI_FFH_FFA_UUID_OFFSET	(2 * sizeof(u64))
> +#define ACPI_FFH_FFA_MIN_LENGTH		((ACPI_FFH_FFA_HDR_REGS + 1) * sizeof(u64))
> +#define ACPI_FFH_FFA_MAX_LENGTH		\
> +	((ACPI_FFH_FFA_HDR_REGS + ACPI_FFH_FFA_MAX_PAYLOAD_REGS) * sizeof(u64))
> +
> +/* DEN0048D table 3, FFH Operation Region status codes for FFA calls */
> +#define ACPI_FFH_FFA_CALL_FAILED		1
> +#define ACPI_FFH_FFA_SUCCESS			0
> +#define ACPI_FFH_FFA_NOT_SUPPORTED		(-1)
> +#define ACPI_FFH_FFA_INVALID_PARAMETERS		(-2)
> +#define ACPI_FFH_FFA_OUT_OF_MEMORY		(-3)
> +#define ACPI_FFH_FFA_UNSPECIFIED_ERROR		(-4)
> +
> +static const struct acpi_ffh_ffa_ops *ffa_ops;
> +static DECLARE_RWSEM(ffa_ops_sem);
> +
> +int acpi_ffh_ffa_register(const struct acpi_ffh_ffa_ops *ops)
> +{
> +	int ret = 0;
> +
> +	if (!ops || !ops->partition_id || !ops->direct_req2)
> +		return -EINVAL;
> +
> +	down_write(&ffa_ops_sem);
> +	if (ffa_ops)
> +		ret = -EBUSY;
> +	else
> +		ffa_ops = ops;
> +	up_write(&ffa_ops_sem);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_ffh_ffa_register);
> +
> +void acpi_ffh_ffa_unregister(const struct acpi_ffh_ffa_ops *ops)
> +{
> +	down_write(&ffa_ops_sem);
> +	if (ffa_ops == ops)
> +		ffa_ops = NULL;
> +	up_write(&ffa_ops_sem);
> +}
> +EXPORT_SYMBOL_GPL(acpi_ffh_ffa_unregister);
> +
> +/*
> + * ToUUID() emits the UUID in mixed-endian (EFI GUID) byte order whereas FF-A
> + * expects the RFC4122 layout, which is exactly a guid_t to uuid_t conversion.
> + */
> +static void acpi_ffh_ffa_uuid(uuid_t *uuid, const u8 *aml_buf)
> +{
> +	int i;
> +
> +	for (i = 0; i < UUID_SIZE; i++)
> +		uuid->b[i] = aml_buf[guid_index[i]];
> +}
> +
> +static int acpi_ffh_ffa_status(int err)
> +{
> +	switch (err) {
> +	case 0:
> +		return ACPI_FFH_FFA_SUCCESS;
> +	case -EIO:
> +	case -EPROTO:
> +		return ACPI_FFH_FFA_CALL_FAILED;
> +	case -EOPNOTSUPP:
> +		return ACPI_FFH_FFA_NOT_SUPPORTED;
> +	case -EINVAL:
> +	case -ENOENT:
> +	case -ENODEV:
> +	case -ENOTUNIQ:
> +		return ACPI_FFH_FFA_INVALID_PARAMETERS;
> +	case -ENOMEM:
> +		return ACPI_FFH_FFA_OUT_OF_MEMORY;
> +	default:
> +		return ACPI_FFH_FFA_UNSPECIFIED_ERROR;
> +	}
> +}
> +
> +static bool acpi_ffh_ffa_length_valid(u64 length)
> +{
> +	return length >= ACPI_FFH_FFA_MIN_LENGTH &&
> +	       length <= ACPI_FFH_FFA_MAX_LENGTH &&
> +	       !(length % sizeof(u64));
> +}
> +
> +static void acpi_ffh_ffa_handler(struct acpi_ffh_info *info, void *value)
> +{
> +	int status = ACPI_FFH_FFA_INVALID_PARAMETERS;
> +	u64 resp_regs[3] = {};
> +	unsigned int nr_payload;
> +	u64 *regs = value;
> +	uuid_t uuid;
> +	u16 dst_id;
> +	int ret;
> +
> +	if (!acpi_ffh_ffa_length_valid(info->length))
> +		goto out;
> +
> +	nr_payload = info->length / sizeof(u64) - ACPI_FFH_FFA_HDR_REGS;
> +
> +	acpi_ffh_ffa_uuid(&uuid, (u8 *)value + ACPI_FFH_FFA_UUID_OFFSET);
> +
> +	down_read(&ffa_ops_sem);
> +	if (!ffa_ops) {
> +		status = ACPI_FFH_FFA_NOT_SUPPORTED;
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * A zero receiver endpoint ID means ACPI platform firmware expects
> +	 * OSPM to derive it from the service UUID.
> +	 */
> +	dst_id = regs[1] & GENMASK(15, 0);
> +	if (!dst_id) {
> +		/*
> +		 * A null UUID means "every partition" to
> +		 * FFA_PARTITION_INFO_GET, so reject it here rather than let a
> +		 * bare read of the Operation Region, which arrives as a zeroed
> +		 * buffer, resolve to an arbitrary endpoint.
> +		 */
> +		if (uuid_is_null(&uuid))
> +			goto out_unlock;
> +
> +		ret = ffa_ops->partition_id(&uuid, &dst_id);
> +		if (ret) {
> +			status = acpi_ffh_ffa_status(ret);
> +			goto out_unlock;
> +		}
> +	}
> +
> +	ret = ffa_ops->direct_req2(dst_id, &uuid, regs + ACPI_FFH_FFA_HDR_REGS,
> +				   nr_payload, resp_regs);
> +	status = acpi_ffh_ffa_status(ret);
> +
> +	/*
> +	 * DEN0048D asks for the response registers to be copied back. That also
> +	 * takes care of table 3: FFA_ERROR reports the FF-A error code in X2,
> +	 * which is exactly where FFH_FFA_CALL_FAILED wants it. -EIO and -EPROTO
> +	 * both mean the call completed, so the registers hold the callee's
> +	 * response and not AML's own request.
> +	 */
> +	if (!ret || ret == -EIO || ret == -EPROTO) {
> +		regs[1] = resp_regs[0];
> +		regs[2] = resp_regs[1];
> +		regs[3] = resp_regs[2];
> +	}
> +
> +out_unlock:
> +	up_read(&ffa_ops_sem);
> +out:
> +	/*
> +	 * DEN0048D describes this field as 64 bits wide and gives the table 3
> +	 * codes as signed values, so sign extend rather than write a narrower
> +	 * quantity. 0xfffe or 0xfffffffe would read back as a positive number
> +	 * in a 64-bit AML comparison.
> +	 */
> +	regs[0] = (u64)(s64)status;
> +}
> +
>   int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_context)
>   {
>   	int ret = 0;
> @@ -99,6 +278,12 @@ int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_contex
>   			ffh_ctxt->invoke_ffh64_fn(r, r);
>   			memcpy(value, r, ffh_ctxt->info.length);
>   		}
> +	} else if (ffh_ctxt->info.offset == 2) {
> +		/* FFA_MSG_SEND_DIRECT_REQ2 call */
> +		if (ffh_ctxt->info.length < sizeof(u64))
> +			ret = AE_ERROR;

There is a acpi_ffh_ffa_length_valid() check in acpi_ffh_ffa_handler(),
is it a duplicated one here?

> +		else
> +			acpi_ffh_ffa_handler(&ffh_ctxt->info, value);

Thanks
Hanjun
