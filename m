Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBE283FCE;
	Sat, 29 Aug 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788037232; cv=none; b=iyi3GeB4X+fTHzBKEd/V5fQomriHXeVUQDckoQjVRvZT/pxBgL/An9HHTLk6Qy3EwlNe6q2PBvChJEprwgJdquDplaHd4Hs3RNbDjx3HJegjL/Of/0h65BeEmpGIQz8yT/ZfGiPr50/UxavsiqX5yk3AFeUT9VXsW3Oe5+9SFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788037232; c=relaxed/simple;
	bh=VCkpPnNUPIvkk40qthTsbnx9lC/qQhEKxR43QJiFmcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRRZHZNRWzTBgSEv2MuDA4MGDYS0P3/ULCp80JZNif3HdnIXK4P+tgkY6JQFht2B8VEWWn83uNWgyp8fu2Z/hKuIhCzHTRYqBoSnyTuE4VC8q4aOrSrl/2kp0gcM2OuV0v73iFGCQf6AAyG7HCn+433BsXOoFNpNT3M8kz51I00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ENCmBfQ5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ENCmBfQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788037219; x=1788642019; i=w_armin@gmx.de;
	bh=GanOdbVJhedoFeuXitDYb0mLEq+waXgyC+ezU55tIbA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ENCmBfQ5vX0GpSjEwMe/rx9QXbMYBFh4pEKJz5pqNSsLZEmMuJMrT9Rbvz8Lvsqm
	 y5o4ObDNU3O80JAG7UXijClnP4SoksBbQCvIfURLWmC7vkJC8a2bzysP6C7R00sDb
	 j0fAPEoAkd+Q0bW2BQYL8XqRoFU6YizrSCKGt27R0EWcYa+PhARAO30VbT8zxjQfM
	 ggBMMaHr1emaN3kTgKiluNigr+53qQJD3Ct3sP6KicOKycJYlaKtxI8dCZzsXEVq1
	 ZQ9ieWWdJOjPR97Tw+2jvAfjwo5F2EueUIR3Oz7S9Q4nJkYX8/8nEuacSoQeIEGAc
	 fx4LLVNXGh5WZeVgjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1xEOmM0FPB-00TdyN; Sat, 29
 Aug 2026 23:00:19 +0200
Message-ID: <7f790cab-afb5-45b8-86fa-f7ca0ba467bb@gmx.de>
Date: Sat, 29 Aug 2026 23:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ACPI: scan: do not enumerate MSFT8000 as a serial
 bus slave
To: Edward Blair <edward.blair@gmail.com>, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, heikki.krogerus@linux.intel.com,
 mika.westerberg@linux.intel.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20260829145516.13500-1-edward.blair@gmail.com>
 <20260829145516.13500-2-edward.blair@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260829145516.13500-2-edward.blair@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ttHtct5C+BZwT+N/N7iCTLvtE4vnoPnbDv+W9HFYW5EOU5+S7eS
 cS7uwwtAOibk0QLsz1YCjhYQ9+N7yYepyvtNIxxct0/73hjg1iHZqXnfzB1WqpksxwgcCdj
 JnlyYHSSmSEtWt/otxULPPwtQcT1Al0EFWyaa0B4g43fWyuIsXl9dOJyG58c70mjID9zKD5
 DwJsXQc/zHGQXvyvfSaNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:11igCJr+dZs=;DlcPJfNsPjKEvYI3cwLWdqJ9Ggu
 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

Am 29.08.26 um 16:55 schrieb Edward Blair:

> MSFT8000 represents the Windows Resource Hub Proxy. Its SerialBus
> resources describe connections that Windows exposes to userspace rather
> than a physical peripheral attached to a serial bus.
>
> Treat the device like other ACPI nodes which contain SerialBus resources
> without being serial bus slaves. This keeps the ACPI device present while
> preventing the resources from being instantiated as I2C, SPI or serdev
> clients and conflicting with the actual devices.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Suggested-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Edward Blair <edward.blair@gmail.com>
> ---
>   drivers/acpi/scan.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7dcf78419..608527cda 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1770,6 +1770,11 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>   	 * attached to a serial bus at all.
>   	 */
>   		{"MSHW0028", },
> +	/*
> +	 * MSFT8000 is a Windows Resource Hub Proxy device. Its SerialBus
> +	 * resources grant userspace access and do not describe a slave.
> +	 */
> +		{"MSFT8000", },
>   	/*
>   	 * HIDs of device with an UartSerialBusV2 resource for which userspace
>   	 * expects a regular tty cdev to be created (instead of the in kernel
