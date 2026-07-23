Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60747A87A;
	Thu, 23 Jul 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821638; cv=none; b=AEjEVAbTwOlWR70e78f1lrcDm3d0oN+Uxl0aPusZbTQYqnxhssRpP2gG0V/8R7td/1q2bIasThjR97oq8fkw+32J2LxQvfobfTGMzAqOXrScDk1CfQz10qvBBskmCkJBMsKsFHVjWtkc5mYSt189G4YsBKWUatYRRoyFX12KUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821638; c=relaxed/simple;
	bh=TwbSIvH0/+GL3dDw8noOzAmzl5bt62XomrsEbBsOYiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oi1ZHO2d+DXOrtoOaG1KoWBAbrM/DofS7BgHOVmDURC40jU74B81FyqGCeJDzlGdCb13ic/LiYcX8SvpgCEDRI+9uQlMxl/fKkVhoLrEkQckd6MtPOE2b8SlAzvOP43m6MjxFtsnp3riu4yo/5czY7AS7+DwYULDTyyqPos6VFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com; spf=pass smtp.mailfrom=younglogic.com; dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b=CCaYcVTQ; arc=none smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=younglogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b="CCaYcVTQ"
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E7879624F5;
	Thu, 23 Jul 2026 15:47:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-103-105-133.trex-nlb.outbound.svc.cluster.local [100.103.105.133])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 758A1606C2;
	Thu, 23 Jul 2026 15:47:05 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|adam@younglogic.com
X-MailChannels-Auth-Id: dreamhost
X-Quick-Obese: 41508c4467c743f7_1784821625743_3878479006
X-MC-Loop-Signature: 1784821625743:2888359346
X-MC-Ingress-Time: 1784821625743
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.105.133 (trex/8.0.2);
	Thu, 23 Jul 2026 15:47:05 +0000
Received: from [10.41.33.250] (unknown [150.195.203.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: adam@younglogic.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4h5b8m3fzwz1RM;
	Thu, 23 Jul 2026 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=younglogic.com;
	s=dreamhost; t=1784821625;
	bh=76hxiLWIU25rlfuIVGeyAULn6CNkZMFDrPVf3xTEBDQ=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=CCaYcVTQ+CvkMuhUA+eKpq9zO1tl3PyIbLOBkPCB8ZXx4sPOViQHPD5qVvn1yuBjr
	 6Hzg/vTk7fE88pSbDVkshfXz9ZiKh47sDJiatKxuuVKw/vTSBuffnCJLmXJgBQbgQB
	 FzLqd1vEvUpb9Ydq7ccky83zHKC6LyTj8D5TRWWtULSZpMvDv9xjwBx9/HmK+F1vmP
	 eYs+9BFstkg733nkpRIf1dg8d2ltMXGVdt02joZtXOaPCQorSyP33Tr9mTrLiA3YDb
	 x4jbk/Wf6jyXK78+aEF2XzPUJ4xApDjHN8NSlZJj6u/gWrfQH1jwdPiZdVeTMP9wMo
	 CXuJZ09dB5rqg==
Message-ID: <204e42fd-4b2b-4f01-831e-1e9a05b857d0@younglogic.com>
Date: Thu, 23 Jul 2026 11:47:03 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mailbox: pcc: Check shared memory signature on
 request
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Huisong Li <lihuisong@huawei.com>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
 <20260717075649.467172-3-sudeep.holla@kernel.org>
Content-Language: en-US
From: Adam Young <adam@younglogic.com>
In-Reply-To: <20260717075649.467172-3-sudeep.holla@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/17/26 03:56, Sudeep Holla wrote:
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


Tested-by: Adam Young <admiyo@os.amperecomputing.com>



