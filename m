Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A434F259
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718010; cv=none; b=QLMMAWlk25xM+ECeyjxu+vLloHj1AmLiyAT11YEBl6M5R4H5XyafC3LtNrdHNPtY+c+rffQ/Jqs7L1a4pRQ8fSaVuqKyHKNut76GKp7wO9jfGBNJ3UxSjLTmatoj8T3ePd/vKuJiBWAxXlH4haD9WpAYET6auoCPDZQn0ffyryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718010; c=relaxed/simple;
	bh=3H6Tx8GKVFXGcwT6woXKZw4U9eyeRFNU5j+1Z0MDS6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdxK/YMxH2TuB6OK9jP9EIZ26L/UV0kULQsOez7x3CluZYOd7MjLas97xSSYwjCmbLC1tDMHKgchKR5gumVSy8K5aa32tZpBng54jMkCK3Ah32wVpfo0o9+ICaRcYPIkhpZjyhNK4uoGLN6rOq2VvQff1lp+t+T11u80Oa4FQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME3Wd1Bq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME3Wd1Bq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4905529b933so60759565e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781718007; x=1782322807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E4aTYQpCEBfoHlNp/ih1aDYhCnw5Uq36PYKp2Wj/2Xk=;
        b=ME3Wd1BqunjbXx1jj5Nqrd4ZQ0HbyYsoc4LsCb+zo/c/DY4jbzO6IMvFSQRPn1XW4e
         0Rm+67aRIPdnLLaLgz7NbLkLKj5rdH46f8vV+PnvkM6lK+GCNg2cOk3Mmh9W/LY9syzO
         4LXczJCror55fEGYc2TEV1K33AbuuUv1TNchT2WHZe4RMQcSdb0zL5pOK5Zp2M5XAt6e
         bs/eX2UVglZKgI5FEfSaySKbWhfRHkg3TIk2G/grHGilUdo8Q7Eq48y5lPhY4Cl9KVby
         yVRXc5o1IV2ecGx+f0DpsHo8V27WjK9w1igw55HDhTLEBapvYxIl0xe15PzQTAl5hZ3k
         3hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781718007; x=1782322807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4aTYQpCEBfoHlNp/ih1aDYhCnw5Uq36PYKp2Wj/2Xk=;
        b=j1BE9CYRtxuZF3pf7dMF6vnZ9zCs3/akOPK+2BhSZmAVvUGeHFA1Qn0DCf4sekIyC7
         3HDPMM+Vi8aDDKYXqBOx/FQX0AFqOdB6pxlcM/BuX0V03/ITNSdGwiW2sQLJD8ww80n3
         DS+OXfpPXl9SKSpjmJXlS9roy6VUfxNPJz3f6uxKIS7sXAan3h0S3RmQBl1eBpSrbUcR
         b9MthW4mxSusOSNxYwrvi3rAaikxl21aCqroa3HxgEO6WdNS9NLH4UHnZWXVKF1rV4F0
         eGrRxWESG9+HkGrk2rJGNw3GyiHcUws5wRdENrudVM2h37oDR2Thkt0gkxws3tuYBgbd
         WVnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qNV90dL4CR0t8TElxZ5fwPZhLKbYZ+EKa500w35mfhhRwnPMiOna238NZj5miDIOTfsVGAPB+Xp9F@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwN5T8Uf4zZdvwld/1zrikx4fsncmY/lnRhmE+0QwgTXDF4jm
	iUxIh/cAEFJAAQPoIaOWcmmKRG/Iuj0BF+DIJnoOy0+HqYM+G2xxsKHB
X-Gm-Gg: Acq92OHSWvFYHl4d+78XmTU++Fn4v9cDKG/MAYVs2HXZQJsfdD6R1jYNMCkXTGpydZO
	ZL7nmdHASNptkrHkSrCgTZi+pQ1yG6T0mJ+EWfMhi/13/VISy1No3xWr278PzWVoSsOgYvokX2I
	KSjB/0uqOfgzOZR3ZsWZDnA3oEp1mofCt4rPT3vzFXdBuO0+nbUUq14/3okihIC3v/r5IlGDFUZ
	BWxWck5Ul/y/rtSky51oF23JBWJUTd9uz6AZBVWM2GgtwIJEU3OmTTUPZnQ8wUQKzCc/4n3xnPF
	gPoonrIejb8WxurUqByyqQRwuVD812C3zgfSIZvFmXzEa/BXz318MqaNArID4RO974p4iQcD1qB
	C9DH1QnYkCHpoSR18Q/aDktacDFWm6C/JQT2/81lGxf+V/PNl39NBTP/wGpbpeA6ZpcWqon4kQ3
	TlND8e26NE0cVWaOhA6KnG9G+Fa48rhQsYdKTe1O888c6UBbS9/xYqqMCY1OVslwbrFcrEGb5TC
	CP9ynAi4dFE/kxdiQ==
X-Received: by 2002:a05:600c:3e1a:b0:490:e974:e01f with SMTP id 5b1f17b1804b1-492333ecb80mr88065235e9.28.1781718007311;
        Wed, 17 Jun 2026 10:40:07 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49234daafc7sm59819515e9.10.2026.06.17.10.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:40:06 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <0f131ee4-d335-45d2-b6ae-49c18df1353b@gmail.com>
Date: Wed, 17 Jun 2026 18:40:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] RAS: add firmware-first CPER provider
To: Ahmed Tiba <ahmed.tiba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-10-91f725174aa0@arm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-10-91f725174aa0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi again Ahmed,

On 6/17/26 14:54, Ahmed Tiba wrote:
> +config RAS_CPER_ESOURCE
> +	bool "Firmware-first CPER error source block provider"
> +	select GHES_CPER_HELPERS
> +	help
> +	  Enable support for firmware-first Common Platform Error Record
> +	  (CPER) error source block providers. The current in-tree user is
> +	  described by the arm,ras-cper DeviceTree binding. The driver
> +	  reuses the existing GHES CPER helpers so the error processing
> +	  matches the ACPI code paths, but it can be built even when ACPI is
> +	  disabled.

Yep, sure enough, this patch causes a build error when you enable
RAS_CPER_ESOURCE without enabling ACPI:

drivers/firmware/efi/cper-x86.c: In function ‘cper_print_proc_ia’:
drivers/firmware/efi/cper-x86.c:352:21: error: implicit declaration of
function ‘arch_apei_report_x86_error’ [-Wimplicit-function-declaration]
  352 |                     arch_apei_report_x86_error(ctx_info,
proc->lapic_id)) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~

- Julian Braha
