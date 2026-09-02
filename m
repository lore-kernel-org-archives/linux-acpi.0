Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB04A92E4;
	Wed,  2 Sep 2026 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368337; cv=none; b=XL6c+zgP7J9YXZrcYc8R3xhT+SkWiu9AdPrspw4hdfAzoT1cqbkUDdo/SORMZdgOH9p4GCe0SKJoIix+GErVQOYhHYFEoW74n7hI2PS9H4S1etfSYzsqPj2VLIs+qq0lwL4c3gd5sJp2mMZyxSM9IFLcs1u/6weTNwXAwgYWZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368337; c=relaxed/simple;
	bh=p1Pbxxq3TTWf9RfB7AnZZLnwLrE6j/RT+lex+8DuZRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLGE1xxBrEvNvBZw0YzaTnfljau3F2I567EM0E1Uxm6jq6gdkv21vjSoTCkNICHga0nuvqntMHEuDPS4S3Okg7KTlyEvN5lHFSDO8pswlXCZZWMeaFirLStu29r4z4JZnrh5J2WMv6AmyR7kPzr43DyfpfiZWfDVeFzAXlwT2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=L9t+AO++; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="L9t+AO++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788368331; x=1788973131; i=w_armin@gmx.de;
	bh=XdTeL4w9sItZDWxLzNlYAS96zZLVs0/e9yL+LaUwBGM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L9t+AO++PpoRSSiIEWVsL8Lgwt6ekNl5xgDgJjhdKTBMkqZMnoOcxLyp+ty5Ov3M
	 Vc/t53A2crvxeC5nY4CDGab5eXPds0Y9rEVwJtJqJhiFi7SmjTtjSxAHjdZkTc/0i
	 H0U0rWP0hBfODUYNMZw1ypdhoB3OjC5jIcNFTokvDW6oTvzcyU4b8qn9lYDApoPq8
	 k2ExJNtaqouWihk+EBEk1CLTqGEOUsH02jUcXVljUQVSHeJA9jVkKujhoOYBuBojU
	 1znS+8WDABBs3aWKDuz8l6wiYwGpxsEhU31c6ixcA2Ov8U8GQWffRHIs+0UKC5y1B
	 aSB6iwyFlOl6yUwSJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1wQFpN2k3r-00qNLa; Wed, 02
 Sep 2026 18:58:50 +0200
Message-ID: <8c70d6af-8dd7-4ffa-81a9-1cb2c5e54101@gmx.de>
Date: Wed, 2 Sep 2026 18:58:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] platform/wmi: Add aarch64 support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux@weissschuh.net,
 "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
 linux-acpi@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 intel-xe@lists.freedesktop.org
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <59aadf0f-953c-4b7c-8c92-9dd9bc4f89de@gmx.de>
 <46bd3385-4bd8-4a98-8ef3-57c29d00361c@gmx.de>
 <c8445c2e-6799-7856-610c-0742248e1c07@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <c8445c2e-6799-7856-610c-0742248e1c07@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z/gDDHvci+vpk+iACKyBGTnzKq12E5jtYwOptwUOMAqvPwIP1UJ
 b1ic2sNs9tFUN9CWors4BX2gLrNtJRe1McMS1sLXaWc1i2x/h58D4aX1HX2SzLjm0O8BsiE
 xBF5RLnzVmaNyMYbE3OqCHtKN11X8oVuEOGNR+jPessBi6lRN/s2VDdLkbfZA4pGK4m3E5f
 JD5YKjNee8b1Lw6A4g4jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vkpAK/xAqQw=;LyxfOhzgV/cAwI2de8wv79YeLEo
 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
 TnRf6/Z2tD979AACQ==

Am 02.09.26 um 11:27 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 1 Sep 2026, Armin Wolf wrote:
>
>> Am 07.08.26 um 23:03 schrieb Armin Wolf:
>>
>>> Am 24.07.26 um 04:59 schrieb Armin Wolf:
>>>
>>>> The aarch64-laptops project found out that some Windows-on-Arm
>>>> notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
>>>> exactly like on x86. Those devices however are currently not
>>>> supported by the WMI driver core due to only supporting x86.
>>>>
>>>> The first patch removes this restriction and allows the WMI
>>>> driver core to run on all architectures that support ACPI.
>>>> The second patch updates the acpi-video driver to take advantage
>>>> of the improved support for architectures other than x86, and
>>>> the last patch enables the generic WMI BMOF driver to support
>>>> aarch64 as well.
>>>>
>>>> All patches have been tested on a ACPI-based aarch64 VM and
>>>> work just fine.
>>> Any thoughts about this series from the GPU driver people?
>>>
>>> Thanks,
>>> Armin Wolf
>> Can i assume that the silence means "looks fine to me"?
> Hi,
>
> Those subjects may be too generic for the GPU people to realize we're
> waiting for their Acks.
>
> I suggest you send non-ML email (private) with a more descriptive subjec=
t
> to the relevant maintainers asking for them to take look at this series
> (I'd have done that myself later this week but you can do it as well).
> Such an email is more likely to be caught in their radar.

Good point, i will try this.

Thanks,
Armin Wolf

>>>> Armin Wolf (3):
>>>>  =C2=A0=C2=A0 platform/wmi: Remove dependency on CONFIG_X86
>>>>  =C2=A0=C2=A0 ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi=
_ec_supported()
>>>>  =C2=A0=C2=A0 platform/x86: wmi-bmof: Move to generic WMI code
