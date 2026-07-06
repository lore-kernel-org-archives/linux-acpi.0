Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5A26059D
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345817; cv=none; b=H4O73dALVP8T2puHIg3GYLcyKF3GqfDlnijJgNBUEYmKrZvhRGqjUxHyCXNSIuWYSIPRqpFTy+I0OJcz/kRe6WsfF6SPheK7sOU5wrq6OyJ7ySsbXmrdarDHxa/+6n4lC+oqQu+ETgfNFfuqN5g2oiIrU1L6iLrXgIWt2/rhOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345817; c=relaxed/simple;
	bh=cfEQ5oirwlDZwWqWXlZ2ec3fN4r4v+L1Bsv5+igbND4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBVIeLpLL4PWhDlyYzJ2j6uIZq/NDv/+M4Lu6OYpz+XDVKavvqgWTEWdPETNmp2GYqkcwlcm8kyBESB6l+EVMCRhaFsJM3Ygwqn0MSl6rd5btKmxwXITC97tD2K3CK0q69XmgnfgnitMi0y7idKyJxztQV58Sd4r1icbH5aJqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=marYD353; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="marYD353"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1618469a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345815; x=1783950615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O2/JQDEja/6xWoRlPU5jhPNbz+DyTQo6R1OxX+kO6dc=;
        b=marYD3535Ng0K5oY+/hmEhUjR6jHmzPuYn5alOexgIslFfFnr7tqOfCzhkcw/F7nkb
         9HC3eeH16br5k3ZoiCwrtPqXyj28ocsJQYbc8I+NUXFPtIKNLa3BeTogHXFk8TlmH8ay
         fj+VZwtP5bA9FLXBSMLuURcKwlO2RyTeEcS3GEbMm//U5sa4ztl94xqULqsSTb8zUmEk
         t1i5Shm6HDbGgk6WM4YEguWZMHcIY9L1OV2gslzWgHqCnMJfWtSGgLVMYMgie7LJscvR
         kKsZUprOAZ7Vb0+blP4hoCTzzol8iEr5eoU6Iw78T3s57cSIE87OI4ViNTYNMnsQ84Nk
         8cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345815; x=1783950615;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2/JQDEja/6xWoRlPU5jhPNbz+DyTQo6R1OxX+kO6dc=;
        b=eY+us/RhrvpsPZO0105v5umD0vdGMyTA5tZbKJOVWb7TY9DjNiG7y+s7Fg0R2c8oLS
         krwqp0JM1XEDanYoL5HP/dNmZlc4LcJro20vHS1ynhbUdUi0y+eutNCFf2LphPujRtNo
         3DVFFMlL3pxe/COzRKUbaS8DKrchj4PJuAt/LlJYYaQp7kdpQ8deBv3dgPhfABAxQ0fe
         eLmKynkPqh01im+2fHU7nFc5QlRM5yZ5UEy/wPxb9fIrP4d7kx4ikLMK+y+CbrRniLV7
         aEy5sm3NkZNeK1LeVjMoneOwSp81zqzc1r+hTR/eaSLXKRZeFKNvIY105amuCS0pITi7
         xS0A==
X-Forwarded-Encrypted: i=1; AHgh+Ro9UAeZO9N9XabfiPVmAGHNzuHLw6Wk0ZBBafRbrc6qKy/cnvsLx9e7ifH6yjFUCgk20lnIhqwq9icx@vger.kernel.org
X-Gm-Message-State: AOJu0YywOpPeOyDTacll6uhcVWR1UqwspWo75DPDx4xnWW7heIGcOn+n
	N9JVwHw6WoVhf/LMtZX/+4hkmnddBkCl1/0Vdy88DtrYG5y9olhLclBT
X-Gm-Gg: AfdE7ckafbtFlXGvOi44B6Nxx5yDvfw4d5KyQuG1UKWG1jmeNFfRG7TGTNXFtaR+rNG
	KcL95KB5onCs2M/1oLayx+XS4+tcdO3gcsYRvD+/cRE0CLUvwzYC5qT/+jqA8T4EmDPLoxRyD0L
	uOJ5cPWt72Z7muRFke8t3pUz+7QEOir8HynFLAK1Dy5fo3iXfNji+1FqZ58CFwRELz7N9Po/h+R
	mU5alwhWxqox/qyMXHoKqFo25oys+tf6hm11g9PPE8AVoWSbrwGKSKBRhbR0pfSXeGB62UudOwu
	4rJc6g5tljpR8dnGP0lAgYZZLhZVa1yNmqGptKwgOFpnXY089+piYDNSunMiDYu02BuOrBFB6+r
	GLNn1vNB547IV+8+1vvyLgdrTNxgv1r3IhmLeWAiFtcRZklicyb92to6o47502r4fRiwDgyDfIo
	87PRFKgGMMlAeUQKi6xgkkqdZDoQ==
X-Received: by 2002:a05:6a20:d807:b0:3bf:65b7:22d9 with SMTP id adf61e73a8af0-3c08eed4542mr801601637.41.1783345815467;
        Mon, 06 Jul 2026 06:50:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e91b07639sm6090794a12.21.2026.07.06.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:50:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 6 Jul 2026 06:50:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Stop setting
 acpi_device_name/class()
Message-ID: <e3c2f512-cee7-4f55-a1c8-8bbfaa655159@roeck-us.net>
References: <2297496.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2297496.irdbgypaU6@rafael.j.wysocki>

On Mon, Jul 06, 2026 at 02:35:51PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The driver populates acpi_device_name() and acpi_device_class() that are
> never read afterward, so make it stop doing that and drop the symbols
> defined for this purpose.
> 
> Since ACPI_POWER_METER_CLASS is also used for generating ACPI netlink
> events, use the "pwr_meter_resource" string literal directly instead of
> it for that.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name and device_class from
> struct acpi_device_pnp in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied.

Thanks,
Guenter
