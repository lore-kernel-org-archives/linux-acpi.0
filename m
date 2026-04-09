Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D536CDFE
	for <linux-acpi@vger.kernel.org>; Thu,  9 Apr 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746705; cv=none; b=V1i9sY3CSUvSqBQg5PY4tSO9JzBXT/KJ2ejY1ll6j5o0CpIKi++RUsplOvvFfxPGjz3aRvE7ruIjDrH9apwACLSWJx+4ktIBYNbsYLbF1TarRl63bS8YRWzfcu2bTMyz1/uA14JU9DJt/+vO32U74tXKyLkarJXDSbEVqU1Zlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746705; c=relaxed/simple;
	bh=s1buCb8Wa5mXrzFQutQVXTi5jTfX4ZoSdDhXBH8gEx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qVuViJ4U0rqmtwjqtzybYX2kvKy8KNKBNYn9nQgI87cIpKRa7Vcs+1itBpiXDSepKjqZ+mCTQEYvWUPE168bhH+SC41VO6SJl1Iw0iJh/kgo3uewA8OhrDNR8rNYFR6FY25IQPezLjvNvp4pT5s+PzfbJLTVHYaYkNI9IE+pWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qVGBA3BF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qVGBA3BF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775746699; x=1776351499; i=w_armin@gmx.de;
	bh=HvYljqCsr17bGSrDiqIf8MqEkx6O/ANNMPJU6GzjILU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qVGBA3BFZRW0ffDSRFxwoWo7LSmp85W61Z0F3s86MGWaFZOT0We+MX+LSr0I+bny
	 medw7zYiIvV72eMd6TvKSVm9Rv3b5EaFpoODhpgkQONRyqEyUwAnsueFJ3KtxBlUa
	 5M2VeZdbpl8x4F3K03yUfIzH2ysAvxbJ1JGhrarbiIeo/0bR3DZl85GSQaKv5Z6Vj
	 PAAivjBJXjPZnioBeHTLdw1vbQzJFC22/XTAlP6gT7wOdiipJJJ9gfdJ3bCrpK1Ns
	 wSxCiCAstGmcotTObyrdTnEWZPeLqeFQNU4LgbHAwhSE3pf1JHrp1GvvPJ/cor0wL
	 6tzFKFQjOmPUa62Ppw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1vcbPb12po-00gpx6; Thu, 09
 Apr 2026 16:58:19 +0200
Message-ID: <4380e659-c807-43c4-9fe3-97e1403cc8a7@gmx.de>
Date: Thu, 9 Apr 2026 16:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS Vivobook M1502NAQ: ACPI DSDT namespace collision
 (ASMI) causes early boot hang
To: Alexander Zubkov <zubkov318@gmail.com>, linux-acpi@vger.kernel.org
References: <CABXn0zehxT90bNogCu44fRu4ANZmjjrcd8WzX_ms-Bb_JxA2Kw@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CABXn0zehxT90bNogCu44fRu4ANZmjjrcd8WzX_ms-Bb_JxA2Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:umIS7T4PBXT8u8Fvl58OAhx2xAVR0Ka73BId96/ZBgMhd5tX03r
 2dGHqtXPqR+J+0GddRLoxdNjcH3ZJPMff/CajyVa2yVkm9Vng2fjW2UeCoOzBEZ7eOTg4ON
 MEDXxYGM44lq9R8T68ea0w3x573+gbKHi7mGzhLrYvksWylB+4/hCTCoduI5Z90ma6EBdHn
 tYn5ucsHQm8zIWR5wrIxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rv7PowKalF0=;zoIfLb7wsJKN06bZbiQK+Vhh+h7
 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

Am 07.04.26 um 22:53 schrieb Alexander Zubkov:

> Hello,
>
> I'd like to report an ACPI issue on an ASUS Vivobook 15 M1502NAQ-BQ067
> (AMD Ryzen 5 150 - Zen3+ / Rembrandt platform). UEFI version:
> M1502NAQ.302.
>
> Linux kernels (tested with recent mainline live images of Alpine,
> Void, NixOS and Fedora) hang immediately after bootloader when ACPI is
> enabled. No output is produced, even with earlycon/earlyprintk:
> earlycon=efi,keep earlyprintk=efi,keep loglevel=8 ignore_loglevel
> initcall_debug acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
>
> I've tried various ACPI-related options, boot works only with:
> * acpi=off (but system resets with no error several seconds after the
> boot, keyboard does not work)
> * acpi_no_static_ssdt (system boots, keyboard does not work)
>
> Notebook's firmare was upgraded to the latest available version. I've
> also tried to boot a windows installer, just to check it is not a
> hardware issue. It boots normally.
>
> I'm not an expert in ACPI, so I used ChatGPT to lead the debug.
> Although I suppose it misleaded me sometimes, it turned out to be
> useful, because I found a DSDT patch that fixed the issue. Most of
> debugging was done using Alpine's kernel 6.18.21-0-lts.
>
> The issue was traced to a namespace collision in DSDT:
> * Method \ASMI defined in global scope
> * Method _SB.ASMI also defined
>
> ChatGPT presumes that unqualified calls to ASMI appear to resolve
> incorrectly under Linux (ACPICA), leading to a firmware-level failure
> during early ACPI initialization. I dumped ACPI tables from UEFI shell
> and tried different overrides.
>
> The minimal fix I found is renaming the global method in DSDT and its
> single call. After applying this dsdt.aml override, the kernel boots
> well without additional acpi options, does not reset after boot, and
> the keybord initializes and works well. The patch looks like this (and
> I also increased the revision number):
>
> --- a/dsdt.dsl    2026-04-07 18:31:52.727022684 +0200
> +++ b/dsdt.dsl    2026-04-07 21:30:04.393990891 +0200
> @@ -10138,7 +10138,7 @@
>               SMCM = Arg0
>           }
>
> -        Method (ASMI, 1, Serialized)
> +        Method (ASMX, 1, Serialized)
>           {
>               AL_D = Arg0
>               SMCM = 0xD6
> @@ -10151,7 +10151,7 @@
>               DB_2 = Arg1
>               DB_3 = Arg2
>               DB_4 = Arg3
> -            ASMI (0x80)
> +            ASMX (0x80)
>           }
>       }
>
> Is this a known ACPICA behavior difference vs Windows, or should this
> be considered a firmware bug only? I can provide full acpidump / DSDT
> if needed.

This might indeed be a Bug inside ACPICA, please provide the acpidump
so we can inspect the caller of ASMI ().

Thanks,
Armin Wolf

> Thanks,
> Alexander Zubkov
>
