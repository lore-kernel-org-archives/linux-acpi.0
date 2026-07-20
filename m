Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F3431E6E
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559518; cv=none; b=lJ+vBMdGNhC2c36zN9HHm9vx2cjuQ5jeLGDOSr8N/DbPBNj19XPMNLNjjyN8qpSrHgWtB5DP9/bFUNMi1vtSiU5LSVgR0JVkswlU4w4Xn5MlhXeeYBDJJgLjfR427uLzjn92UUDftR5Mke37FR+0mLWmRPK4hucPFR1vmMHEPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559518; c=relaxed/simple;
	bh=l+BJP2dTlbI6R2M/a/gl69wwhg4/sSj0g/jxUAkKdPo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dOnu7tz6CPjwPj62HIM6LsP97ix2n8RM5R6NhKggQCHs7hyI5BLchCD30I2vYp/lqpcrPLhBO8NxiU4rfRnQLP9JQabFoU47PyiqmBHPIrZ5kx75gi0K0II5FnMUpt9tFM7ZUw0qooW1oa1/lrpj+bgSvighIZECt7dFZuWM3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VxpvFeSO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxpvFeSO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso10861675e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784559515; x=1785164315; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3QcpbpbKJ+LK6Rusjs4UjDCzBYijN9Tg1ogvRHpP9po=;
        b=VxpvFeSO+g5GMjAekTgqpfjInECmI0W8ep7yJe83Id2WxYN/VLvX6KwOkg8/jC2fQT
         hlNcIctgOJ0BaBLPwxPtpAWGf3LkZNVxz8A2M5eg0o85voN45hg9xTGPUX8IKCSlWi04
         9JdgfC7nAzjOGGnl3LZ5d2x9gVrWC94SlC7Vc6EE2QwfexDn2tMfWSXefSCg7D7BDcDg
         sGN8omKQ1iWs3yUWZO7uLeKTD0NOoCyr9t/hwLBDCA1FmCFrkUh5VKdKc1F4NEpjrEFR
         cWJ1//7p2XZoC+r/o+EJG48mDCpjNlnqVdscT200igWUzIWrP+T0eaewnMvNKOz/3pln
         BWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559515; x=1785164315;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QcpbpbKJ+LK6Rusjs4UjDCzBYijN9Tg1ogvRHpP9po=;
        b=SQ1Ps5EYvD/deahWYhVBEZVqqadBWavigvn40ka7egQFPuTf226hJf8iyfomK2+DzM
         GQ2DYZ7PUP4sKA+EoFXgNRCFpEf/m4UaAprza3rPvbI9PJ7oqcEBBBaC+kGki9pbzOnU
         u8YsgiWaTtskinwK3d+tB2mUapQDP++u/Ax50q5uZ5jIESwAIMhf3rcTBdcJVNAoH9YS
         /TVulC1HDDG5kLcQDGEvuLgnZd2VsWYN6CLuRqu6glHqBmjdm75eeKEfFEACDbXj7hU5
         2XI9TGejkYhx9qLVBx9sJMNRt02SBYWHacPmisiNGxGL6q0Pwp/smiVbC5Mk5Yw9kIvs
         mQiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqnW8iifYG82/QH3n39kNFj03KFtuhhAjJsnlmp/BcmmPtZTT1ANPtrvCYWWKnJ0meJihfOy2bEGDt@vger.kernel.org
X-Gm-Message-State: AOJu0YyePmxoSgVEjWyKjHFHGer9dQ786mF1GE6OfqZzsDc4kwLCrw/I
	k2wSRjL6JVIwuctWaNyLneMbvnDEqsea3J4yGhuccxn8gtnqn+DZqARI46bhiQ6ZcRo=
X-Gm-Gg: AfdE7cn4jgAVHxCYkRULOwR7Hc3w8xWl+hp19AP76LU7S5/crCKgU0xeDjGS8WmKVYs
	qME+cpsvvdTXOP+3MbKT8MmTrCdMmXQyx4jHeQUoB5vAgX21IeSFV7HhcF4WCDpboPqoAQzScU3
	LfCe8ZHWR5C7kbhXQuFTILWCPCX+TR234PMfH+L+zSUI1fG/rMTp25iu9wrXAzYWxWIPTf51ww5
	0pUvtkYvFSX7t6OIEHMsrHivhJvn3CweeNal2H0rLOCNn2jeAyq0MTJdQoY2wAoL9TiX3Xuqg6n
	0voRWVy0iKPiSLdpOYt1cReMaGIDxoXzZdmFz4CGFz55vv/qSMeK8BcSEtqVI2zzSvdHARQu/wv
	elYxOJIsSX2jY4JOWn88cV138XRAUSYZV1fWzV3fIQdBki6z5lTVZ0VxG/zgAfAsYZugzoVRDE2
	ngwlBN8VJWphToMle8F2MLweyyu2fto6e7/PT5sPNw7QfedboxfnDE7OJsUr3fQTw/iC+Zov6zr
	hBJQRo=
X-Received: by 2002:a05:600c:1d18:b0:495:515a:dad9 with SMTP id 5b1f17b1804b1-495515adc7fmr115346585e9.37.1784559514625;
        Mon, 20 Jul 2026 07:58:34 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:3573:8c21:531b:8da6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954c841a0dsm244416185e9.5.2026.07.20.07.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 07:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 15:58:33 +0100
Message-Id: <DK3HJUUCG782.2AG5UUZ3TBQ4R@linaro.org>
Cc: "Huisong Li" <lihuisong@huawei.com>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mailbox: pcc: Check shared memory signature on
 request
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Sudeep Holla" <sudeep.holla@kernel.org>, "Jassi Brar"
 <jassisinghbrar@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
 <20260717075649.467172-3-sudeep.holla@kernel.org>
In-Reply-To: <20260717075649.467172-3-sudeep.holla@kernel.org>

On Fri Jul 17, 2026 at 8:56 AM BST, Sudeep Holla wrote:
> ACPI 6.6 Tables 14.9 and 14.12 define the PCC shared memory
> signature as the bitwise OR of 0x50434300 and the PCC subspace ID.
> They also clarify that the signature is populated by the platform and
> verified by OSPM. The signature is at byte offset 0 in the generic,
> extended and reduced PCC shared memory layouts.
>
> Check the signature when a client requests a PCC mailbox channel,
> after mapping shared memory and before binding the mailbox client.
> This keeps the check in the PCC mailbox controller instead of
> duplicating it in individual clients.
>
> Treat a signature mismatch as a warning rather than rejecting the
> channel request. Making this newly added check fatal could break
> existing systems whose firmware did not populate the signature
> correctly even though PCC communication works. Continue to reject
> shared memory that is too small to contain a signature because it
> cannot be inspected safely.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>  drivers/mailbox/pcc.c | 36 +++++++++++++++++++++++++++++++-----

[..]

> +static int pcc_mbox_validate_signature(struct pcc_mbox_chan *pcc_mchan,
> +				       int subspace_id)
> +{
> +	u32 expected_signature =3D PCC_SIGNATURE | subspace_id;
> +	u32 signature;
> +
> +	if (pcc_mchan->shmem_size < sizeof(signature)) {
> +		pr_err("PCC subspace %d shared memory is too small\n",
> +		       subspace_id);
> +		return -EINVAL;
> +	}
> +
> +	signature =3D ioread32(pcc_mchan->shmem);
> +	if (signature !=3D expected_signature)
> +		pr_warn("PCC subspace %d invalid signature %#x expected %#x\n",
> +			subspace_id, signature, expected_signature);

IIRC signature comes from table, so I'd even add smth like
"Potentially broken firmware: PCC subspace %d invalid signature %#x expecte=
d %#x\n"
or "PCC subspace %d invalid signature %#x expected %#x, broken firmware\n" =
or
similar to encourage reader/consumer of the message to report bugs to
firmware provider :)
Maybe it will be even fixed.

Anyhow, regardless of above:

Reviewed-by: Alexey Klimov <alexey.klimov@linaro.org>

Best regards,
Alexey
