Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416477;
	b=i6RKXFEgUf6wwT6RX7Z/wmgl8Z3CLPAS7rIVk2Y733uMOs3V6BnsOXIQ2AFX7Xv7x2bd
	 TeXyZlPviSNc5CIazDV+MXCGiC/hZa8iksh4451EamWTv4aSmkIgiLI/YdJQrUwIO0LM7
	 ETy3qIQKbqPCHaLj952K+u/uQtNr8kCP6HWGHDcqzGmym9oED2flM08V+4PsDUAzuL6u/
	 1dXoHma9OJ6tFE/mQPUADl2EmQvC+pUZmIbKyrOGvcOZ5GeGHmoRyxTeQPzIKXxiy6MU0
	 kZz+z+dFpY1/CivoPjHfMNI7MDDsm5hK4mc5R1Evkhy8UvieLSWn0JqRpPxiBzchWaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
	b=ZBDeuAQgSwGiSrPGYc5vAt2kB09GIdL0C89JTbX2cvRZ2ySnlgJIU/Lse6gZWTXNIZyv
	 3R3cy0a7ensG+DZ00qj1xwVZBLhKvGle65lG7BcSxBaVFIhqt2jUD/zDCklXw8juEHXL2
	 bA0TgWwu98wfi7OMGtNBaW1HJ9ngmfe7dnaOFZAPN1z2IOZDy85a/C9ILldry1arbUx29
	 7wqgG0lTaAsTtkGpJZp0KMW7bxDRmTq2ZHsva3P+neoT78zCuG8CyrAsVRY+fFupD+wDk
	 fkBzjugNHZiUGdwMvFEq8MFnsUi2NwDi8VEgg0Dv5Gb/1NWjbmRtA+UOvpmmig1zU8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 48ED3606A31F
	for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2026 06:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48ED3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b2382bf051so1408815b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2026 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416475; x=1796021275; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=sui00Ob749YP/4E0URw2ubSzDUQP9KyBjfsmmDw9AzxIDxTYS6M49S1JibeFvPEBVc
         qxmPMlLkjqeHtjjaN7HvIH7fHwsh4z3btvPa519DONCM3a8F31p3NAmeMGSbIBAqhVXw
         5txmr4OBG91xAg91dxl180zBYNgs2sAiXvTgDE7cFJeajijmCEsby493dgeu2NU9qZIe
         AOvHl8i6VREYiO1AJs8bd9Y+u3Wd8mtajSfG6AMj9CMP8bF0uqYgd4Y9TA7w5AXW8uDK
         YQ+QuR6/yknUWT84taqMCfSyX7b6XxC7IIgRv2PGwskSgwLDtlasV+5SLJy7c7g+qSd2
         P3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416476; x=1796021276;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=XW4HpI3K+VK1TgJvN6XK/UX9S/Rq2npj4LrBaemDRl6LvidRZF+D11ELrTT1kdFp9W
         LLOruBxBvFgAjE1nc2SOph7Ib4TrELpy4MYMf2FdFeqqA03Y1lbr8o3KnV1TgG7aJIVB
         BfrHbhrSx3eLYtydUlhLymmndBAmOY64dTh7kc2hQJf1fIa19RVAq34YvqPwmpfdlJcL
         fIckdqIlKSPtkQeS4IFXDA3xwpw5tkWfplfRN6/t5M9U9SygufczJQPQhXEX2lej4HdE
         ucs6Eh6b49dEsVb472LkN6K9BLPXj4WX63IEssPjxPf+W1G3PsEnhww0acwnx6T9jP5A
         bcHw==
X-Forwarded-Encrypted: i=1; AL+hErHq0q2407dR+4JvDJl0EgcWdtKnGIFlSGI/7VX15ychxVDl8UszyJKBnB8SEz9Q6N/qhNgnRWi1XsDv@vger.kernel.org
X-Gm-Message-State: APuU4Z/fuUhZ9y0enSma6+sVJ8ICxSDC1E8rD01SlrDEbtF/ws+R+Xem
	2pWkG5YMHu4KcndMiH6d6tjrWZ/DHNjOCyAtuzD+5SGC7AZ3I0L6U909
X-Gm-Gg: AZFdTZdU6iNYyuq5+eyUaHPjwBGPKr6QIUmaKQSNXz6jutSfNI4IcUF8XfdODRFDShA
	zxyjCoLjNPqz1CCjP+a6N7j9eeMPIVfDibhah0WUcYo3eCwNbVJqhq3F+8D2b7W08iuObeQWn9z
	oaDN3FIpBBD7dpOR8qtlKYjO6UGQ3F7iVcHDyxZ753dLklOz993SZ6sY647KXw4AqVe91er//uF
	bCpzcrSzDryKgn0EbvzbgZXhvm5gZa0MPqdI3mQVoTp6M+pC/31rhrqlp/gxrZZTu2ZR5Q8tbdr
	k/SbnQ+EWmsgqy5p3RT3+FrW1VVi+AcVAOOj4C/kVr/JD5Mvpfn4h/tv5IsLaneYDvQMlnn29E9
	UDX9mLDC1FNFdXKIUWL7KDLfbPZAxHYrQXX0xWsZAja30N+88dhdkoiNnb7zZyXgCD93mXxaafU
	IYJCW1t5dzH5LSUfmCW89OFpkCwaUXPD7Uk/X4QeWSQ6dGGusGsnF/1NB8SkN8cDpLHYId7eT7z
	YaweuFprt8RPcpb1H7+JgPFnzI573HPK1Fy+cLzQKwafc9ahwFS2GBR+mo0MGfdeEWpaxWJvI0a
	vpiPseJxp1sgq8mdcUGHdfu4wjAmeputgkAFxtexW2oNJKnp32+VxxL9FbPNEwjMYP7O1w==
X-Received: by 2002:a05:6a00:2196:b0:878:3538:8f77 with SMTP id d2e1a72fcca58-8c87c6701c8mr9415691b3a.37.1795416475541;
        Sun, 22 Nov 2026 22:47:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077fe3fsm5152686b3a.4.2026.11.22.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:54 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:54 -0800
Message-ID: <5ec374e9acccdbb5422291d106bd9ea9@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data() prototype in writing-clients
In-Reply-To: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com> <auI4Qq1KUo7YYVtG@zenone.zhora.eu> <auo-JCn9VES7OwX5@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andi,

On Tue, Nov 03, 2026 at 12:04:29PM -0800, Dmitry Torokhov wrote:
> On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> > On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > > protocol function table to include the length parameter.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>
> Andi, so will you be picking up the patches affecting drivers/i2c?

Gentle ping on patches 1/8 and 2/8. Will you be applying them to the i2c
tree, or do you expect me to queue them through my tree?

Thanks.

-- 
Dmitry
