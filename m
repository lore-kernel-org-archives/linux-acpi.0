Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8225B081
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610802; cv=none; b=jNrwKGRo5UVEHNEp1o0wfbaDtEKPiM/S9nvC7PZD5rTgDuk12NEMAi71JoqSwr4Ze5xJbXknuj7S/2Qf6PzPZZoakBJypbA3N8X63yif+Iqnf7985VcTsjQxRNtytGntgeit80RebwDFrYmOp/Eq9/0VHL3XYPC9V12UNlwA5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610802; c=relaxed/simple;
	bh=rPBgT6zICytJjVXVoxD3lPyWMwSc+0d1+060L/nNI1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJeDUoxzELeZoeaZk/LzxbItKCZ7nU9kI5uFDIGFgbZrhzfeVwasatIFE18JyG80II3OdPL4W/V2f3Ur3Pz/aa0Gja2VVEjO5HA+QnfVyTqVhKoBjZYolbppULpXdZceKiRbcw39LtG+aznzZ7osH9q7JhEelazgj6cMljZ69C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECmAIY5v; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECmAIY5v"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so6123488eec.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610800; x=1779215600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HS4Zrl6GAlNhNQKYM3MZ1UClFI+aLaMtRMq5Dn7VS4c=;
        b=ECmAIY5viaskWIatkOLp32o9I8IHgYODDXUVoMEtpZw/abGgZWq+6i10PE0yNk2Mcg
         22js+WRJiXN1qeMjSgRtU4sNDnzXsNutyQPBRhrlgVSD/f3h6dMT344Kj33I0MSJVJ2d
         z6OldcQpKlVkUmLYc5qdFe6TcEWxwYxkG+qoJ5bvT42Lkc/2i9cCMqSLtUJbr4vUJZ61
         mis1W+8WfMIXtz/JfozLeTcUaWnaNYLSc617mqJI53Ug0pSVU86W5RWa7/Ex0VT48W/O
         QuAt+h19fqwYS4Y6M9m2z8w3Yeceocja0QXVxFV2Zcbqs3LLb2mC8wEyo7tYQxD/jeEd
         M0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610800; x=1779215600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HS4Zrl6GAlNhNQKYM3MZ1UClFI+aLaMtRMq5Dn7VS4c=;
        b=c4LZgsd4wiBWaBPOyDuK+wH+uE9DPS6NGXQyohi8DzCY3id1ECBN23poBe3r6kgq2R
         WotyDmTWho4tU5/A7ALGPQsa9LxcpgJfiB1GiUfEdB84Yes7VB48zwynTMNrCyTJKkfp
         DPXLPs6+YSpOXlDJpUvCVXpy/GjlCe/uTiygFKUDpDeL2C+6uobCaW7PDA49Jn1LGvdJ
         cB6P0GN1pyRC0mOgwQQ2aao0HH7HsWmWbFLmX5WGy0dzW3+Fchw3YTGVSRcd4g/n5eqj
         Lb5/A8B9a3x0+pU8p7sleZ+JzotCZ1KYmj2m923D4Ugs+8uEUI7RMT1ZHB5bWZDo7qlR
         7hxg==
X-Forwarded-Encrypted: i=1; AFNElJ+6eEOZi3Cti45LGNUOsvDPVKmKbkbsJ+3bOZBtw28Fsd89zUBJOS+Kn6GYaDqh7+Nku/9pA4Vku1+e@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwoaElJAzINmzkkNhEwn+Fg9h2eJrJp5BUX5Oi2kDTRws3i7I
	89DSaWxmHbbADHr5wI8FBQyrbO32FyvCPxN54q+JSKhohMPEp5c+rsMC
X-Gm-Gg: Acq92OGBfltQUU9zYAmlZex41IG2WEryY60QFc8YNvb+g5uklrvLeIzPeASxQX4ZgHQ
	kZH2zDzBFC1zdG11DlTveB9e8opqaX1DzAPKwUo03wd7b9NndMXDrYPpYH5o+KbgUHIqUTd5KKt
	y/YuOZpm5Wx04ugsMByf5MbgRyzPoSKjX1cNN8h/S33bJmdoBx3+GCkqWQVe4XcoAeHPcSFCedw
	0Z4dynBg/JJJY9jCMPTDcnjRX5KLfT12+FkisWBP3O8goqg0AQgcSaTLOlfM+TmWylsDUWbqe9M
	U9bnMGfRY8/4Umb3sBTBnRTZ3bqpsNzq3ra2pd4kaKkaOA+oukr2qFRaqndTgFy2lF2+XxKFE0d
	Xu7kPNfLOJwjaQK3dWOpLP54bfL5wSmqX0jHrMj6BfUhCw65gnyrY7yC1gQ8o+7QfZ2T1wJ0gtc
	W4LXsmS0+wckeM6TGIK/AR55Yj9ndCQXmVHZ5A2X6VRcFt66E=
X-Received: by 2002:a05:693c:2b16:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-3011a26becbmr141449eec.17.1778610800355;
        Tue, 12 May 2026 11:33:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm19526286eec.2.2026.05.12.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:33:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 May 2026 11:33:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH v1] hwmon: (asus_atk0110) Check ACPI_COMPANION() against
 NULL
Message-ID: <e03e617a-d748-45f6-acb3-ef4f75fa17a6@roeck-us.net>
References: <2261594.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2261594.irdbgypaU6@rafael.j.wysocki>

On Mon, May 11, 2026 at 09:56:14PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
> asus_atk0110 hwmon driver.
> 
> Fixes: ee1752590733 ("hwmon: (asus_atk0110) Convert ACPI driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied.

Thanks,
Guenter
