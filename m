Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134488;
	b=36ehV4It0vlRSaa3gRCqFwQ8AgLEwsrc4XhwF1WyICZ77WYnFLqvNb1hGLBezaPDba73
	 uWQzrVlEJtZaD99hMEgpVfLRyAeXyxxHAztAl881wuYzAe9ASkku++AOM2LENVgdICf0Y
	 60wr7m+vgYZh1dhgeLFDgskt9NwYZHOYGo6BA2ud8dzpyLY/SAOMa3Q2F3DlqWDj2/++R
	 qshwHMc2foWpL4YChfYeAkYO8thwp6mzOoaPKO2do1+LwMtNjtrYFOsX8PIevEKoS0asf
	 NirrXjCEMi7lfY7VanvWKBvkFQomXB7vp5yO4hTiSRBRvEALeqbnGYoDnWzU2XGkdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134488;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=buOLHq3aXEaLOdh+jel+eyDIOFFbNtd2Ddp+pAzex4s=;
	b=uhUVOPtWfByqiy2BvHCbi3I7uULOKXo/RAmcj6pnwWGnsIjKEi/J2eRkoxXV8CEpcW5y
	 8Bjj/VW8gJY900/9GYAtEEJVtc1if+2xidrWSBRAOh45NaihVLmhBKNUJVUO/sY+Au9Gj
	 fW5Sd/XAjDkYWYjnz9Y3gAs9Mop1D6lav1Jz0OSfsYc7u9WeLN7VPgpEk8gk40gvKD4Q0
	 7U6KIyJ4co8hVXtlo0jfCp5ryKnl+5eS2CQ+VXL8ofT2IsuotOshf0zC6upj6Xp+dmRjr
	 kxIqekgqqpbCE8jCCHt5H7pLrbL2+LFufFKlBXDcqQzmmBVFs3cyhGrq+hToDTdjPfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AjmhaE8m;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927D606A320
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 10:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0927D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AjmhaE8m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=buOL
	Hq3aXEaLOdh+jel+eyDIOFFbNtd2Ddp+pAzex4s=; b=AjmhaE8mMo1wy2A4v7bW
	o/5uLxur08eTQ/lz9R4g4HKOOOrU1/rqf7skAcOURcDDFRQFwvW231UUyiGjaR/E
	yto6eCJLBQaVH23kFdvAQbpfNF5aynjJaHV9kONy2EUg7BAeZJhJJqdHkmzmW9zk
	iPBD/5TxNaDTObWJOOufKzPq7KVne+MYZEf+TSn+EHQgZSlyfvhOHacOXA0sffx6
	wFmPMPHw4yT7Ej8girrWKnPIqtcjlg7Brkn12YZJdeXv92vouEMNjID9afM5C+74
	DWPw6GkvsegzI9IEBwvl9dadgad/U9gKXnqw+MaCqoMwyHFkyWLmK/oAHsGhB+Jz
	FQ==
Received: (qmail 2814864 invoked from network); 8 Nov 2026 11:41:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 11:41:24 +0100
X-UD-Smtp-Session: l3s3148p1@hd2afMFfjpte20rG
Date: Sun, 8 Nov 2026 11:41:23 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Jarred White <jarredwhite@linux.microsoft.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Allen Pais <apais@microsoft.com>,
	"rlmenge@gmail.com" <rlmenge@gmail.com>,
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
Message-ID: <avBR0xxt0dvGb9_a@shikoro>
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
 <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
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
In-Reply-To: <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>


> Do I have to respin the patch?

Yes, please.

