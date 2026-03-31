Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCA2C21DD
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936189; cv=none; b=sfb9uGQGFhu+syskEc4euowtCmcWbYArWBz4T1oRB0GYEu1s+7Z84ry7Pnb0eFjx5mbYfg2XGXGhbG6HvVu0prcwB5lt1sIt0nyW93R2Fwy6BNfWC2uDUO0t6Xh7DeFdl5WOIXLqVo7vzuOkogiffUUspEXrd3bcX6lzvqHz3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936189; c=relaxed/simple;
	bh=s8uPxYPuNODo2d+i6hzGWmLatHFJixudqC42WwqrVl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwHPGfWAI4tFE0AUygWMoJ2olx/+6ZF8YwefVLR7c10Tp2TFDCSsdtlWJhTD3wbOIQ4igo7BNi/+fPwq2SlIXMuRyIg69w6L+FsR5GR9gX2fZL/WP95pkXdt35KlRtkS/sUQUagfwly+mHBOAKy23joz7r3kIKYdGeizl7o5xAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRZOfr5z; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRZOfr5z"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c156c4a9efso5057013eec.1
        for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 22:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774936187; x=1775540987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ZalXvRcEM7eynFKSA3Ox/Wlzblw8FW9y63x9o9NVw=;
        b=bRZOfr5zAIt3Ya7vBvT+HufIw5Afyn4RGp4f1HMs3VlNN1qhlEXre7q6iyxMT/7ucZ
         l68H/kkFBBqLmCmIUVUkN8Ebw6NcwVVt5++aaoXw8VDhwvjrmXFn8tVBAG8WlszUOnh4
         F/YtNDxlL4DSp5UIn8us9AG2W02NZ4kSWGGE4VIuZDwMcfuQ2GRZNEe9oupLFo57hvnT
         YNsz+HrIhKATnCdRHHASByGmfg82rwgXIovf+db7/sa2ny0/wLpgdeSf0BXABKbizrw0
         vFbT07sOab+UyUAtYMqFZFJhmJIydFMWMvmbb8cgPFHKjPfKcBxBj9porHH/V+JHevgn
         EPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936187; x=1775540987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6ZalXvRcEM7eynFKSA3Ox/Wlzblw8FW9y63x9o9NVw=;
        b=k+YAfTPNckPUl04qiFI17C8Y5xv3GltKgVV42HYF+mA5223GeqjDO8du/29+aEMT7Q
         Ktq94W0+birM9+/yutQApi1KLX16XPa08rJBzQzrU5QjARrzORlmYRxpzPq5aUq/oRwX
         Icu5Z+WUtHcptUt53DD8yjZxgMDe23rOrdkL4zlbIkl5DLvXBE0uKdIHNiA0no2fmTmG
         /JlMGZBZKkpDM9yDJlogElFWhkQ1eLT46JB+4ctYNje4he6AiSGxmW85iRzyNUomisQZ
         fTYPy6ZQ6qKVTeD0JMs711XXarT5EWr6m5NmFpskylGmy2RnWuB2+/a8wsZ+K7BixgV9
         3fjg==
X-Forwarded-Encrypted: i=1; AJvYcCWrgN/xWm4q37vWfIeWdku7he3jqtxoDrdKN8avodMIzH6d9sYXJ+nUZBIKWAFOnLALPl4cPVLPAGu+@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXsAcqd1pVL6kFj5u5LIef8O8YnfAOaQu0srh8dEucwZQ/5Tx
	uXF0sLt1WdWABqFMI/wd9shBlGTEeF2SRIICzG3MheKaXLA2nqF03cxN
X-Gm-Gg: ATEYQzxxNgo6BOioGnidvnCxbt1kIXCiuz4ZQbsDbOOK0Eah2IMCspDqVT24fnZ8fc3
	SIC90DD8iC6fhtwabNs0DtcaZz7AaQq8cX51SsU1EMoSc23VzA1/FCWfRLvOLFJs0dyD5JH5fTZ
	4nEKysQAk0hif+TUt9kK3VG0Hxd5Idw0oP0pPdgiz0H9vqgnuGGxfc15v0XR0mB6/mCA0Jmj7nj
	2SKmjtcFGTyLF50GEoRWr7HtelkrHqLX5vyLB7q6AoMLN8+h07HuSy+iXW8vMLEpqAd6Jrd/gZd
	PSnGhmPRuxsVF0g6e9AadgM+eQSHxqM6BSLgcCXL4bDyxhQcaKcYrko/aRN8TyfF9iUsjsID0cD
	BTEFkSGgWUtHx0sT2KrLe4UeJCMkNN+P3OOVfx0mUkAalUotAO8v1uMVm5nwZt1b4zAj4zhP4/t
	nXFMXWW4MHAuwgz1IVPXtFjSnyDu+QfFzP7r8rOTP9WYnfGfUsUEJ8t8dWCjmnpEoR
X-Received: by 2002:a05:7300:e60b:b0:2c1:85a:d25d with SMTP id 5a478bee46e88-2c185d74157mr8785111eec.1.1774936187043;
        Mon, 30 Mar 2026 22:49:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7f4e:2749:b37a:e9d5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm9275122eec.6.2026.03.30.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:49:46 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:49:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86/geode: fix on-stack property data usage
Message-ID: <actgKlES7sfLk16q@google.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>

On Sun, Mar 29, 2026 at 07:27:48PM -0700, Dmitry Torokhov wrote:
> The PROPERTY_ENTRY_GPIO macro (and by extension PROPERTY_ENTRY_REF)
> creates a temporary software_node_ref_args structure on the stack
> when used in a runtime assignment. This results in the property
> pointing to data that is invalid once the function returns.
> 
> Fix this by ensuring the GPIO reference data is not stored on stack and
> using PROPERTY_ENTRY_REF_ARRAY_LEN() to point directly to the persistent
> reference data.
> 
> Fixes: 298c9babadb8 ("x86/platform/geode: switch GPIO buttons and LEDs to software properties")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

While we are discussing with Andy patches 2-4 maybe this one can be
picked up? It does fix (I hope)(I hope)  a real issue in the field.

Thanks.

-- 
Dmitry
