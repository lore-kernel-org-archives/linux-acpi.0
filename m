Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35193C6A2F
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286302; cv=none; b=G9AoTzgQ1EYfF71o5KritQ5JQFtv+/751C2H9PJUjArR0QfebYB9byi4sWovOprbD9RVb0WFOjZPNRSPRcieBUDQpE7jONW7bp263y06eFH1elWEXu1R/XKnGp6WfUVM1Jpk1Isf1Qr+qN1f02wysEi9N5Dn7zj8BVHciOURulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286302; c=relaxed/simple;
	bh=SwZSBJ5dtFN1L7uizFJq7oOv2U7xSNXH+wFesahHWcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXzGJyfKbZnHfs3OUBycyMOXPuC0QbeF9Lw0mcvb/0HMKT0BnPXge98uPipeCve1S+sT3ocOSJJC8iH8wusp/aQ5DzbjBe6sfJrhLgfqeCir4OTcuNheY5iGtTATpsqwNxpLEymUwjmcklNlcFo47flwgQyzuGNfzUln+XcpJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H7LtVRLv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7LtVRLv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so31866865e9.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774286296; x=1774891096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEgEB+FhJamQekHHnnzeHBVC3CCx1oLXNDdzh85xf2M=;
        b=H7LtVRLvEnB8cTx7BQFvJ5hu9u4rx5QsZxDYkmDtjyjJuafEJpVzLCAWAJURU77xBg
         z+7IKMdc++ikOe8pM6fhMXe+h4jQrqi63lRYfnRYy6ey+ggAa76ieXCz6qP4LZWnDlWP
         nuNwstvVAyOAnh/gY3dXQmuk/wFsG6A0ri7um0oX647bRHav456rcHtBk3oIiJz9h43W
         DxwIV2c2+lSlTFuKuQtPDRtW8Iyji+gAvs6ZjUP5MT0oN/Tfs7PpGgeH1pXKx2D36jw3
         dKW1OMqFO0zByNy5eLIaM05hT/8Ec4kas0wyGTEMrJ32YXgHC8fEY4CdczmrroM8pDD4
         e0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286296; x=1774891096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEgEB+FhJamQekHHnnzeHBVC3CCx1oLXNDdzh85xf2M=;
        b=rFEbAuxGvhqaJu9n5pIePG4JNy+AHl1lUoiujbTdmLajEJ/3zjHj73/xkcTKYmEFXP
         m4uHJShkGjvx62pr5Cc3mZHltU+rFdAbl96h7yWAxcQkUFgzCZU/QUr74Xvtx0ncJUqJ
         eJwqECVPr7dpmrqMlUqdXavc4TexRRrfvE+FxQQbjswE+aPUOKpyGhmbxvW62cNuDVtc
         hZXKy2JAXkDy8+mosN5dibfK18rWTo4y0Mrms0CPHP7LrcQbqb8b3SlGrfz1J0c6dzfb
         zhI55ej4TchDDtLEV0euz6df2QybGS4sBPMsGYesf7DeFQvP840F96ewBk6gQ7hGEXOa
         Sg6g==
X-Gm-Message-State: AOJu0Yz1jwgH9IdoBrt2F0F2Joc7pXfmvvudlSpN/j4gWqOYE0jjCKuR
	igCpaVS5qJtWI2kE14CkxRrepEPqxYbESQGqXkwL3qIiHB7GtiMnw4EGHeyPQVoCewA=
X-Gm-Gg: ATEYQzyGwwd5op/CUR2Ip7MbBG5vUsVgfoVb0XLGNXC5STPHKwYM6Or2/WIXcLGNRzN
	Z5Lud3/TLfx7nVdj0omQ1Yo178KCW1dF0h/we/ieeOf8LAZE5x0dtH6uuIvXjUxtsiF+cT19sph
	XujKgy29YFQoMZVrZ0+ADlW32FmEYO8k0t/SaAxTBBsWb/qD5tuQdOIKmHQqpXcOPUq/aGbxYm2
	hgVHmtOtK5abkZXH/wLRwbtVxt+FTIUj7XFfEXlg+sHJ21y5kjlsmMH9sdypmhvpnI0YLY6jxdY
	s95s6ObRsWv/K9GUmvCGFl35oBTDmPTrj5+LLQVHNa3STxZ9uIqAAlVC68kaW6lD7n73EJgNAU/
	zmV1odSvHTk/Fqhk6TEAxcslLe3OgFf7E4GKOf9oaTLkObf1zOU4r2z8h6o9Zo28J+HA12KLXPJ
	pm1DiHdCwt0ijk+5p2gwsLej3aaxjZD2Q=
X-Received: by 2002:a05:600c:c083:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-486fee0481amr142927935e9.14.1774286295324;
        Mon, 23 Mar 2026 10:18:15 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bf1c5sm33929334f8f.14.2026.03.23.10.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:18:13 -0700 (PDT)
Message-ID: <67b32e90-1f60-4bf5-b534-b4a901d5a796@linaro.org>
Date: Mon, 23 Mar 2026 19:18:08 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Juan Yescas <jyescas@google.com>, kernel-team@android.com
References: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Robin,

On 2/28/25 5:46 PM, Robin Murphy wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a3b45b84f42b..1cec7074367a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -414,9 +414,21 @@ static int iommu_init_device(struct device *dev)
>  	if (!dev_iommu_get(dev))
>  		return -ENOMEM;
>  	/*
> -	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> -	 * instances with non-NULL fwnodes, and client devices should have been
> -	 * identified with a fwspec by this point. Otherwise, we can currently
> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
> +	 * is buried in the bus dma_configure path. Properly unpicking that is
> +	 * still a big job, so for now just invoke the whole thing. The device
> +	 * already having a driver bound means dma_configure has already run and
> +	 * either found no IOMMU to wait for, or we're in its replay call right
> +	 * now, so either way there's no point calling it again.
> +	 */
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}

I was chasing the "something fishy" dev_WARN on a 6.19+ downstream
android kernel and while looking at the IOMMU code I couldn't help
myself and ask whether we shall prevent concurrent execution of
dma_configure().

It seems to me that while the IOMMU subsystem is executing
dma_configure(), the deferred probe workqueue can concurrently pick up
the same device, enter really_probe(), set dev->driver, and execute
dma_configure(). Is it worth protecting against this?

I can try to prove it if needed, using a downstream iommu driver (sigh).

Thanks!
ta

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e61927b4d41f..5f0c1a8064b5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -461,9 +461,19 @@ static int iommu_init_device(struct device *dev)
         * already having a driver bound means dma_configure has already run and
         * found no IOMMU to wait for, so there's no point calling it again.
         */
-       if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
+       if (!dev->iommu->fwspec && !READ_ONCE(dev->driver) &&
+           dev->bus->dma_configure) {
                mutex_unlock(&iommu_probe_device_lock);
-               dev->bus->dma_configure(dev);
+
+               /*
+                * Serialize with really_probe(). Recheck dev->driver in case a
+                * driver bound while we were waiting for the lock.
+                */
+               device_lock(dev);
+               if (!dev->driver)
+                       dev->bus->dma_configure(dev);
+               device_unlock(dev);
+
                mutex_lock(&iommu_probe_device_lock);
                /* If another instance finished the job for us, skip it */
                if (!dev->iommu || dev->iommu_group)
(END)
