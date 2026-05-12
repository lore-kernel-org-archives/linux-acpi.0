Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B125B080
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610674; cv=none; b=laTRnWGkDHARMaT6Wj32VB3XuRzURjLrA6V7amXoN6JpBUQOofan290qIH3pO458dxqus2lgunqVxX/HF4OEHkPvANCpbTrSt6TwcYPPYP8pt8ia0CuoRai55rw5+WFCwSckFAp4AV63/sz2OvISeSvmgoPEoYhQx+22fi7nfiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610674; c=relaxed/simple;
	bh=5zuVOAfpBrN8nUV5rRh7DAd01oonyphvre94jBBXL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otKfLfTwhLlPX3FkMpEZT+68WQObhuV61JvG1YzcUFbyksabDtLxnWHY/lrZPezAmoH6hm1qxhbhDqi6K1Hofn9vQqvlRzhvIfTBmd/g+nrbl+dhpCyvr1/K7Ar9iGP+B4WtGtd9wWxEgSPhMLXgIjSlNZeg6Nrb9yo8oTymEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiXVSWL8; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiXVSWL8"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1335cb20406so1921108c88.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610673; x=1779215473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lbpfqp9eZFaWLOn99BFCizyb8FixFL821MVG82h4o7Q=;
        b=aiXVSWL8VSyEVUm0Zb84PvP/T+73LDnEJkhuQyjGUdgsaK244mKXlQ2TDsW6hibw+W
         c1pPyokadxQlkWsRuS/Wf1RWvJND5EWWfLUZWaeLq4eSq3+twsOh2oKEoKSp06YNv2t3
         L81Hvs09Uo6sKonod6T5FyBsRa6vDWEOGITHciCa4zLfNMj4RdGKdF7KYMAtjf0kEUVK
         u6lJg2JhbWnNPz4+Y6abFXfIk8EO2kPJjVi5iE0zImsZNGLEXqJmB2cga2RJFRedISGb
         /ail0EEESsuMbsCh0UO0CzsUdCdsLG+n3jeEQD5VUBcaEcRrge43tdo1TDyj0CvuuXBe
         1Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610673; x=1779215473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lbpfqp9eZFaWLOn99BFCizyb8FixFL821MVG82h4o7Q=;
        b=FQkf7SQRuEMS9Ter2C3DtaTlIJu+IhghizVdGxJIz41mQ87B6T+8jX3v3NauPJNoI0
         o4hJ+C4bMdxF8nPsaxt2oF9NefA6g5Z5iU9PHTCZGpqpsELwaIJxzX/Msw9idmE0JNem
         HGWugVhaVlgeC+eRgFpsu9Qlq648GgjKAY3ZkcFs14vouILZwP9LFKfX/1xNp6W1V9nS
         w9q9UjujW6WV+eMKM3QwZBzPJHqKwzo/lC/H/w3IXSVX3TBX7bB39M02wQDiuIG29/a3
         Ld7g61Nnn2fOSYg61NAFGZy+SfQjipaV8I6EnQMp2UJCctTblJCUj549NrN2cKZjDLmC
         LxZw==
X-Forwarded-Encrypted: i=1; AFNElJ9eWgVXFIqLd58FdU2DSg/pwusJxt5rQRcfDjU8oglANoDeRN7tVjweYi6x6un6mJG4CZ1MntaCapn8@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBuHvGLlO4/y32awGQt//HyvXn8fo22VNVsz7C94fmkP1PB6H
	M+9UqB2ieSNGnG3IfQLdw4x1RvkFiXzES4tyLitZSVo3Ic4Z+rbcR49n
X-Gm-Gg: Acq92OHXHa6DE7Z2dVGa57Mwdypo66OYgCZCBZWbYVrPfuTI1trt0ak7VT5SvslEVcA
	IouJN+CmrE9EZDXFn1ORtDqn/SSCx6hBrxjhhFgrzo7UacDvndfvKu3z4sclNRu2v3ERz4NNA0D
	IAjdWN7+eDQ8qVQGnxnkqu6NQbdSWGDGoKsfZ+7NN/IMa3zmVI8IDBKfusUbohtLlHK+JrMmQqS
	KPV7C3XeksIDI4tmY79RmyDT1fPJK1BNpmrYevp4QLc9+GylWshoauEit/XOiylc9QZGE622aIE
	daGbav+NCC2W2aWGHQi8vBpYHCpJL/Yr/K/6Bhu2Mt7ZVE01kQmKfNY1qr6UTwnd1i0UgKyqfBR
	rgK4mp5LddNKBOBdjTiqpusvgbyH+poHHTzaRXZh8VWCHqyqatVpjs5pf6bKx3q6FhGZ0kk6wIH
	yyvbeQOmGTBuQCJhYToSpcfuGQRD4F9iwCXeic
X-Received: by 2002:a05:7022:1e04:b0:12d:f7a6:e641 with SMTP id a92af1059eb24-13436990c90mr60514c88.25.1778610672620;
        Tue, 12 May 2026 11:31:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278765984sm19827539c88.14.2026.05.12.11.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:31:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 May 2026 11:31:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] watchdog: ni903x_wdt: Check ACPI_COMPANION() against
 NULL
Message-ID: <a61ad93f-bfde-4b53-9681-83dc1a895943@roeck-us.net>
References: <2280455.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2280455.irdbgypaU6@rafael.j.wysocki>

On Tue, May 12, 2026 at 06:22:57PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> ni903x_wdt watchdog driver.
> 
> Fixes: d37ec2fbab55 ("watchdog: ni903x_wdt: Convert to a platform driver")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter
