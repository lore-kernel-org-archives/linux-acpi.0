Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736275;
	b=m0I2rwcvG/AMhwWa+4JeZ6UIpNk5gP9XwA5zUklCZ4npvYJ7zA7uODNhb4a3BnI/dwYq
	 AyC8ck2mmALiYsQPv0smxyN80WczDZLzwBeiraS21MI/6GSL41X44wHtVaJCua1dbeBtO
	 wf1webMWrwwVREcWQGzmWgeduDg3Y4bnVoTmO5w/plbPfosCOT0MYaYt+0G4hgK4qV2iR
	 /89Qhh4er06EQSGch+FgO9XgMYIZof7KV+myv6b1owfigEQKMwPhl528itgGdBrfPpIYr
	 qvM/wbsvK6QuaB2mzHHQGtdtUTCovFkoGbK0SfiKGV7uz7iLPfpDHdG4bwf4MBTl6Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
	b=ErjuZsUPBcWyP7wDwmQicT+LNTIyQxndxc6ZKe7Z6/82HyWR9IBWFN4Gtu4ouTPHyMLD
	 SaiThIWdoXz9YMfQDbhS8hD6U84VNCpH06CHKT2zf7S1+d0cD3bFRJnBFeXntn+l9Lps6
	 bAjXdvv7XjkGHoJZN/82C/PD/dFq1SyodQi8DVgaoSGDcLvPPDLkWtDmWuxHjeXqAT4cw
	 TQH+hHcH8K1m7WLN4PbQrpkndGh5viUGK3KsGrsyxadLd18mwYEv61GqkebZZJQ7ADUHZ
	 QNGH/gDet8noiHmRGjXsE5UPV9aXwF6+ZlrhM1qhhLLj6G3TJZWC99SmxQUlbmd35QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EAB606A332
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 20:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EAB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35b2c599f43so8212905eec.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793736274; x=1794341074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=MY3vc6Gbvvfq42ubgxn7ZiALrft/xLB+7RdNtGFpyhdTAWULvE/ASxqtUVijeZaLAG
         pFKwTl7Old40mDX8hTr504VOvLwRmf6WVo0XKxWHImHyLsyuvO5cI1YC7tyUOb9E2Ov4
         ZupY/VOPLYTmU/TSmjc5sIO5R0nqbRrhc3gWtc1PAW4PGvUZRAa5TTXXr/Ol/wguGV04
         /NyrkwL8H+JcKuFKPUwQu2sHRwhVoxKd3+a7lgDpWBVwlzlTOj+u8qnjv3odQL7LHfl6
         id4GY7sKuMug1ts1LrY+1VLRHv5zI9HugBWlvGhAGFXapCIpnKpd9Sz4vKeVcJt7nGUP
         lk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736274; x=1794341074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=dcogmU0KfHqJdkmLljoCS0eTdM4p10xllclDnUukXALHG3WK0n4cI+xKAl2HM3198H
         PevDPnxmRKvaglCODq6PQ2a/i+qLzElazW3MgWvxxzjaHqE6U9z3fJWMKFMx9j+m3BAM
         wxJ5kH3Yqy0DBLnOUFhGE+gKcAHmJNNezhvsmOY7X77LGy3gT/a9lwOc5hEuLWB+4Krz
         WXfyMEyLh5Z1kNNfyqgJpQQNXkJcBS6hJwBAtF2UXPMuI+N0ioE2WR+BC8fCCUNjmQaC
         H6sZwTNfBfiploPQ/t63wMY6JLWx28CEOBawcVT9Y73fEdgi5F9cFVAAq2WeDNd97IGq
         uOdQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6U85+y49drpSEj1yjKYGPWwGzvBTqPtzadYAYA4lWzYy9RCrTRbWn/8QxOiSKG/2yL2OcTITXa145@vger.kernel.org
X-Gm-Message-State: APuU4Z9r5Rf7yUHA9kvQIEkl84+F2mys6i/bMndkAjNFJs6bBkizjmnP
	IOUZOzuJWkeQUg4boejNPNhpFFHtr4m0lZ7mggsNtOX8DwWDyLvTNVSw
X-Gm-Gg: AYBFou27hwSP3B4JMpxLzXzy/rD6ZFl1epApAFB5XnAA0YaR/Wej7m8TzMOXzgRHfzT
	drJbveQfoO6SmOkLBneGd6JUjwCqZr2OfTCsQDWvUZ+THvVW48H03rkkOFq0fHWCfbmO1SoMSt6
	Lsc45Vr5PhRTJWrz/LFwCbQ3aBYo113LQCTx61nEwUTlGqUmC6vjSr3eYmBbFW3XxlxqwJDo9uk
	0Uts7cSlJuhulAFSdV9RrtCJxX/wIrQ89UMnaR7nWeg1EHzfugPR30JU9SsaEVCxxQCEYKCK6GY
	BOWemqvMVhE7E8/4inE20OTE2cFpdPvC0lqnc7TnFzlii3lxeqtwgufG3t6ZrhODr9iE1kluPOd
	Z9n0yT0gYzInHiCZMsgBRBoq74ecORZDzKVqHxklWdLSt/GdMONDjXogY8SnQaf8TDrOsa/YImK
	TspHqcCptdgpo3O/xNv6I8FmCWNF2QpOTCIQ7V1c/8EjNKjKK1T/YOXfg9YGZwfTSzX99le4s0V
	gTjYK9r8dnUdQY7FFZ3vKwX9SrHx8TJGHgIJqPUC3b1bv4MSeiqVVKOZ3kVQume9hMreqlUpgRu
	3/acgoVdaCvkNBkaMa9i5mVOxc+h+5hqzerRH2UXJXAfKv1WVGZz7X1I7y6dHx72ZCDK
X-Received: by 2002:a05:7300:824b:b0:36a:1c75:8ca3 with SMTP id 5a478bee46e88-36a4221b3b9mr19658147eec.1.1793736274072;
        Tue, 03 Nov 2026 12:04:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm368905eec.9.2026.11.03.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:04:33 -0800 (PST)
Date: Tue, 3 Nov 2026 12:04:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Corey Minyard <corey@minyard.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
Message-ID: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
 <auI4Qq1KUo7YYVtG@zenone.zhora.eu>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auI4Qq1KUo7YYVtG@zenone.zhora.eu>

On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> Hi Dmitry,
> 
> On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > protocol function table to include the length parameter.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi, so will you be picking up the patches affecting drivers/i2c?

Thanks.

-- 
Dmitry
