From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
Date: Thu, 25 Feb 2016 12:58:11 -0800
Message-ID: <CAPw-ZTmMVMztB6GTZPCtgoUKt9J2xAo1vBREzFZPUpZiS12Z+A@mail.gmail.com>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
	<20160202182657.GC15706@e104818-lin.cambridge.arm.com>
	<20160203112112.GA18387@red-moon>
	<20160203161834.GB26487@MBP.local>
	<20160224141832.GA26630@red-moon>
	<56CE3C9E.7070505@riken.jp>
	<20160225092427.GA31728@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33589 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbcBYU6N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2016 15:58:13 -0500
Received: by mail-lf0-f43.google.com with SMTP id m1so41396930lfg.0
        for <linux-acpi@vger.kernel.org>; Thu, 25 Feb 2016 12:58:12 -0800 (PST)
In-Reply-To: <20160225092427.GA31728@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Itaru Kitayama <itaru.kitayama@riken.jp>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

> -- >8 --
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c

I applies this to 4.5.0-rc5-next-20160225+ and boot just fine on
Mustang and Merlin with 8 CPU's.

Tested-by: Loc Ho <lho@apm.com>

-Loc
