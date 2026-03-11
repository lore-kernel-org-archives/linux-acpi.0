Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50E82866
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254041; cv=none; b=RmErTCbyqk7XrJqeRf8BL4lnpFwOS7uVqnXO4EgquTgUKof+q8i8Ts/+qcoja+OsFxKU2GJ1I2BqQJCSsv8le1OqqJ0YATfY/K4euBHB82QkBzuI1/X4cdTjjXMKAOhdpPBYy5Jqnsz32RPValmXfphEboNzK9OSIf9xWcxKbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254041; c=relaxed/simple;
	bh=PHRsjWEPQ6tFOY/wwZl2SERIkouvrnFZ4xrKRQNR2Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf9zTEYvPVKRLD1IKWxYpxC6qMGnZl48jWd38Rblg8zHPoTiVbrmRkkDpB4nIHdGft5j9mLzTFmEz+o7ergXH5QwsHX2vsRqLGV49IFV5e1B8ACqnFkJejMIQt6+V5FNc9lMdDGaksIETTr1t9WK8hMZfCKziX0wXWBUL/r9GKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLD1zwkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLD1zwkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F3EC2BC86
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773254040;
	bh=PHRsjWEPQ6tFOY/wwZl2SERIkouvrnFZ4xrKRQNR2Zs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kLD1zwkwo1iwhB3LbqRjIop4IV1krJBnKaE7OLF9XEUcqzszE2w8p9DOeqrZm1otp
	 Kt7IyvVzP46qYilBULDq42ZxXkLqSfCWUoB3SN68FD6i5POovpcNt0aE4nUiIS2eUQ
	 CkxKWtHpnkBrKvyfDiqTySDF8A2gzz32ggit3rEHrZZ+XiAMfULOKOGaZzhghd5L7C
	 zFkGsKYmqBlY6Azg3C6SgMpYjjVwbPsktgM1F3GMR0OYyEb1WU43whPJ4KWlMg5rC9
	 4ZWXdA2TIye6tNEpK+pv7mYv5yhj8eVyMKt0OXDmn9P1pn3AI0FIWtuXVhxCIMeIx0
	 eypq3tIogSdOw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-46701f2077cso1132604b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 11:34:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3ka2pTIJsbtS1hovvjZch2kiBfSGu/E5tJnSh6ufbNkHFP4a9Vhx6lMrx61im/TCmgpkHLTuALIHR@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkTPgvgUcUAD+3OzpFItbiAWAe5xHcCejxfgRM7vhS/UPyagO
	23bmmWLlDxia2c0M2HEcUrImJLh5CXsDql0rUDSQ6CUAP57lULsGV7wIbL3fyGKh09Jj0Ra11Bq
	F9IwEhZ2s0fRmBXn9bZCq8eKWc1gn6zQ=
X-Received: by 2002:a05:6808:30aa:b0:467:ffb:4a82 with SMTP id
 5614622812f47-46743228cdbmr352497b6e.29.1773254039804; Wed, 11 Mar 2026
 11:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311065038.4151558-1-lihuisong@huawei.com>
In-Reply-To: <20260311065038.4151558-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 19:33:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=5wf5jF=1ou6C44xYxNZhzoaYuAEhixdCcaJpx5aH5Q@mail.gmail.com>
X-Gm-Features: AaiRm52RTmeqCFLaHbvynWhX-e6TFDZckvr7p_xIxYsO4XX32mxEbCFxUaN4fJE
Message-ID: <CAJZ5v0h=5wf5jF=1ou6C44xYxNZhzoaYuAEhixdCcaJpx5aH5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ACPI: processor: idle: Clean up max_cstate update logic
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, bp@alien8.de, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:50=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The acpi_processor_cstate_first_run_checks() just need to call once
> in acpi_processor_register_idle_driver().  This series cleans up the
> redundant calls and internal guards.
>
> ---
> Changes in v2:
> - Add a new patch which move max_cstate update out of the loop in
>   acpi_processor_register_idle_driver.
>
> ---
> Huisong Li (3):
>   ACPI: processor: idle: Remove redundant cstate check in acpi_processor_=
power_init
>   ACPI: processor: idle: Move max_cstate update out of the loop
>   ACPI: processor: idle: Remove redundant static variable and rename csta=
te check function
>
>  drivers/acpi/processor_idle.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> --

Applied as 7.1 material, thanks!
