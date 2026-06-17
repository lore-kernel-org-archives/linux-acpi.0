Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB8380FDD
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684304; cv=none; b=pke0y9imzIppsG8Z4yzUZ+mQX1VRmPXT+cuUVI9imcHVq7/l2pscqmUaBG565r1PMmrp+UbF+OFqI+1H0cM5QjJGsffRDK/E8BTadTrUdT30yOzyKLFnLaUMX9zVksqeSF5qqU9u8dulLrq7jvX0oA90J11HZ5teBLwAj6VYEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684304; c=relaxed/simple;
	bh=bj1jOiASOALerJwHGRmx8LeqCmWXwupLZjP8M8l4NKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWm6TLbp4LKWjA6N4dSYNLTwnTVWlsUaLejW1lz2o1/3z6UDhPlR6G7wFlJd89BL0gXH6gIaZ+T2avUA13Ne72/yhwl29RHShwZaYFiRQC/laepd+HicZRBYVGUHikQ2HnaZ0FUmPoyRcdtweaqmtuj0BwQgc+t7HcKTj5xWXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3RGHriA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3RGHriA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248231F000E9;
	Wed, 17 Jun 2026 08:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781684303;
	bh=eCsKIA5pi4U3iZjkHuUr7Gn4fcm5pjxWcdisrbxzHLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=o3RGHriAAUJBx27FA57W+YrTkuX5s4DhZQb+T6loZj+gHrmdceGyFBnK5flT88Vuh
	 emAJ9gOE/fCU+76DxSnBqOhyiZ6Ve/Y64hsqboT7kC57wylJIIRMk9apeB+/1cw2Ym
	 gcKVO6shOzKF7YY6t7OlK40ux+ixtMlHXiHOfBvkOvZMnn7dO5q3n94ytWSPTbCd9F
	 6c1SoHunRN+uk9MgffEghX22C9oiF3x1BfE6VfoAdTLQuA1+OY5Xu7WAzN4zojpJM1
	 cLmkd+5aNSGFfL32WuCWYqbbB+oBFGENBYLmkAZ0UYW43LIC3elD6u7IRMXmKhz4KL
	 L1F7A97gmhQYQ==
Message-ID: <d1a5d085-dd0a-41ca-a4ec-f876989ac8d5@kernel.org>
Date: Wed, 17 Jun 2026 10:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ACPICA: Replace strncpy() with strscpy_pad() in
 acpi_ut_safe_strncpy()"
To: Thomas Renninger <trenn@suse.de>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Kees Cook <kees@kernel.org>,
 Thomas Renninger <trenn@suse.com>
References: <20260617075633.534689-1-trenn@suse.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260617075633.534689-1-trenn@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17. 06. 26, 9:56, Thomas Renninger wrote:
> This reverts commit 97f7d3f9c9acb70d4eef7bcdef3218823d142733.
> 
> acpica has it's own safe strncpy function: acpi_ut_safe_strncpy
> and must not use kernel's strscpy_pad.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.com>

Closes: 
https://lore.kernel.org/all/79e9e913-0fb1-4110-804b-c3b5d0edafe4@kernel.org/
Reported-and-tested-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/acpi/acpica/utnonansi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
> index 3a7952be6545..ff0802ace19b 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -168,7 +168,8 @@ void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
>   {
>   	/* Always terminate destination string */
>   
> -	strscpy_pad(dest, source, dest_size);
> +	strncpy(dest, source, dest_size);
> +	dest[dest_size - 1] = 0;
>   }
>   
>   #endif


thanks,
-- 
js
suse labs
