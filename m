Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B43164B4;
	Mon, 27 Jul 2026 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190892; cv=none; b=F/GbWgIb6NwzG+Z1BIqScrkzjdWt7NGMn7f3gYaKFN8tz/3qdgShNXqwb8YdsoRdR/QpG3rWCfNN9vl5/T75USxQBfj77SP8thGst9piJe+Bm+iapsB4GneBXlg15Vb0ctK6pszJEJdmGy0sTiWLkPt0iKx2W2i5tH0bWG7UA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190892; c=relaxed/simple;
	bh=ep71qnrJsCVnCj6hgKdtGq7ZcQv5OgJMiz6Qo4Yq+QU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mr4PDbF8h1rfIw3Q75VCEuZhWhghzv++ZaQtvcs4RBKVFkQTt38Iql6CNTPbvY2g2eIeRLflI5NCd8no7c2U8AoEQsR6yobMw0HqIWu4sL+ufQ0iQ/Nu8QRFVK3IFojwFQ+g+oEuZwrq6tKTgQSuAv0DSKEeK1hjo8efMDCvGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU2h3NmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU2h3NmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328881F000E9;
	Mon, 27 Jul 2026 22:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190891;
	bh=/B0Dz5xPAtVHWPdSgpthRGmFg8JLYxSC+bHoGBmOXFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mU2h3NmCvFhZPzXzJ6UJez5rSbTTqvAdfsuvF0Xld78GH/XSbcqeHlfwqV0NcOcoi
	 6Z2oP8XIput9YN+SqUSy1PPsAdBwvasu5pGWcQygm0+xSS8hy3bqsvq322opbNd65y
	 AIAjVyiAe1/BvdLPpQXQDSUNnXffUVJDfjC8ZMFw6ex50VqWUZrKaoac+YJCdlarO2
	 cc4dFSm/VjJxj7lLHjSgZwJ7sEa8ElVDDZ0WFRRjgpEjSgAVqYG7GM2uoMKWSP4KjQ
	 HdWfLXCZgZclXO45zC6AnSY1iuDQKbQUxRd/EMUeLAnk6AzqVt7yLcqPxMVDHZPT4l
	 r9Tt13JPUb6UA==
Date: Mon, 27 Jul 2026 23:21:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, Srivathsa L
 Rao <srivathsa.rao@oss.qualcomm.com>, Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
 Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] arm_mpam: propagate MSC access errors for
 hw_probe functions
Message-ID: <20260727232125.357fd22c@jic23-huawei>
In-Reply-To: <20260723155454.1760823-3-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-3-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:54:46 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the functions probing for MSC hardware and features to return an
> error, and propagate read and write errors from the lower level up.
> This uses some "scoped cleanup" functions like scoped_guard() and
> ACQUIRE() to avoid the complexity of error handling when a lock has been
> taken. Since the mon_sel_lock is a bit special (even more so in an
> upcoming patch), we define a new GUARD type for it.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Hi Andre

A couple of whites space comments inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/resctrl/mpam_devices.c  | 127 +++++++++++++++++++++-----------
>  drivers/resctrl/mpam_internal.h |   8 ++
>  2 files changed, 91 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 912c21ce7f9f..ecd45a585942 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c

>  
>  static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  {
> +	int ret;
>  	u64 idr;
>  	u16 partid_max;
>  	u8 ris_idx, pmg_max;
> @@ -1021,11 +1047,14 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  	}
>  
>  	/* Grab an IDR value to find out how many RIS there are */
> -	mutex_lock(&msc->part_sel_lock);
> -	mpam_msc_read_idr(msc, &idr);
> -	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
> -
> -	mutex_unlock(&msc->part_sel_lock);
> +	scoped_guard(mutex, &msc->part_sel_lock) {
> +		ret = mpam_msc_read_idr(msc, &idr);
> +		if (ret)
> +			return ret;

Aim for formatting consistency.  I'd put a blank line here and
in similar locations to keep each read / error check block separate...

> +		ret = mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	mpam_enable_quirks(msc);
>  
> @@ -1036,10 +1065,15 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  	msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>  
>  	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
> -		mutex_lock(&msc->part_sel_lock);
> -		__mpam_part_sel(ris_idx, 0, msc);
> -		mpam_msc_read_idr(msc, &idr);
> -		mutex_unlock(&msc->part_sel_lock);
> +		scoped_guard(mutex, &msc->part_sel_lock) {
> +			ret = __mpam_part_sel(ris_idx, 0, msc);
> +			if (ret)
> +				return ret;
> +
Just like you have done here.
> +			ret = mpam_msc_read_idr(msc, &idr);
> +			if (ret)
> +				return ret;
> +		}
>  
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 04d1a59f02af..0c3f6a040b20 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -162,6 +162,14 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>  	raw_spin_lock_init(&msc->_mon_sel_lock);
>  }
>  
> +DEFINE_GUARD(mon_sel,
> +	     struct mpam_msc *,
> +	     mpam_mon_sel_lock(_T),
> +	     mpam_mon_sel_unlock(_T));
Why wrap so much.  Something like:
DEFINE_GUARD(mon_sel, struct mpam_msc *,
	     mpam_mon_sel_lock(_T), mpam_mon_sel_unlock(_T));

or all on one line seems fine to me.



> +DEFINE_GUARD_COND(mon_sel, _lock,
> +		  mpam_mon_sel_lock(_T),
> +		  _RET);
> +

Similar.

>  /* Bits for mpam features bitmaps */
>  enum mpam_device_features {
>  	mpam_feat_cpor_part,

