Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE83DC4C9;
	Thu, 27 Aug 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819137; cv=none; b=fZo9VrhEOqopnIYAQPnsGIEd+STipBKi68D8VLDox6FgDZXpVYayqx0lQcI0Llmpicw05B7dqwT/EEyCx6qLD63Q873qeJZBnERjdUtyC/Bpr0lHMIPUYYkH9AYm71yzA6cqcm5q7mM7lxdePZpME3MluDQaq55SZnBehkOUKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819137; c=relaxed/simple;
	bh=WfWuG5f6Q4mcQI7yw1Kum7F2uTU4MHruQ3BxN2a6InY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8N1Awi+oTNM9jaizJ3HkapWTsFdHPiFeKXr/riZprZ422sc3FM0KoppjNEN7hxNnyCXwhFmDC9ldW8v9l7qpyygUr8LIOH4cJBVymaP3ZtdBdmDvQjH3I0e3yywCV1IvFPTq5QLXPApdimTiDV1GO0GJaASRLAvsLPzBHFNLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AJUt/+sp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AJUt/+sp"
Received: from [192.168.68.124] (unknown [149.106.186.222])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 87AB9227;
	Thu, 27 Aug 2026 10:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787819040;
	bh=WfWuG5f6Q4mcQI7yw1Kum7F2uTU4MHruQ3BxN2a6InY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AJUt/+spht9tWD6EAkyKOd1XqYf68RYKMpJvrZMdU6K8HBk+JHzZNoeix0zlLuxoW
	 ja74V/GXIOsJ7DxGyrg0FT8ZDMNFGv43eIetcqG+uuo3wjBTXP91+PXkxFaZ5aGHUO
	 Qpm88e/0otT7tpUZUdmawDoXoooj2prvOqZwS6Rc=
Message-ID: <7356012b-b5aa-4d11-8dbe-30cd82dfe3b8@ideasonboard.com>
Date: Thu, 27 Aug 2026 09:25:20 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] platform/x86: int3472: Address Coccinelle warning
 on an error print
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <20260825203553.3725132-1-sakari.ailus@linux.intel.com>
 <20260825203553.3725132-2-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260825203553.3725132-2-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sakari - thanks for the patches

On 25/08/2026 21:35, Sakari Ailus wrote:
> Fix the following Coccinelle warning:
> 
> ./tps68470.c:164:58-65: WARNING: Consider using %pe to print PTR_ERR()
> 
> by using %pe specifier for printing an error code.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   drivers/platform/x86/intel/int3472/tps68470.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
> index a77ed32abe55..dc777dbac61f 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470.c
> @@ -161,7 +161,7 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
>   
>   	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
>   	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to create regmap: %pe\n", regmap);
>   		return PTR_ERR(regmap);
>   	}
>   

