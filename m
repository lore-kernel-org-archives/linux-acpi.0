Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0C20ADF8
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588830; cv=none; b=MjkKiTZu6kX1cExJB+/ioIpCkuvvtJ40a++n7+QDy1o5oBbvUKpFl5WiPn7OBDlMnt0+bJHrqNoNrrqiATzIkZ6IxdvflZbP7VFXPhtpXulA86xEzfpUau/Ys0wRAfOPbou0oCF9W5HvA87UgyuGfgwQaanKqgvJEX0dfrB44q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588830; c=relaxed/simple;
	bh=pMPIMLl5FkjuY4U8HXMkZPGSNSU60KDxvMz1SUl9h0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QHLSVOgm8ZQjk53WKl6wHJuNYqbnnTNcS4PeePzvokgDp1LNWrs+kJ6/ff8WCoK+33ZTU9rADGbLFxfAftNDZTVvlgIvtWQOveWDV2RFXBNzuh3zxTw/IezCo7+mdOnZ258ncC5OgkyfjZEAOz3N7cMbXVykPemI0s9PHuGESTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WML0sBqK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WML0sBqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786588821; x=1787193621; i=w_armin@gmx.de;
	bh=dydxW7vbc16pA2lJ0Jk21gapSUaXvb5/T1Eq/Yex7DQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WML0sBqKxq/qNSKZvEAUf8Ayyn4gO5tUy7W4IqBP4XPJpiVUYnpMSpnzvOhD65Hn
	 ff3L4nteC1pM2R7gmES9JsmzGqWAMIWEKyMnQZkAUtv+Mxt0+J+SmRvztF3TnG4rP
	 6UZnDpp6sZVH7DSLJuy8QGLNJ9hxBjDOsNbOgfGnsaYTTZLBhoT/FbKIwQ5UKTJUi
	 JwvPV7lfZJ65y6r8a2UzUy/QP7OAvFYGQYTHdQiumDf2ZS10FcBsWuLcxljbx0a18
	 MK2wcLZCFujV4nSCR8qgBKfM56gk81FyjPVsuOg4GC/g8q9Nhe7CPRg4RYzKU8mXr
	 kSyF8d0JYTWzP7tEJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1xFuD50Usg-00cP8T; Thu, 13
 Aug 2026 04:40:21 +0200
Message-ID: <789d3f8b-8b39-4f68-ba0a-9862f059fe6f@gmx.de>
Date: Thu, 13 Aug 2026 04:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] ACPI BIOS errors - MECHREVO WUJIE15XA laptop (AMD Phoenix3)
To: Bug Report <bugreport@mails.wedevs.org>, linux-acpi@vger.kernel.org
References: <178509941255.717042.12831748341930108468@mails.wedevs.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <178509941255.717042.12831748341930108468@mails.wedevs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KOwWJq7i0Lk4h6+Fm3GZpJyRdDTSMY/TR3qkeWq98DvnkTL/KFw
 OxOG4ByqHW/iqVokwUB/YBslUpIClS/bQg1RWGa4k0Jjiit1spKSn13CEhIeUfuhgVjfDSw
 G9w05Tu3xCdT2GyQS2GrIZRJTGztJwbRipfu3pGAg1p51H/RQqST36JvMvPuUP2eJsNn0LB
 SAWSBFN7/NqXTMKc2VfYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tIiKfjQJ+PE=;nNsbdXx2Cjd/WtdPfxnbBVkAhId
 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
 7raOWqg==

Am 26.07.26 um 22:56 schrieb Bug Report:

> Hi,
>
> On a MECHREVO WUJIE15XA laptop (AMD Phoenix3, BIOS v111), the
> following ACPI errors appear at boot:
>
>    ACPI BIOS Error: Failure creating named object [\_SB.PCI0.GPP6.WLAN._DSM], AE_ALREADY_EXISTS
>    ACPI BIOS Error: Failure creating named object [\_SB.PCI0.GPP6._S0W], AE_ALREADY_EXISTS
>    ACPI BIOS Error: Failure creating named object [\_SB.PCI0.GPP6._PRW], AE_ALREADY_EXISTS
>    ACPI BIOS Error: Failure creating named object [\_SB.PCI0.GPP6.WLAN._S0W], AE_ALREADY_EXISTS
>    ACPI BIOS Error: Could not resolve symbol [^^^^NPCF.ACBT], AE_NOT_FOUND
>    ACPI Error: Aborting method \_SB.PCI0.SBRG.EC0._Q83
>
> The first four are duplicate named objects in the DSDT for the
> WLAN device. The last two affect EC query method _Q83.
>
> Kernel: Linux de 6.12.96+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.96-1 (2026-07-20) x86_64 GNU/Linux
> DMI: MECHREVO WUJIE15XA
> BIOS: American Megatrends International, LLC. v111
>
> Is this a known BIOS bug, or is a kernel workaround possible?
>
> Full dmesg output available on request.

The errors around the query method are harmless, the manufacturer basically forgot to
completely remove the NVIDIA platform controller code.

The rest might cause issues, but AFAIK no kernel workaround is possible. It might also
be that those errors have no real effects, hard to know. Do you have a specific problem
with this device?

Thanks,
Armin Wolf

