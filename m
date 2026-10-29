Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287238;
	b=W88uKsaJ+PQroTcNRdGKnY1xl1iwUX/37GwvIor7HlMNC/w1fn3Q659mjd3yxdOSkIeg
	 pcCwXash41qEMTK12EI1SHiZuRisQnVV1vXXdAclG8bO+LbxRL298E3S3jMpSxzQr4jDp
	 0f2sid9p864RMSDtTUaHOljkh/RD11RxHkp0S3VSPd7KHIK3AnAgIFPtVxYsQn6JkAvBj
	 Jc47LbuwUJEYUtk1qn8A5ClPg6dSIPpW3zFvGJkCkl+7+9LIeOqPqjgBCEP11qfVq0Hqv
	 g/05JiSGaykisNHO/SfxuLnUqBskcf3YT+Hr7QUJnCX+l8lAetTKy87GqolJlmk08Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287238;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YNtzOHBIDefRhwkoBdu0VmuJr8iGnrmpv1C4RVrOtuI=;
	b=nMM5BRobsMeG9noXtiIDzWt5xUgv2tkTlxejIbufzEDQMhdCULjCwNR+g6kE5XgIt5RW
	 yj7p4HRYlV2G1/Mt5pvEkwVby5/mr0lcI3G+td0QMvYWlTJxkDhbsaMNGwNa2uLPGEDq0
	 sc/MyY0XJePkr6AXPRf+6kT/gGZhFT2tyQxEVuDStiJnOgYCCtT/lAoBlbUbjpf2Ur6Kh
	 nG5L8d3toeei5vwBQEst4S8Uxy/zNuKGF9NLOA1unuU7nmxAln98990IC7gjfLP7jST+D
	 jy8JWlWRRqnq78v062sFKJ+Os86g5/VfpxDRwlNrDQ1scEuhAKUDGyo0Ab/v31DO/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1+stCLG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD87606A31A;
	Thu, 29 Oct 2026 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1+stCLG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20581F01824;
	Thu, 29 Oct 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287237;
	bh=YNtzOHBIDefRhwkoBdu0VmuJr8iGnrmpv1C4RVrOtuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l1+stCLGuGuddp5FZgDLxWPrHt0I10EoPNtGNu/K6sNZ3Tj5kR1V21HhZT2vzYSpQ
	 1z3Q/KeUl9P7480hTMMlGsx0C5mpsdlTLMyU5YmTXvloq2JRUmzHCWwIP++Xc1OzFh
	 pUQI9IUWlF734zlTLjcwT8jM0AM+b+3e/AOxqi0iQsIs3tk488t9uPgkcxfWPCENGg
	 F8uevdRAHUSAbasaP818alM170oDowB0UfAnMeVCOj95RCXgYzOf/0TImEqxIjfVAr
	 VfAev2UAVQIqnEHoAE/nonbJeGcuazqSYP0kqwevB1j7qaOEG5Qv5T0qc8TciVlUI6
	 jusRYhr7LXe5g==
Message-ID: <06b18cb4-cd1d-48b8-8944-dd1139ad18ad@kernel.org>
Date: Thu, 29 Oct 2026 10:20:33 -0500
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from
 its own node
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261029151422.56791-1-mike@fireburn.co.uk>
 <20261029151422.56791-2-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261029151422.56791-2-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 10:14, Mike Lothian wrote:
> On BOCO platforms the SBIOS can signal a display hotplug on a powered
> off dGPU by notifying the dGPU's ACPI node. On the ASUS ROG Strix G513QY
> the USB-C DP alt mode lanes are driven by the Navi 22, and the CPM
> D3cold table handles the HPD GPE with only:
> 
>    Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) }
> 
> Nothing in Linux listens on that node: ATIF is bound to the iGPU and the
> dGPU node is not an ACPI video bus. If the dGPU is in D3cold when a dock
> is attached it stays off, no hotplug reaches userspace, the external
> displays stay dark, and the level-triggered GPE keeps firing until the
> dock is removed.
> 
> Install an ACPI device notify handler on the dGPU's companion when BOCO
> is used, and request a runtime resume on 0x81. Runtime resume already
> re-detects all links and sends a hotplug event, so the new displays are
> picked up; the device autosuspends again if nothing is enabled.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 ++++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7974f9b7944f..deb63122828d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -641,6 +641,7 @@ struct amdgpu_device {
>   	bool				need_swiotlb;
>   	bool				accel_working;
>   	struct notifier_block		acpi_nb;
> +	bool				acpi_dgpu_notify;
>   	struct notifier_block		pm_nb;
>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>   	struct debugfs_blob_wrapper debugfs_vbios_blob;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 7f5abb03be1b..a4041f90b374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1280,6 +1280,23 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
>   	return amdgpu_atif_handler(adev, entry);
>   }
>   
> +/*
> + * On BOCO platforms the SBIOS signals display hotplug on a powered-off dGPU

Although your system is a BOCO platform; I do think this same thing for 
this signaling to wakeup could apply to a BACO system too.

> + * (e.g. USB-C DP alt mode HPD wired to the dGPU) with Notify(<dGPU>, 0x81)
> + * on the dGPU's own ACPI node. Nothing else listens there, so wake the
> + * device; runtime resume re-detects all links and sends a hotplug event.
> + */
> +static void amdgpu_acpi_dgpu_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	if (event != ACPI_VIDEO_NOTIFY_PROBE)
> +		return;
> +
> +	dev_dbg(adev->dev, "ACPI notify 0x%x, requesting runtime resume\n", event);
> +	pm_request_resume(adev->dev);
> +}
> +
>   /* Call all ACPI methods here */
>   /**
>    * amdgpu_acpi_init - init driver acpi support
> @@ -1325,6 +1342,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
>   	register_acpi_notifier(&adev->acpi_nb);
>   
> +	if (!(adev->flags & AMD_IS_APU) && ACPI_COMPANION(adev->dev) &&
> +	    adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)

I'd install the notifier for BACO as well.
> +		adev->acpi_dgpu_notify =
> +			!acpi_dev_install_notify_handler(ACPI_COMPANION(adev->dev),
> +							 ACPI_DEVICE_NOTIFY,
> +							 amdgpu_acpi_dgpu_notify,
> +							 adev);
> +
>   	return 0;
>   }
>   
> @@ -1344,6 +1369,12 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
>    */
>   void amdgpu_acpi_fini(struct amdgpu_device *adev)
>   {
> +	if (adev->acpi_dgpu_notify) {
> +		acpi_dev_remove_notify_handler(ACPI_COMPANION(adev->dev),
> +					       ACPI_DEVICE_NOTIFY,
> +					       amdgpu_acpi_dgpu_notify);
> +		adev->acpi_dgpu_notify = false;
> +	}
>   	unregister_acpi_notifier(&adev->acpi_nb);
>   }
>   

