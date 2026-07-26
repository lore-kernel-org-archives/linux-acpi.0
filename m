Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E9346A08;
	Sun, 26 Jul 2026 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045450; cv=none; b=OfhdDsIq+Oyn9ALWncke1gJ/DNwmrakGA31QJ1kXgvjzjy3QfivUZcDtSuiZUKs8aG4DFV+kiarxy3x0FRpdiDrLnJQ1Cb8RMS8i7O+4+k4evw3QrZXHMP/PJ9RtCT3MTRl9Nk3huzzbHgIUqwFbNdzOKS6AuBPn8XPIkvREy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045450; c=relaxed/simple;
	bh=NzbVdGmPOJcyV1E7UrYAmKlm9UP8YYmGBfluMt7x97s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A44xBHqN2SpLfI+IAbaQuC5h4Bad39lsd7he+qXWK2f3HwImrthAU4+xXvUQ0YxXUNUud49XH7f26fuGpR/gE/ijDCzbnXzSKz9bD1x1H2Bs2iV5Wh3mXLsMOEyhdZxs1L/pDFu89UFc6MY3LK1zgTAfQn5fb+kgks6EFgyPlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com; spf=pass smtp.mailfrom=younglogic.com; dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b=ua+J4vla; arc=none smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=younglogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b="ua+J4vla"
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ADDF6800F0D;
	Sun, 26 Jul 2026 05:34:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.104.241.241])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6D5AA800DED;
	Sun, 26 Jul 2026 05:34:13 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|adam@younglogic.com
X-MailChannels-Auth-Id: dreamhost
X-Hook-Dime: 1c14df07612e6051_1785044055575_663401031
X-MC-Loop-Signature: 1785044055575:1556903514
X-MC-Ingress-Time: 1785044055575
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.241.241 (trex/8.0.2);
	Sun, 26 Jul 2026 05:34:15 +0000
Received: from [10.0.0.45] (unknown [73.4.247.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: adam@younglogic.com)
	by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4h79QD5TZMz102W;
	Sat, 25 Jul 2026 22:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=younglogic.com;
	s=dreamhost; t=1785044053;
	bh=+VfrQ3cQnL3dLxmIODNPASAhB/6oMcycNU3TdGHoy0s=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=ua+J4vlaNz2Sv6v/CalA/lQ+G/KQSJFybvyJHp+W+GybKyjSRLujGH5HkcqiJNqrX
	 neadwtnJMt1YTXVWga/8O4IGBPap9h02MbWrJLrmTGMeudx+61uVVFVBf2gqNTL/d+
	 sneSB8h+HxdixrOe5MiWyajKyykOyI1W1JJ/q2WB1lO8ebVe5cmhtvJLEoG5WZBJwQ
	 j0tI3B4xN8PCEAbuk0GQ7rzgtRNur9/S2jM3UMa65jbYiQRGqR+sNLYvs2ddGznyWd
	 lQ/P9QZFOA5MVBWHKdwVLP/BeYz537nMdxYtlrX7aX9nkm1+ftIfeOyeK+TFPKUPjn
	 qCCvTdIe5ptFw==
Message-ID: <12ea5f8e-2c05-4499-857a-727e3df1e98f@younglogic.com>
Date: Sun, 26 Jul 2026 01:34:02 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mailbox: pcc: Check shared memory signature on
 request
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Huisong Li <lihuisong@huawei.com>
References: <20260723143928.2625970-1-sudeep.holla@kernel.org>
 <20260723143928.2625970-3-sudeep.holla@kernel.org>
Content-Language: en-US
From: Adam Young <adam@younglogic.com>
In-Reply-To: <20260723143928.2625970-3-sudeep.holla@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/23/26 10:39, Sudeep Holla wrote:
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
>   drivers/mailbox/pcc.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index d96b8b54e77e..8dfa80b0a90f 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -345,6 +345,26 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	return IRQ_HANDLED;
>   }
>   
> +static int pcc_mbox_validate_signature(struct pcc_mbox_chan *pcc_mchan,
> +				       int subspace_id)
> +{
> +	u32 expected_signature = PCC_SIGNATURE | subspace_id;
> +	u32 signature;
> +
> +	if (pcc_mchan->shmem_size < sizeof(signature)) {
> +		pr_err("PCC subspace %d shared memory is too small\n",
> +		       subspace_id);
> +		return -EINVAL;
> +	}
> +
> +	signature = ioread32(pcc_mchan->shmem);
> +	if (signature != expected_signature)
> +		pr_warn("PCC subspace %d invalid signature %#x expected %#x\n",
> +			subspace_id, signature, expected_signature);
> +
> +	return 0;
> +}
> +
>   /**
>    * pcc_mbox_request_channel - PCC clients call this function to
>    *		request a pointer to their PCC subspace, from which they
> @@ -381,14 +401,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	if (!pcc_mchan->shmem)
>   		return ERR_PTR(-ENXIO);
>   
> +	rc = pcc_mbox_validate_signature(pcc_mchan, subspace_id);
> +	if (rc)
> +		goto err_unmap_shmem;
> +
>   	rc = mbox_bind_client(chan, cl);
> -	if (rc) {
> -		iounmap(pcc_mchan->shmem);
> -		pcc_mchan->shmem = NULL;
> -		return ERR_PTR(rc);
> -	}
> +	if (rc)
> +		goto err_unmap_shmem;
>   
>   	return pcc_mchan;
> +
> +err_unmap_shmem:
> +	iounmap(pcc_mchan->shmem);
> +	pcc_mchan->shmem = NULL;
> +	return ERR_PTR(rc);
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>   
Tested_by: Adam Young <admiyo@os.amperecomputing.com>
