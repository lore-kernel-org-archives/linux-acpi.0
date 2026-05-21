Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB43DA5B7;
	Thu, 21 May 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371596; cv=none; b=n+xEdObmZ3U03SsnnLzP4vC4VbH29UGGTqCy6EvWovgKyrjVh48RzhHWjup74Bxyd4v60N42TrowOhHO0Gogp6U0ZDY51wQIMYwe/C3w6diZfE6drdBaskzlidpTR3KEf5u8Be0bafNIcJ9iT1AkZu+1YZZEEasAESivV3eN80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371596; c=relaxed/simple;
	bh=DM0OQCG3XM6GkiKqFBgashnkjtR6oQuB3UVuyvzgp84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ47bDtyivtcsuaS+cf+WsnXeFiKd4XiBbQ2xgqLaLS4krc8IDaVLbUyWZFtPLWS7tdYQdy5qD6joRbDUMLrSDGblD20jhFBHRchKcqrQb7ujdw2TdzetN9DjwAL2sZLjknk0PFf8eAIGNq9LKfAartPSHh/Z/LwCSicSGbWCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6rO1sTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6rO1sTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9303B1F000E9;
	Thu, 21 May 2026 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371594;
	bh=xm5eI+pkENaoq5qFFokJNXYM4OoEK8n9Ip4oUUHDN9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z6rO1sTu2UwPavL4H/MTXAglkUPFpwkIoUxf5oqh8KUkVDTmEgvUDOs6FS8EJqXBv
	 3GOI81A9UYLZsPd6w9tLPrK6Sfsq4mH71LXVRR8xhfd+5nTwLX0QD7Mm48ZZatE2D6
	 WiMVTky4qv9bp3uR7o7jdGHmcs49CIPe2YBRI7/+dp2O063DFHoatb26lnqLOjmWP0
	 DBsLdDXzBEf/u5WP+LQzuhLVUPKsRa4mo4i4eo9CG4tJPTXbixscW/tx0hBaKz/5KO
	 NAFuBwuMQ5nbxvueTIk+QG3i5fWT+oxX1VwSiSsS5b9U/fwQrWYuy6heXggFmiKOYb
	 pPESvh95Ijy7g==
Message-ID: <43ff0ff1-22e7-42f1-a370-8119056e2309@kernel.org>
Date: Thu, 21 May 2026 08:53:12 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] ACPI: button: Add missing device class clearing on
 probe failures
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
References: <5996185.DvuYhMxLoT@rafael.j.wysocki>
 <3046699.e9J7NaK4W3@rafael.j.wysocki>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <3046699.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/26 08:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit e18947038bf4 ("ACPI: driver: Do not set acpi_device_class()
> unnecessarily") modified acpi_button_remove() to clear the device class
> field in struct acpi_device on driver removal, but it should also have
> updated the rollback path in acpi_button_probe(), which it didn't do,
> so do it now.
> 
> Fixes: e18947038bf4 ("ACPI: driver: Do not set acpi_device_class() unnecessarily")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/acpi/button.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -687,6 +687,7 @@ err_remove_fs:
>   	acpi_button_remove_fs(button);
>   err_free_button:
>   	kfree(button);
> +	memset(acpi_device_class(device), 0, sizeof(acpi_device_class));
>   	return error;
>   }
>   
> 
> 
> 

