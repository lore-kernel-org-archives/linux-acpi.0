Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A233937F;
	Mon,  3 Aug 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778538; cv=none; b=EK4FS0oY6l/OKSLmK6uEL21h5/pe6Uz8lvsIwLp7MexoHtPqdpbJnTOeovE4n6rfVovdaZ3A1cpezK6EjCjkUcH96YjwLivCbJ3o4Y6Exu4zXxV5dHoNzGJTtBW0bcxJks6Bs/xAY/oDCMWChZ6WD1Hrg0V+ZwAmszSeNQRJVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778538; c=relaxed/simple;
	bh=+ALGav38oUjSlSQ4y5z7giWSuZ9VX7Z7OqGTEHgP0Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blVtwZtEEo3zlp9vGIL20UYRrRPzEHJmA7uj9xF+5p1ooVfQ5n6UxA1wtkM0rPmV/Qdw5OBne/A/QSnceXTn+E0YMgQHJi2yMF7kiw50BH9yq2J0MWfUY+5nSfa4qzgbQ9Iin7YBJqZNVEvasRGcQ7MeTgXogP0bzCjI4XWy1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OJFMp4CW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OJFMp4CW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 770E7143D;
	Mon,  3 Aug 2026 10:35:31 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DAB73F632;
	Mon,  3 Aug 2026 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785778535; bh=+ALGav38oUjSlSQ4y5z7giWSuZ9VX7Z7OqGTEHgP0Sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJFMp4CWbXpl6BdC+qScE1HVqbmT3n9PHYswMlI5hiG8h2llYd6kkKEWKUuT/ZxcB
	 en/1IZU/Zx1/MqNTG1PNJhjwuhddQH8rokW9QSTweoPoGAwbikNa1o3BbNxWM5LHpC
	 p4BKl3+D1tRblpUfSFe6EdOpnou7fAkgjGrFN9eY=
Message-ID: <0fc539a4-cc55-4003-b579-19fd98e255ab@arm.com>
Date: Mon, 3 Aug 2026 18:35:31 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] FIX: avoid using mailbox client dev pointer for error
 prints
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
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-12-andre.przywara@arm.com>
 <20260803170458.3135976-1-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260803170458.3135976-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 8/3/26 18:04, Andre Przywara wrote:
> When a PCC channel is shared among several MSCs, all use the same
> mailbox client struct, which contains the device pointer of the very
> first MSC created. If that MSC goes away, the dev pointer becomes stale.
> We use that pointer only for error printing, so drop that usage. We can
> use the dev pointer from the MSC instead, which the callers of
> mpam_fb_send_request() know.
> The mailbox client code also seems to use this pointer only for error
> prints, and only during initialisation, so it becoming stale afterwards
> does not cause problems.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> so this is the fix for the issue that Srivathsa described. This applies
> on top of the v7 series posted. I put up a branch with the patch
> squashed here:
> https://gitlab.arm.com/linux-arm/linux-ap/-/commits/mpam-fb-v7-fixed?ref_type=heads
> If I shall post a v8, please let me know.

This fix looks good to me. A v8 seems useful, if only to make sure Sashiko runs. As you said, I
think it requires the --base option to format-patch now we have conflicts with fixes. I've also
commented on the error irq patch but we're looking in pretty good shape.

Thanks,

Ben

> 
> Cheers,
> Andre
> 
>  drivers/resctrl/mpam_fb.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> index 7a7fb6d067ba..79e0229b77c1 100644
> --- a/drivers/resctrl/mpam_fb.c
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -6,6 +6,7 @@
>  #include <linux/errno.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
> +#include <linux/platform_device.h>
>  #include <linux/types.h>
>  
>  #include <acpi/pcc.h>
> @@ -128,17 +129,19 @@ static int mpam_fb_translate_error_code(int mpam_fb_code)
>  	}
>  }
>  
> -static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
> +static int mpam_fb_send_request(struct mpam_msc *msc, u32 msc_id,
>  				u16 reg, u32 *result, int mpam_fb_command)
>  {
>  	unsigned int token = atomic_inc_return(&mpam_fb_token);
>  	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
> +	struct mpam_pcc_chan *pcc_chan;
>  	struct pcc_mbox_chan *chan;
>  	void __iomem *payload_ofs;
>  	int mpam_fb_err = 0;
>  	u32 status;
>  	int ret;
>  
> +	pcc_chan = msc->pcc_chan;
>  	if (!pcc_chan)
>  		return -ENODEV;
>  
> @@ -162,7 +165,7 @@ static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
>  		mpam_fb_build_version_message(token, chan->shmem);
>  		break;
>  	default:
> -		dev_err(pcc_chan->pcc_cl.dev, "unsupported MPAM-Fb command %d\n",
> +		dev_err(&msc->pdev->dev, "unsupported MPAM-Fb command %d\n",
>  			mpam_fb_command);
>  		ret = -EINVAL;
>  		goto out_err;
> @@ -203,13 +206,13 @@ static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
>  
>  int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
>  {
> -	return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, result,
> +	return mpam_fb_send_request(msc, msc->id, reg, result,
>  				    MPAM_MSC_READ_CMD);
>  }
>  
>  int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
>  {
> -	return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, &value,
> +	return mpam_fb_send_request(msc, msc->id, reg, &value,
>  				    MPAM_MSC_WRITE_CMD);
>  }
>  
> @@ -219,7 +222,7 @@ int mpam_fb_check_protocol_version(struct mpam_msc *msc)
>  	u32 version;
>  	int ret;
>  
> -	ret = mpam_fb_send_request(msc->pcc_chan, 0,
> +	ret = mpam_fb_send_request(msc, 0,
>  				   0, &version, MPAM_PROTOCOL_VERSION_CMD);
>  	if (ret)
>  		return ret;

