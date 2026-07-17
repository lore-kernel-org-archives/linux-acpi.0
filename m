Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA693368B5;
	Fri, 17 Jul 2026 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318348; cv=none; b=mUybZ+4FH4TchpKLpp0gZFUGkWIqbQTCUG1MC77Rau/FsQ+6JRyz5fAKvNNbvILtiSCekq/haeIYYrrWMBsPX7YgzeJruTacLGCn/glc1c5NIi7hqamgjQezC9jsnJHM831f0/fJ0jIfXtxVN+R7YWVz9HbWbxkw4xDjQgOWBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318348; c=relaxed/simple;
	bh=DxRzJq8O5wR2SGwrtt4IQS7WBD3k/ROKvWrubQoHgaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI0ble3rPzRZTRG2O46gAVCpQd9+W/1XSDxdvIHOuICdU+TMAgRFxcag8JkfG/utIgm6IWBlPGFpFfsHS0KOXmJQQdkJSDs9m1wgtCoPKtH6e+BPNx+0funSUfk0RdhAO5enplyJDY3qwZm/B3W6D5u7O6P7KWkjyNCEbCtQUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=b5AI5pAC; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="b5AI5pAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784318331; x=1784923131; i=w_armin@gmx.de;
	bh=f1KZ2lsoAn1iTHQIRj9ji4AQGJeOCFjh0vgq4EJY1yU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b5AI5pACkPtyQQNbkRExh8khKvJoOMORZj72T6Mgd4SxGL54Ja/yk8EGanjSnCVX
	 Sx41wE60d2qUVpykLJ7jqe4eF9q5AUxW8v1PTAQgPqTSIh24UtaafpO5Oe7EG/48W
	 RK2FEvbOxMU4UtjgY+eFWxxqPu6mb6T3zYryXZYzsizPGNoHst4IRZEPHmPhraZoZ
	 9i5d7KqGrKT8e01uvscz+IcErBAdnugMKCkxehoErffBCOgGhqDD8oyvXgUjoT9UR
	 EcVg/YWigdTGjo1HtBoOQ+txop8FKUcBcOt39u95MltxLpKYJHw1QRwxV+u/hkdKj
	 7rBdjV7RuCGqNSiivw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1wq69c2W3D-000c6N; Fri, 17
 Jul 2026 21:58:51 +0200
Message-ID: <a45e7c7a-c0cd-4f6e-b48a-15beca4e022a@gmx.de>
Date: Fri, 17 Jul 2026 21:58:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@weissschuh.net, lenb@kernel.org, linux-acpi@vger.kernel.org
References: <20260716234538.1303811-1-W_Armin@gmx.de>
 <20260716234538.1303811-3-W_Armin@gmx.de>
 <CAJZ5v0hUoTRS4fce0=Qn8J=Yf5WtHfbzUw+kyxhhPaRtB2o35A@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0hUoTRS4fce0=Qn8J=Yf5WtHfbzUw+kyxhhPaRtB2o35A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jhJ5MHTZzTQ2MUlSXWy+XYNJoxwXeJM01rpnyJqW9LgoUuaTA91
 k5xtNLpyukncozhKnpzrAwoKmV9/dIgQJTEunIYyX97g6B9EtmpXjvcvdRQp5u0Y4/uk+jd
 Vc3Y2/IAd9SlsR0+EwIruMq6PrjiLZRp6Ynp0a/nvETZhsFz3xtyikKsrBYdQ1avtNwLP97
 9BcagVozkskFrj9+HksLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xRfAbWOghUs=;TzJkp026+qSGnkmXu6wGg5eQZAM
 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

Am 17.07.26 um 11:14 schrieb Rafael J. Wysocki (Intel):

> On Fri, Jul 17, 2026 at 1:45=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> The WMI-ACPI driver now supports architectures other than x86.
>> Remove the CONFIG_X86 handling from video-detect and the associated
>> GPU drivers to simplify the resulting code.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> Or please let me know if you want me to pick up this one.
>
> Thanks!

Hi,

i would prefer if this is being picked up by the platform drivers tree, un=
less
Ilpo says otherwise.

Thanks,
Armin Wolf

>> ---
>>   drivers/acpi/Kconfig               | 2 +-
>>   drivers/acpi/video_detect.c        | 8 --------
>>   drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
>>   drivers/gpu/drm/gma500/Kconfig     | 1 -
>>   drivers/gpu/drm/i915/Kconfig       | 1 -
>>   drivers/gpu/drm/radeon/Kconfig     | 4 +---
>>   drivers/gpu/drm/xe/Kconfig         | 5 ++---
>>   7 files changed, 5 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index f165d14cf61a..cc1e58fa664b 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -224,7 +224,7 @@ config ACPI_VIDEO
>>          tristate "Video"
>>          depends on BACKLIGHT_CLASS_DEVICE
>>          depends on INPUT
>> -       depends on ACPI_WMI || !X86
>> +       depends on ACPI_WMI
>>          select THERMAL
>>          help
>>            This driver implements the ACPI Extensions For Display Adapt=
ers
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 458efa4fe9d4..af9280b244f1 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context=
, void **rv)
>>          return AE_OK;
>>   }
>>
>> -/* This depends on ACPI_WMI which is X86 only */
>> -#ifdef CONFIG_X86
>>   static bool nvidia_wmi_ec_supported(void)
>>   {
>>          struct wmi_brightness_args args =3D {
>> @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
>>           */
>>          return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;
>>   }
>> -#else
>> -static bool nvidia_wmi_ec_supported(void)
>> -{
>> -       return false;
>> -}
>> -#endif
>>
>>   /* Force to use vendor driver when the ACPI device is known to be
>>    * buggy */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/a=
mdgpu/Kconfig
>> index 12e4a41bf1f0..50305630f533 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>>          # ACPI_VIDEO's dependencies must also be selected.
>>          select INPUT if ACPI
>>          select ACPI_VIDEO if ACPI
>> -       # On x86 ACPI_VIDEO also needs ACPI_WMI
>> -       select X86_PLATFORM_DEVICES if ACPI && X86
>> -       select ACPI_WMI if ACPI && X86
>> +       select ACPI_WMI if ACPI
>>          help
>>            Choose this option if you have a recent AMD Radeon graphics =
card.
>>
>> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kc=
onfig
>> index a2acaa699dd5..dc4c56638819 100644
>> --- a/drivers/gpu/drm/gma500/Kconfig
>> +++ b/drivers/gpu/drm/gma500/Kconfig
>> @@ -11,7 +11,6 @@ config DRM_GMA500
>>          select ACPI_VIDEO if ACPI
>>          select BACKLIGHT_CLASS_DEVICE if ACPI
>>          select INPUT if ACPI
>> -       select X86_PLATFORM_DEVICES if ACPI
>>          select ACPI_WMI if ACPI
>>          help
>>            Say yes for an experimental 2D KMS framebuffer driver for th=
e
>> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfi=
g
>> index 5e939004b646..71426b9c91f0 100644
>> --- a/drivers/gpu/drm/i915/Kconfig
>> +++ b/drivers/gpu/drm/i915/Kconfig
>> @@ -28,7 +28,6 @@ config DRM_I915
>>          # but for select to work, need to select ACPI_VIDEO's dependen=
cies, ick
>>          select BACKLIGHT_CLASS_DEVICE if ACPI
>>          select INPUT if ACPI
>> -       select X86_PLATFORM_DEVICES if ACPI
>>          select ACPI_WMI if ACPI
>>          select ACPI_VIDEO if ACPI
>>          select SYNC_FILE
>> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kc=
onfig
>> index c479f0c0dd5c..3cd70aef770e 100644
>> --- a/drivers/gpu/drm/radeon/Kconfig
>> +++ b/drivers/gpu/drm/radeon/Kconfig
>> @@ -25,9 +25,7 @@ config DRM_RADEON
>>          # ACPI_VIDEO's dependencies must also be selected.
>>          select INPUT if ACPI
>>          select ACPI_VIDEO if ACPI
>> -       # On x86 ACPI_VIDEO also needs ACPI_WMI
>> -       select X86_PLATFORM_DEVICES if ACPI && X86
>> -       select ACPI_WMI if ACPI && X86
>> +       select ACPI_WMI if ACPI
>>          help
>>            Choose this option if you have an ATI Radeon graphics card. =
 There
>>            are both PCI and AGP versions.  You don't need to choose thi=
s to
>> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
>> index 4d7dcaff2b91..502c7b3c1f16 100644
>> --- a/drivers/gpu/drm/xe/Kconfig
>> +++ b/drivers/gpu/drm/xe/Kconfig
>> @@ -4,7 +4,6 @@ config DRM_XE
>>          depends on DRM && PCI
>>          depends on KUNIT || !KUNIT
>>          depends on INTEL_VSEC || !INTEL_VSEC
>> -       depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
>>          depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
>>          select INTERVAL_TREE
>>          # we need shmfs for the swappable backing store, and in partic=
ular
>> @@ -29,8 +28,8 @@ config DRM_XE
>>          # but for select to work, need to select ACPI_VIDEO's dependen=
cies, ick
>>          select BACKLIGHT_CLASS_DEVICE if ACPI
>>          select INPUT if ACPI
>> -       select ACPI_VIDEO if X86 && ACPI
>> -       select ACPI_WMI if X86 && ACPI
>> +       select ACPI_VIDEO if ACPI
>> +       select ACPI_WMI if ACPI
>>          select SYNC_FILE
>>          select CRC32
>>          select SND_HDA_I915 if SND_HDA_CORE
>> --
>> 2.39.5
>>
>>
