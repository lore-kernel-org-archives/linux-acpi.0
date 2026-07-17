Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336D3909A5;
	Fri, 17 Jul 2026 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329334; cv=none; b=pCNvKIchrDhUBfH/rO+gXAbi+6Knkc8FG5OKB7TKLIt3goswsBvGwdFRs0F2LiDSorbYVmZriuqWDap7HiS/lvV3NzW519xkm2COtbgBxMPvqK7RucmA+oNsBQhhYa808TwT0rRd4wG2Zm7jUS+z+fgWUoDvUTz090wKUnP4Tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329334; c=relaxed/simple;
	bh=vZQ8ObrippS0VQxWdZPj197rMs8vWZq/DTsa6utDUNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI6lq914b6r/FNHQAtgAPcCuuGdPHXlIWIyLaDrXXE4Jktlxnhu6lag8NHfVKEJR8P/YeoKH5wJYgNkvWRkjmRwjqOND5hfj2/YhOW14YSCmIIohUT+0NyHyuUjfBNTwPQ5sqIttTkOh5DlC+PLU6Eo5HIDfYpmNA3Ihe3BYiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FKBunS/t; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FKBunS/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784329319; x=1784934119; i=w_armin@gmx.de;
	bh=kkp6vJ9Ps4tU+ghGQDuSP48hO12KifhMzEEuFjNy6jE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FKBunS/tWkVmRGDk9y4czt39SKZRdxfRTWMW0aZt/Lr3kTbqvTX0JBxGgKaJ9Iy0
	 ZKmqO2pIZU1Y01YCDMF0tCwUhzlXaHOk42BhLg5Y1iBPI8DiTAmz6NreRmVWe1DL8
	 /tejxTpdNKPSQMAzeM3x7Un2MZVcICCqYK3GrEsp1d5PbVLH+4jHCGs0uk8Mch/yV
	 npcv/AZUVxO7Q6FrvHwCgY1dQPwVLLrC7lUFQuJqwZiHE9q1fxuZgDBLlfXpONlkt
	 sAWgR9vLeOJra3cBzdEscvFwob5/WBKAnw9E5fsf3xSoda/XWChDAGm1+vcl21kxj
	 IJZYnTNe4G6elNuzMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1x4HKG3LmV-013z8p; Sat, 18
 Jul 2026 01:01:59 +0200
Message-ID: <f017b09c-e82d-4523-8c45-22bee90c79fd@gmx.de>
Date: Sat, 18 Jul 2026 01:01:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] ACPI: fan: Ad-hoc cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZxdIVPN7F0PtT23B4dxuG4K9UY/leeynJYAbV8hicFPJGpsjGcR
 fCVhsJ8iOP9fTbAUJI7HVkZkB8e63kYTle3y4x2XXAm0JUR6Wz6lAUmhNCmoCgkfGnMY/CK
 ikE9P2OZLmHkeKibwoBcZ/hiogChnwG26Q+usezpXmv6/uMnIBuaExegVaRU+NyC+EU7Zpb
 7aSRlIYJ+agctLR/dEu8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7wK5iGHIbxs=;BcPhBJCKv9pAcAQYLO1I/WJ6L/l
 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

Am 17.07.26 um 19:08 schrieb Andy Shevchenko:

> The main purpose of my work is to clean up always included linux/kconfig.h.
> But there is room to improve the drivers/acpi/fan.h. Hence this small series.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Andy Shevchenko (2):
>    ACPI: fan: Don't use "proxy" headers
>    ACPI: fan: Update ACPI fan IDs to follow modern style
>
>   drivers/acpi/fan.h | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
>
