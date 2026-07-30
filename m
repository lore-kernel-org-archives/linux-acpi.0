Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055153B636C;
	Thu, 30 Jul 2026 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434956; cv=none; b=GZ7ObdA7gRuoUNHz5oJXK/kq/sUCEdEDJfOqWTFQJlD76RE/C8JnwmxVlyrhrw0Qsp4ZbryNHzK6yDx8/d9lgTp3AWTrUTLr1ApKq51bIou6DfV4HQwUZixrj6Ddehf/VLqZRHthw0vYNOfvhtBAWfaqZphSuHf1Mm+BbRGpHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434956; c=relaxed/simple;
	bh=5GFqADQNJYsR3YSiJt8LRzE8FjPZYkSpw328DjcwprI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S3QIGeZUPC46gzBrI623g/o6PFG22RZInY6EviIbm6zCyrKea6s6z7PAaaxZToAE9TQrFHQ8egMnPXAQnngawvXg+vglslwsNsiUdHFZT/hjtTE/iSNhF7fU7YQEL75R90Ojs7JUb4hUSrDztv5SRNS4mF+1K/PlCAjMOBcvzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=cyberfix@gmx.net header.b=svdm+y5N; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=cyberfix@gmx.net header.b="svdm+y5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1785434925; x=1786039725; i=cyberfix@gmx.net;
	bh=8Y6ZWToGPUOKtKvkjXnF0YIIpgFNJbXtFb8dUjRFgLY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=svdm+y5NivC+Kafu/QBTYq3XpwvmdRkCqEHcZN105q5Z8ElIOwF7VY+kXhHZ8AM2
	 v62KXZSb6jgKOoYLqZLhvZvwGGyW83kWn859mIwShLNu5qxQ/vRD3I1F2GPyRSvWl
	 GvSohoKTcepq3pyXZ2m4+4ypqdKozxTO07Djgh/fiGoKocHCOuT+luaY17rPzP7GF
	 V1NSwbkWKir8zdHYdTmY8t/quk3KLZDKYhGj2A+jxMm2JvkgfPwR8flCgqvt7CYMi
	 KAubRIVM0h0nvzFRUlMkh1+2zTeRwrylRRIa08eYVVm9axBTdKAKRw5jF8quG3EkQ
	 5sf/iRw3LTnUy0zBqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1x726P1k4O-00tnzs; Thu, 30
 Jul 2026 20:08:45 +0200
Message-ID: <204bfdd7-04c7-4fa7-8626-0fe5f5c0e757@gmx.net>
Date: Thu, 30 Jul 2026 20:08:43 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas <cyberfix@gmx.net>
Subject: Re: [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec driver for
 Lenovo Legion
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Marco Giunta <marco_giunta@outlook.it>, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, wangweidong.a@awinic.com,
 nadim@symbolic.software, imitoy@imitoy.top, munzirtaha@gmail.com,
 yakov.till@gmail.com
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
 <06572961-d2c6-4de5-9102-2b5fc6d5ef5d@sirena.org.uk>
 <87se548s81.wl-tiwai@suse.de>
Content-Language: en-US
In-Reply-To: <87se548s81.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EpydfUhF2CLCAgLCEiRnMCcE+KJSu1AH7oxpnNrzUhOC75jEKzn
 Od1sf+f3KXlp7v/DODwVDcsLeJat+UGpoUH4Uo1+juhNVJzS2os1ZYJInPZ8uyeVh+cpNHA
 usmIKvyEdM3N9+kZvG/IwbhW3UtRQGXxuP52ik8olIbkbWummIHPbaEplWD5f9jkI7xF9cn
 hm1AczJgcJMNBCi/fttAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4XO7f8Adzdo=;Cc8wU8eEN+ENwn1f3Uv1AY51+d4
 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
 AaYrDLPfZtFXexUJ4N0XLGGAw==


Hi,

I found an additional Lenovo system that requires the existing
|ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN|quirk.

*System:*

  * Product: Lenovo Legion 7 16AGP11
  * Machine Type: 83Q8
  * Codec: Realtek ALC287
  * Codec Subsystem ID: 17aa:3956

*Problem:*

The internal tweeters follow the master volume correctly, but the bass
speakers (woofers) remain almost at full volume even at very low volume
settings (e.g. 5%).

This matches the behavior that the
|ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN|fixup was introduced to correct
on other Lenovo systems.

Without the fixup:

  * Tweeters are volume-controlled correctly.
  * Woofers are already loud at very low volume settings.

With

|options snd-hda-intel model=3D,,alc287-yoga9-bass-spk-pin|

the problem disappears completely:

  * Tweeters and woofers track the volume control together.
  * Bass volume scales correctly across the complete volume range.

The system contains multiple HDA controllers, therefore the model
parameter must be applied to the third controller (|,,|).

It looks like adding the following quirk is sufficient:

|diff --git a/sound/hda/codecs/realtek/alc269.c=20
b/sound/hda/codecs/realtek/alc269.c @@ + HDA_CODEC_QUIRK(0x17aa, 0x3956,=
=20
+ "Lenovo Legion 7 16AGP11", + ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),|

For reference:

|Codec: Realtek ALC287 Subsystem Id: 0x17aa3956 DMI Product: Legion 7=20
16AGP11 Machine Type: 83Q8 Kernel: 7.1.3 Distribution: Debian sid|

I have verified that the existing fixup completely resolves the speaker
volume issue on this machine.

Tested-by: Tom cyberfix@gmx.net

Thanks,
Tom


On 7/27/26 15:41, Takashi Iwai wrote:
> On Mon, 27 Jul 2026 13:57:06 +0200,
> Mark Brown wrote:
>> On Fri, Jul 17, 2026 at 03:25:02PM +0200, Marco Giunta wrote:
>>> Several Lenovo Legion laptops (Pro 7i 16IAX10H, Y9000P IAX10,
>>> Pro 7 16AFR10H, R9000P ADR10) use AWINIC AW88399 smart amplifiers
>>> to drive their bass woofers, connected via I2C as side codecs
>>> to a Realtek ALC287 HDA codec.
>> The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3=
989f:
>>
>>    Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git ta=
gs/asoc-aw88339-lib
>>
>> for you to fetch changes up to 15c9fdb3c39d5073463ffa746cc64ad9682c875f=
:
>>
>>    ASoC: aw88399: add channel setter for HDA side codec (2026-07-21 19:=
16:08 +0100)
>>
>> ----------------------------------------------------------------
>> ASoC: Add AW88399 HDA side codec driver for Lenovo Legion
>>
>> In order to support AW88399 HDA side codec used on the Lenovo Legion we
>> need updates to it's ASoC driver.
> Pulled to for-next branch now.  Thanks.
>
>
> Takashi



