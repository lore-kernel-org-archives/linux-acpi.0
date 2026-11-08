Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134704;
	b=PjeTG4a8GRy6+uyXDMmIuRspROwjuDsqutNBwIEOUViiBvjiPTTDlK9w5yERGu/75ksT
	 lWgqyLfzuaYRjeIgCkyiACDK4dwa0ik69thpcm3yDxLfWi7ZlJ8wVbov/ub2Pqaj/PW6W
	 wi2/q26yEKvBN8mwbK7rJ1yVyQtFQzVIdBNUCsQ9/hhYUI+A4/mKZu1cLlt7r1jVXz1WF
	 q19g44gPBbGulX6xPc/hfjUgeUpBZiqNYu5ZsV1+XHPBobRvSPKXkrsIGAo3wDCgAOWNJ
	 vNB1U1Ry45lM7YNrblUlQqC+k1EXFYaM43OowPFbqY1FaODPS8wDgYEkPuFewvcmGFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134704;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=75sXWuKNu9jGRjV1UQx+6xg4b6ALsGc2/h90lzFQ16Y=;
	b=tIqltQ2j3CBHh6VbHbuL3fi0nu86JDRs1IGeZGdNU0eS1UkJ+8ebjVva4QUwvouWR421
	 lgHaedggtWxOE9Jli0ZFE6xu2mszo7Zd+WKLXzEaFuQWbwm450XkljqjkR2u2RGZTP8kN
	 8pMn2mBP6cFmDuMSlJIhefGdt+8RNtbJs+Swa6+G9isEcz62nP30ildjSl9l/4+FpQlgi
	 N3OaLkmWEGON/yWC1Nbn7fRmF7J8GuunghKEEmvvWlvytGPsxZuT4zOZwodf6L5mfb726
	 iAadNoM+uaztnDrqgVLCy3UgpTJqYuF4Uy6J1f/WyhBwVFpnYWbHM8Lo56sI+VOkxiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hNa4BOpP;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D305606A326
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 10:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D305606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hNa4BOpP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=75sX
	WuKNu9jGRjV1UQx+6xg4b6ALsGc2/h90lzFQ16Y=; b=hNa4BOpPGB3O/q+Rvu7/
	AyPct5/HkE697Jw8LbX+yIEx4jmXqzOvoSWpiFq1gzP+ka6mJVfmkIjpeRLvqmqE
	tB/kBx6ySbi2UubgjrukQcrZsgp8CrT5PQYhUsNb0A4JztVPCwc9doF46EOHl9gA
	aYn+BwQ9Pi8qKtK46yOz1HlfpXUQ4/8AQjnlvV3X/RjyY8wwGTovZ5RqEGzzB6Zq
	C1djflnEG6hW6EVcPL9Z4o3BH+3gO2viCNWJ2L7ayvCDo/b7/ics/uGyTZZ1gswO
	5XQ0gt/iL/LsezI7/sRtSOK/5RHk/jMVN0s2+raH3hiBqAnYH0JNA6U8j9dW/Yve
	5A==
Received: (qmail 2815703 invoked from network); 8 Nov 2026 11:45:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 11:45:00 +0100
X-UD-Smtp-Session: l3s3148p1@MQqBicFf/tFe20rG
Date: Sun, 8 Nov 2026 11:45:00 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarred White <jarredwhite@linux.microsoft.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Message-ID: <avBSrChTZTQL2rNj@shikoro>
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
 <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
 <CAE5sdEi9iOwEmuhzWZ=O5u30UVCbCerckhggBqEY9qU5jBce4A@mail.gmail.com>
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
In-Reply-To: <CAE5sdEi9iOwEmuhzWZ=O5u30UVCbCerckhggBqEY9qU5jBce4A@mail.gmail.com>

Hi Siddharth,

> For Cobalt, the firmware exposes the designware input clock frequency
> through the ACPI HCLK object.
> Is there an existing way to retrieve or configure this clock frequency
> through the ACPI tables, rather than hardcoding it in the driver?

Calling for Andy here for being the designware + ACPI expert.

> Although the frequency is currently constant, it could change in
> future hardware revisions that use the same ACPI HID. Would it make
> sense to retrieve the frequency from firmware instead of relying on a
> fixed value?

Yes, as long at it can be overridden by the driver. I heard of buggy
firmware out there...

Happy hacking,

   Wolfram

