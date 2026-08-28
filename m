Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465E23E324
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879090; cv=pass; b=VaKyqFD5HDqR1sYFaeTocDKvn2SdzZUiEfjigsFIJf0hvd8d42ogewJqFrFkvR0QllJzvWTrzpKV+PTsHcJjZ8kz9MmiBwo8OMKfCxPO2lB6btd3EN28bIO+QAvv2VJBliSIr/w/m9plxNx468CZj4JVAbLnVpOnA3H761ns88c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879090; c=relaxed/simple;
	bh=Xh+I7qWrmeJkKs1sM2KOcgK+92BgW2u83x3A9zVLiFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D60F8MQ/sKyuGzwzNm4RE5qAXATy8uofodBoKtqZJbMlPhLsoDba+yc3TZNLLKsDvVztGG7M1wi9PuWSAgSbNO5ZV86LPC8O0uzsmin5ko6I65DQCVlcovJ5wcziLHNHQOjsVYB/CELlqz+2T49ttDMha05+H81886HoUVFncnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZLDEQkY; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZLDEQkY"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b4a95ab94fso1717694e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 27 Aug 2026 18:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787879087; cv=none;
        d=google.com; s=arc-20260327;
        b=rpwjaq0smvZ5L1tJ4EsxLBpvhom7hLl2QylNUwzL11Dm1MUL1oxDbdIdxLnxen7uaG
         njvoMzkUltua5X5gLJKDcFTDoAU8255FlHBcCpZtAHmyJ5ihEI9WtHt5nB1YXTsguwEG
         1nn5xeh6kQT1SYWau93noB3BRNTrCBdbN2+jGmEgNAM9VATmlGFcI2VPRt1dpkezyRIN
         AGf/yXA19sJSRjk7F2uGuNqJbvBEcyKaVdwGmo5SQFwjuW8AzI+BGlxJCrXr0uN1dFbm
         C712mNxQDuYmVUEZUrDDcGbZkBFnhsJrb2wmKRubTVALAQZ9/KqJ9f2Pk2MGAfneTClT
         m1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HRaT6MIiOdH60GOdGmwPWtS4IR3twdkYWfXwIpNDtus=;
        fh=YqKEDXGNIpA4DkXYkfDV4G9DY2jnlnHevRFvH2v7Fgo=;
        b=mSNmI5Ob3aw4ngBh0yQPZxUgJsQjnlJVl6NxrYAFSAeMT04H3gWkPfEe0qCfojeWpO
         +C5ewXd2OA0NQSTO04ZIXCKaXknicGRINjN8QCMwdEzVz/MzXEg9L6L4quPZZR3ohz3h
         PLDzw1c0pYbMs50r1dmnxyawGmIuVfjcVbVWtyx0DYf1/MoGxAFHmURWGradA1/6cMcL
         SgrP2BLuflbw/CCGx0cI6U8whK/E5B+uEXlOW45cy2ZgOs1f7FuAudFQgNzOZ/89hOWr
         fb2XhNV7p7fWl/wqPV4E/YgjNSd6w8rc0TmXrXkt1P1znlVxWBY1CgGIrFS26/K7i/R8
         XCwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787879087; x=1788483887; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRaT6MIiOdH60GOdGmwPWtS4IR3twdkYWfXwIpNDtus=;
        b=mZLDEQkYJ/Sj25n9bfeDF1sNeVap/EQf9cZmwaeckgjfZpmlKS13nxNAGYQQiSgwwf
         v6fnHsofjCZRpaaxsSmmNU4T2pLC7n/2F2pNlAh9BRxfBX+nA+mUHKmweSYg/BX9IuRI
         rB7AZOU9fysTs1c+ulSGRmczFO+7yQWKUAgCKuF9W0RrGD0W1yznFHJ8UW0VuJZxouZT
         EdWqgRhqnhwnJUj8ShJ5KZrC0PpALr0p0asCO0AWXxjZ6mqAlKnUK4JQ1uVGObcHEUj5
         N4sIRYHUrpJ9IHceUP+VtVQDlBhY2gZWvMWOPg6GfsoGGzk77uAFDDlO16zvKY6EecTC
         TZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787879087; x=1788483887;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRaT6MIiOdH60GOdGmwPWtS4IR3twdkYWfXwIpNDtus=;
        b=bVrqGBnXdqQ21cYb/f5DIBGH2agjn/8ap2mnhm1PkpQ8vFsK7i1Ap2IBvo9hjVISVK
         zn7M0OdT9jqx99f78EZ+fEgWeF6QMdEPvRzK9fSunf837/gVmt0zK9JV3F/LYhoN3EXd
         mU9p1r37kRnPjqZwCm2dKM3t1ztp3TGVFSqDLpudTNy0+mjOTucgt6iNf4Ig/g/JPxGQ
         +xX034RbBh2L2UX21JSfKkexZMHwW99rvo83vmbOC3VGUXwrr9BaJByHe1qDQ3NL+PgB
         8e1oTEiHAcR2AI5HgQwmlNAvqsEI8g0dMym+uRmyi0i89xUA3au0z1DtIhoPPiuGwveP
         ckWA==
X-Gm-Message-State: AFuF++mY/KYgQl4P3HbJ9n7Yzf70r4eu5hnoq+Sxxa0e29dRBVD7lclt
	E9EijwbJf+OV8X6csBL88zEVePHGa3dfhRR6wIXvk7X01+L0Rsypskj8H2NNOw2OTgjalncEIwR
	Ihes/HcntTbDnjvlBMzMKdbbKrghe6G8=
X-Gm-Gg: AR+sD13L1kB7FiypUZJxg8MRBeEqOihylYiKmwxkzRUVFyc2PVAUBF51zFG39bFirUj
	XCwQmSYenA88RhGb9QTLjJS6ytnaH4rj0KU55o3OcaZS4WfcvTCe+vdKgslLzjzuIBBYE1k+ip7
	D1y5KTrPuWXrY9RopsP7KJmMuQGAS84ZJ9qd2TrrFP84CqRwX5KVkKzNAU8oBg6ojuCjUhSacd8
	96SGXpzyOiJdzdADqyq3BLlK7oAAR1cvm0jAtmiEzX2Hz+Xl2WrZFsiSSV7AtWCP0gtxnA0iS88
	b2vq7N10RI6rG7DSrJUh7p20V4ntoEqx4x1/m55Hpp/5SkacCb2J9+rEn10DQXQ+L4vc0KQt4hz
	RIk0OcjL+KxGLrfOztYHMBuiEZJ6YGgB3+8ukhQFJf56qE0viMt7gBSmITltg
X-Received: by 2002:a05:6512:1183:b0:5b4:af24:3612 with SMTP id
 2adb3069b0e04-5b4afef0305mr2135966e87.20.1787879086471; Thu, 27 Aug 2026
 18:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825201426.47030-1-edward.blair@gmail.com>
 <ca37dbf2-0949-401b-a1bc-c714a1c451e0@gmx.de> <CAJDQNggKFhJ=YKanKWmG_hRi98nRi-8Wa19D7mqU1MuM2dF=vQ@mail.gmail.com>
In-Reply-To: <CAJDQNggKFhJ=YKanKWmG_hRi98nRi-8Wa19D7mqU1MuM2dF=vQ@mail.gmail.com>
From: Edward Blair <edward.blair@gmail.com>
Date: Fri, 28 Aug 2026 02:04:34 +0100
X-Gm-Features: AcwNN1UV8tR9FZvMUvIaGMdgAsZ2UHlnLfWSykB4VKQK7lgAutcjQT7QOYFtH_w
Message-ID: <CAJDQNgiYYQW1N94cTSD-Naph9h44OXZpsZVySi=7sgpcQ21yYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add UCSI I2C transport driver for ITE885x USB-C controllers
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, rafael@kernel.org, 
	lenb@kernel.org, heikki.krogerus@linux.intel.com, 
	mika.westerberg@linux.intel.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's try that again.. without gmail's html...

Thanks, that makes sense. I can rework patch 1 to add MSFT8000 to
ignore_serial_bus_ids[] in acpi_device_enumeration_by_parent(). This
keeps the ACPI device present while preventing its SerialBus resources
from being instantiated as bus clients.

If that sounds reasonable, it seems like a good middle ground between
v1 and v2: it preserves v1's enumeration behaviour while handling the
device generically in the ACPI core, without the ITE-specific x86
status override added in v2.

Thanks,
Edward


On Fri, 28 Aug 2026 at 01:58, Edward Blair <edward.blair@gmail.com> wrote:
>
> Thanks, that makes sense. I can rework patch 1 to add MSFT8000 to ignore_serial_bus_ids[] in acpi_device_enumeration_by_parent(). This keeps the ACPI device present while preventing its SerialBus resources from being instantiated as bus clients.
>
> If that sounds reasonable, it seems like a good middle ground between v1 and v2: it preserves v1's enumeration behaviour while handling the device generically in the ACPI core, without the ITE-specific x86 status override added in v2.
>
> Thanks,
> Edward
>
> On Thu, 27 Aug 2026 at 23:30, Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> Am 25.08.26 um 22:14 schrieb Edward Blair:
>>
>> > Some ASUS desktop boards describe the same ITE USB-C controller twice
>> > in ACPI: as an MSFT8000 Resource Hub Proxy and as an ITE885x device at
>> > the same I2C address. If the RhProxy node claims the address first, the
>> > ITE device cannot be registered. Only the ITE node provides the
>> > interrupt required by this transport.
>> >
>> > Patch 1 marks the RhProxy node absent only when its I2C resource exactly
>> > matches a supported ITE node which also has an interrupt.
>>
>> AFAIK the MSFT8000 device is used to grant userspace applications under Windows
>> access to I2C, SPI, UART and GPIO resources. Since we already provide those functions
>> natively i suggest that we generally ignore MSFT8000 devices when checking for resource
>> conflicts.
>>
>> Thanks,
>> Armin Wolf
>>
>> > Patch 2 adds the ITE885x UCSI transport. These controllers use
>> > ITE-specific offsets for CCI, MESSAGE_IN, CONTROL and interrupt
>> > handling. They do not expose a VERSION register or accept PPM_RESET
>> > over I2C.
>> >
>> > The register layout and reset behaviour were checked against the ITE
>> > Windows driver supplied for this board.
>> >
>> > Tested on an ASUS ROG Strix Z790-E Gaming WiFi with ITE8853:
>> >
>> > - Built and booted on x86_64.
>> > - ucsi_ite bound to ITE8853:00 without the previous -EBUSY failure.
>> > - /sys/class/typec/port0 was registered.
>> > - USB-C attachment detection worked.
>> > - No UCSI, ITE or Type-C initialization errors were logged.
>> >
>> > Suspend/resume and the ITE8800 through ITE8805 IDs have not been tested.
>> >
>> > Changes since v1:
>> >
>> > - Move the duplicate-device quirk from the I2C core to the ACPI x86
>> >    status-override code, as suggested by Mika and Heikki.
>> > - Correctly identify MSFT8000 as a Resource Hub Proxy.
>> > - Restrict the quirk to exact matching I2C resources.
>> > - Use devm_request_threaded_irq(), as suggested by Heikki.
>> > - Rebase onto Linux 7.2 and update for the current UCSI API.
>> > - Read and cache complete UCSI events before acknowledging them.
>> > - Match the vendor transport's MESSAGE_IN and PPM_RESET behaviour.
>> >
>> > Link: https://lore.kernel.org/all/20260314013157.7181-1-edward.blair@gmail.com/
>> >
>> > Edward Blair (2):
>> >    ACPI: x86: hide duplicate RhProxy node for ITE UCSI controllers
>> >    usb: typec: ucsi: add ITE885x I2C transport driver
>> >
>> >   drivers/acpi/x86/utils.c          | 151 ++++++++++++
>> >   drivers/usb/typec/ucsi/Kconfig    |  11 +
>> >   drivers/usb/typec/ucsi/Makefile   |   1 +
>> >   drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
>> >   4 files changed, 558 insertions(+)
>> >   create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c
>> >
>> >
>> > base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
