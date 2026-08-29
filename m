Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D052222AC;
	Sat, 29 Aug 2026 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999848; cv=none; b=qESwf4UwgU5E6/hj2QBEbqenY7oN37RPyxKiZPextrg5IZ5iwx+tdo7u+bpE4VyNFjNmVT0vNlyPjWFLr9JHwL/IF8r50Bk6ZN2sHUR8vejiZvK11FccWqXJ6D4eWI8qRH4SWebl6OQMQOHieA2bdXBgYtxum5n+1wEmGdmdXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999848; c=relaxed/simple;
	bh=Z1ZncQYrW9ZxFEcayTP9H+oXMK/SXskmGu9ZZYanT5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqB2ddtEBUBVkfnqvPnvc+inU39GtotPMoYmk4YO6Cbl/dxtnTTuK8dt4dcblXT2CJw60g62qlTkg2+X6Gf4/L9YxR3yAOrIWywoxEL1la6crxPVkPdDfBtYtAs9hKrg2Nx8TSp3zSrs34WTCYBRItDOv1T7MIdLCpCc2rToxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Evo1+4Ua; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Evo1+4Ua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787999843; x=1788604643; i=w_armin@gmx.de;
	bh=IaM8n/cF4I0Par05izxtxi84mXnPSLj4ugiR91Omkbw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Evo1+4UawWpN7Q85OlpQyQNtDgNTCCRl1NBiOmsNJr6xSXv3/AwcgHDoPV6H6pYX
	 PzBMXuEzsG9Eso073aECeX2dD6t4vFqDuGg77ZSt/7QHW8EYF82ofwWrsGOHtk9CZ
	 hLessgwBjKUtOiR1MSHWjxbxQLDfYqMLMaBmLUkHgcYMD4V7YlBmrH/C8Sswfu5YW
	 y5YQf9y0HfmUzI7NM0HTNXrgmkBUrqmh0h4GD3Da2w2sLJFxUfn5e9XxRWpdC65T2
	 67ElyvOe2ntKe4Riy4BVk8DNVNMYO7vToWzbPwxZv5gXHnkOqLS3YQ4T5hKVLfzM2
	 Okr4pwCbqm/dztj8kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTmO-1xMp5p35EM-00TwOo; Sat, 29
 Aug 2026 12:37:23 +0200
Message-ID: <d8e7d9c3-7340-4765-8a1b-7ee5b4a0f932@gmx.de>
Date: Sat, 29 Aug 2026 12:37:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add UCSI I2C transport driver for ITE885x USB-C
 controllers
To: Edward Blair <edward.blair@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, rafael@kernel.org,
 lenb@kernel.org, heikki.krogerus@linux.intel.com,
 mika.westerberg@linux.intel.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20260825201426.47030-1-edward.blair@gmail.com>
 <ca37dbf2-0949-401b-a1bc-c714a1c451e0@gmx.de>
 <CAJDQNggKFhJ=YKanKWmG_hRi98nRi-8Wa19D7mqU1MuM2dF=vQ@mail.gmail.com>
 <CAJDQNgiYYQW1N94cTSD-Naph9h44OXZpsZVySi=7sgpcQ21yYQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJDQNgiYYQW1N94cTSD-Naph9h44OXZpsZVySi=7sgpcQ21yYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yxTSkiz13fbxsLwhKqlqjCXR/JW58+uSore4n81fRY+uflrSFUU
 ZBY9gL4W1BpLOxu1UXpjHmGSxgl0EyVK9dbf4/YG6F0dtgcp1IRfoc+ppV2ROOEmAWEdrDP
 csvqbecq0rs5FlHXan9tbKwZqn0c7VZI3vNrFEDVsrTsDyiGxUVcVKEQv+3p0jRbpAV4+wj
 x1ueWamVAqJbe2mUUJvsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q9KSQmziI3Y=;4VG5iuWV/8uP849/OJJ9alOuHy5
 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
 OBig550TXimoCv3BX5yxQ0foRtVgwO7E

Am 28.08.26 um 03:04 schrieb Edward Blair:

> Let's try that again.. without gmail's html...
>
> Thanks, that makes sense. I can rework patch 1 to add MSFT8000 to
> ignore_serial_bus_ids[] in acpi_device_enumeration_by_parent(). This
> keeps the ACPI device present while preventing its SerialBus resources
> from being instantiated as bus clients.
>
> If that sounds reasonable, it seems like a good middle ground between
> v1 and v2: it preserves v1's enumeration behaviour while handling the
> device generically in the ACPI core, without the ITE-specific x86
> status override added in v2.
>
> Thanks,
> Edward

Sound reasonable to me, just add a small comment explaining why MSFT8000
had to be added to that list.

Thanks,
Armin Wolf

>
> On Fri, 28 Aug 2026 at 01:58, Edward Blair <edward.blair@gmail.com> wrote:
>> Thanks, that makes sense. I can rework patch 1 to add MSFT8000 to ignore_serial_bus_ids[] in acpi_device_enumeration_by_parent(). This keeps the ACPI device present while preventing its SerialBus resources from being instantiated as bus clients.
>>
>> If that sounds reasonable, it seems like a good middle ground between v1 and v2: it preserves v1's enumeration behaviour while handling the device generically in the ACPI core, without the ITE-specific x86 status override added in v2.
>>
>> Thanks,
>> Edward
>>
>> On Thu, 27 Aug 2026 at 23:30, Armin Wolf <W_Armin@gmx.de> wrote:
>>> Am 25.08.26 um 22:14 schrieb Edward Blair:
>>>
>>>> Some ASUS desktop boards describe the same ITE USB-C controller twice
>>>> in ACPI: as an MSFT8000 Resource Hub Proxy and as an ITE885x device at
>>>> the same I2C address. If the RhProxy node claims the address first, the
>>>> ITE device cannot be registered. Only the ITE node provides the
>>>> interrupt required by this transport.
>>>>
>>>> Patch 1 marks the RhProxy node absent only when its I2C resource exactly
>>>> matches a supported ITE node which also has an interrupt.
>>> AFAIK the MSFT8000 device is used to grant userspace applications under Windows
>>> access to I2C, SPI, UART and GPIO resources. Since we already provide those functions
>>> natively i suggest that we generally ignore MSFT8000 devices when checking for resource
>>> conflicts.
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>>>> Patch 2 adds the ITE885x UCSI transport. These controllers use
>>>> ITE-specific offsets for CCI, MESSAGE_IN, CONTROL and interrupt
>>>> handling. They do not expose a VERSION register or accept PPM_RESET
>>>> over I2C.
>>>>
>>>> The register layout and reset behaviour were checked against the ITE
>>>> Windows driver supplied for this board.
>>>>
>>>> Tested on an ASUS ROG Strix Z790-E Gaming WiFi with ITE8853:
>>>>
>>>> - Built and booted on x86_64.
>>>> - ucsi_ite bound to ITE8853:00 without the previous -EBUSY failure.
>>>> - /sys/class/typec/port0 was registered.
>>>> - USB-C attachment detection worked.
>>>> - No UCSI, ITE or Type-C initialization errors were logged.
>>>>
>>>> Suspend/resume and the ITE8800 through ITE8805 IDs have not been tested.
>>>>
>>>> Changes since v1:
>>>>
>>>> - Move the duplicate-device quirk from the I2C core to the ACPI x86
>>>>     status-override code, as suggested by Mika and Heikki.
>>>> - Correctly identify MSFT8000 as a Resource Hub Proxy.
>>>> - Restrict the quirk to exact matching I2C resources.
>>>> - Use devm_request_threaded_irq(), as suggested by Heikki.
>>>> - Rebase onto Linux 7.2 and update for the current UCSI API.
>>>> - Read and cache complete UCSI events before acknowledging them.
>>>> - Match the vendor transport's MESSAGE_IN and PPM_RESET behaviour.
>>>>
>>>> Link: https://lore.kernel.org/all/20260314013157.7181-1-edward.blair@gmail.com/
>>>>
>>>> Edward Blair (2):
>>>>     ACPI: x86: hide duplicate RhProxy node for ITE UCSI controllers
>>>>     usb: typec: ucsi: add ITE885x I2C transport driver
>>>>
>>>>    drivers/acpi/x86/utils.c          | 151 ++++++++++++
>>>>    drivers/usb/typec/ucsi/Kconfig    |  11 +
>>>>    drivers/usb/typec/ucsi/Makefile   |   1 +
>>>>    drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
>>>>    4 files changed, 558 insertions(+)
>>>>    create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c
>>>>
>>>>
>>>> base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
