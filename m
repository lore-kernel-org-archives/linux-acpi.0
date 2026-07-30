Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C010442131
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425600; cv=none; b=GbqE2iiLC1uejxUKI5VJ8ejlFYtjKdVCbbrErk9D2E5/TGQHIg/DfBDIMoIkA7BREprBBu0cUhayuyNg5nJBq1JKinn+Yx/OTzK6/4q6MuE0N0JjXmsfOgmgG8MCBH8PPoMmb+Z7+Emd7YdX9X27Wi01ijF9thzz/HwVtHzi7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425600; c=relaxed/simple;
	bh=vjUxU6DfeHaH3nfWdpw7t9BZ5QMeNWrLnziCSKK+a7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dlk10PTuT2bvSxDs7gUafubER+go0AkYgrOrZrlIh5oqJQwQF+TbIPoO2i7h9HotXaed7AULlC85oXhdu9TRTGStAHhp9osGyI/kbzqwWkjbRmWcCiwsKMf6ERhc4yFjHk4hY+M5O0NrkgPVnfZjXnOiTR7JrXc42UsQgZ5aTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/lVnnS3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/lVnnS3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1579259f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785425598; x=1786030398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvcYl98Dj1v5Xl2yAUS1oK+AUzC0Thd0BmMktXzpQkc=;
        b=i/lVnnS3wAv8IR21f3Bo0GU3lPLLh9lXG1h3l6gUczCQKf7ts9WECiHUb+gumulx5U
         aA9UFqFXz6ZHkKuEGVYYejw4QyIrzR6eQOf5pzgM/JzY1Jh2ktDlkdbBAdO9XX6dtCPf
         Xf48covjMwvRj9bAXdVMF7gB7X8o64aRoZniObj+ZDe8RUZlCsWW6DXiLkzzAPs+mrUz
         vXI4Bnn3dTHSg1Y8FcjkM2+VxiAKGwl9t/E+Z2O3eL96gBaENLK1XLAo9Gf6WW5Pg3hN
         TjICrwX3EuoJLgXx/YJ58mI22EFcp5OGT074SEOVBOPftSbEd611bDxq2Sl985TP2hRI
         PFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425598; x=1786030398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvcYl98Dj1v5Xl2yAUS1oK+AUzC0Thd0BmMktXzpQkc=;
        b=dwEL3w7+UwOHrccHmX5erJDCVAme8ebTcpBeaRCp2HGVNQ+NNtGazxbEIPEgjYvcAK
         cW0xeFKtMoBAFnW4Dg2mEOylKuK52Sk11vW1LJ/+Flfn9HGgPpSsdZiZVxwpaHHtW4Td
         I/Fq595JuPZF1EofO0PaD+aX9F9pMxNegruwfTaB3MIWhXv7MPyb0NjJaMdWxnHgIL+z
         u2B/b+AUKThkeS+M6409FwIz92pDrmYJ9LPYIrqDj/e2SGqyB9LPATTyUPPKicV+7TZY
         2u5XCsd6NHHMZNSxvQbSTPFetqrgAKct+OlbFCWOTyRFtjCsKjPjO8zf9yrJsYZbT1ZS
         sd4A==
X-Forwarded-Encrypted: i=1; AHgh+RpEspoEv3OXdjnNT5zJgn8zkjXOlRcQmGgQHOeWqm+bNUlb/Fxs0SbioSBa989QK8g3nh/fdUy/AJnC@vger.kernel.org
X-Gm-Message-State: AOJu0YyIcQHA5uaHKnjMwP2G06UOTW/pyH3FIlXAnfrBqWMoZiW3sifE
	33V6AborxOzSv6MJUd+SON7FWDemAIELExhvVUOZ80YjM9x/6KUy0Hhe
X-Gm-Gg: AR+sD11UEdA0Xsy517hAkcAL4QA1gYO/ksqu7lFw7ZguGcbkxzpc7/dF2JIRdD1llNr
	Z/VumHTgfHkLnL3eAhL5N1Huoy85j9OTJb8d7lEqwBU16em1cDOmsNvdinxdhyBNKdgurFXnRv3
	PzYX9gk9ka7fnzHR6BJA28NXuhOqiOfD8MODkZ3Y5qEuGjnWIV90TG2E+mMwPXkzP+9VFHJh3cJ
	SiSioAGAlSjTN7MJMrDIyny9r5HGTa1SqqCzv9QhaYqaU1J8SrniK1qG+1BJdCJ1y9wnIPWVO4n
	TXDih47/4BdTYed+V1FrZJO2yRxxRRfEVq8FRpBaSfXr1a8LUJhsY1Y8qC4K6DELRgm9tJ3iqYS
	cNIoXiVuQyGtCx/Rz5g+pN8JeYmXu8KsvJFYuPCxpQJ43TWJmqqmYmdjQTgPORLr9BPyjZHDMt9
	U7Yjot9UkxQqqe/hgehqKQ1Ttm0x0SMNNmHUgCDMt7m8WFUsonVqyVBD0R/Q==
X-Received: by 2002:a05:600c:848e:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-49800e7014amr40612605e9.2.1785425597583;
        Thu, 30 Jul 2026 08:33:17 -0700 (PDT)
Received: from [10.10.0.5] ([59.152.127.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d8d37sm6622003f8f.8.2026.07.30.08.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:33:17 -0700 (PDT)
Message-ID: <692c652e-2be5-4fdb-b0f2-4d63bc72253b@gmail.com>
Date: Thu, 30 Jul 2026 23:33:11 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <2026073005-rarity-devouring-721a@gregkh>
Content-Language: en-US
From: Julian Silver <mendaxca@gmail.com>
In-Reply-To: <2026073005-rarity-devouring-721a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-07-30 22:06:28, Greg KH wrote:
> Does that option work around the issue?

Yes. USB device works after adding that parameter to kernel 7.1.5
> And that's a very old commit, odd that this just shows up now?
It's a headless server. The USB ports are rarely used;
thus it takes a long time for me to notice.

Other people encountered this issue:
https://discussion.fedoraproject.org/t/usb-2-0-ports-dont-work-in-fedora-43-kde-plasma/188113
https://darkranger.no-ip.org/content/rhel-9-usb-%E5%A4%B1%E6%95%88%E5%95%8F%E9%A1%8C

However, their methods do not work for me. 
Toggling "Legacy USB Support" does not help,
and there is no "EHCI Handoff" option in the BIOS settings
