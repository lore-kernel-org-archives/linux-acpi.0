Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645573;
	b=Uq8D7leiJ+R5TMC85BM1trk5GUNTFxpjWMbsQ2/cz6x6tD63jNOR2UR1LWs3KTz/OAQj
	 uDwTxixHLunSVGEK6BmYgxW5TazacJjPJ4NGIh/CVaZQa/3yCmHrHIx1kS21JonYCvEVD
	 fOkglR40bhnfgv81TeZeAkvx5fEh0e/jonfCczu7N8bBQz2EJYUDjtcETqbvLl9AURZE0
	 phIN3alIH2ufMel3Ch8hv3uJQES61K0+ttZgEkscgMjAdPdlU4NheJJht1ajUoePI3/BP
	 J6YZgYAYpOxe4UILYXyF+3GYiVSECL5aC4Zvc+965kz7PYbQt8LhkYNIG+GRcD8bYUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645573;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GOlTtxoLjmhi9GWN4jeIxFdH6/5f9rXla0tb49Wzau0=;
	b=z5anw+3TCmfRNZJc33K3WlXay2KriJUvhNkP7ewJo2ax7J1XQ96xGJ6jPxjSXJYEvzuL
	 sFPII9IBeytihRgpiKV9tX3vjefw3kn18xsDUTO0EO/uzNkGMEXy8+8S+Yle8RSqdH4mX
	 kODuREWxZn6bz+FJjhJjiMOjNOOq5HsSSOdJTsA+cKfHZF+ri1Ey+NDxVOase40H20yUb
	 bYlBiqVwY9ILV0FUP35xyrrrknAwLZisBgBm6kz2zGYFpBaPh6rva9dJC5DSRtz7f0mhg
	 4EdF2Ygo5/01BO8TLu6jeG9EtUk7s2AyeqsaAdQxaVYp4R4LVocnE8dy67cPEjPYVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QNDhXAX9;
	arc=none smtp.remote-ip=95.215.58.228
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B9606A6A8
	for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2026 22:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F1B9606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QNDhXAX9
X-Envelope-To: linux-acpi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zD8sKd+VxbbCz7vjRU8Ivea6I/NBp6c1QiP6Kcvw3oc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795645570; v=1; x=1796250370;
 b=QNDhXAX9i3yNi/2qS39AsXZ3+mBkVpy0OgI2tLIzlE5DEWIoPHqV1Rnv+QxKfcw9wOcOb5B/
 1jSVPQL4wxYuZFNhlv5jo6eXfAjin0/HDDGzW5hEqvrNkue/re6gxqnPqI43kpEND3aSPSksqPN
 eUYqrGEkcqA1RW/Hui/0lEc4=
X-Envelope-To: linux-acpi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5507a07e32284521;
	Wed, 25 Nov 2026 22:26:10 +0000
X-Mizu-Trace-ID: 5507a07e32284521
X-Migadu-Flow: FLOW_OUT
Message-ID: <94785b4d-c807-4465-84a1-25ae317df4b8@linux.dev>
Date: Wed, 25 Nov 2026 23:26:07 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
To: Daniel Dadap <ddadap@nvidia.com>,
 =?UTF-8?Q?Riccardo_Zangh=C3=AD?= <riccardo.z.dev@gmail.com>
Cc: Armin Wolf <W_Armin@gmx.de>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "hansg@kernel.org" <hansg@kernel.org>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "luke@ljones.dev" <luke@ljones.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev>
 <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
 <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com>
 <DSVPR12MB66402023AE5250384B26515942BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
 <CAMnz_-C02J6CznPD68GgWCPCWEDSGsq6hoC+AJhsZjw39H+hhQ@mail.gmail.com>
 <DSVPR12MB66402044074D6A8B1EDC584825BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <DSVPR12MB66402044074D6A8B1EDC584825BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/25/26 23:14, Daniel Dadap wrote:
> On Wed, Nov 25, 2026 at 07:03:18PM +0100, Riccardo Zanghí wrote:
>> On Wed, 25 Nov 2026 at 07:13, Daniel Dadap <ddadap@nvidia.com> wrote:
>>> So, as an experiment, if you could read the LSb at physical address
>>> 0xFEDD83B8 in both iGPU and dGPU modes, and report on the value, that
>>> would help.
>> Hi Daniel,
>>
>> Thanks for the detailed analysis. I believe I received your full message by
>> mail.
> Right, I only got bounces from the lists, not the individual recipients, so
> you very likely got three copies. (Sorry.)
>
>> Result of: od -An -t x1 -j $((0xFEDD83B8)) -N 1 /dev/mem
>>
>> integrated mode:              4a  (bit 0 = 0)
>> dGPU mode (gpu_mux_mode = 0): 07  (bit 0 = 1)
>>
>> So G40C does differ between the two modes. I can try the DSDT
>> override next and report back, or test any other patch.
>>
> Yes, I think doing the DSDT override as the next experiment makes the most
> sense. The ASL should be amended to read:
>
>> If ((MODF == Zero))
>> {
>>     If ((^^SBRG.EC0.G40C == One))
>>     {
>>         Return (One)
>>     }
>>     Else
>>     {
>>         Return (0x02)
>>     }
>> } 
> which I suspect will reflect the design intent better.
>
> You could also try patching the kernel instead, maybe with something along
> these lines (completely untested; you'll need to supply your own DMI ID
> strings from your machine's SMBIOS):
>

I can ask ASUS to try fixing things that are out of spec, but we have to
prepare to the eventuality that it won't get touched.

An ACPI override means secure boot won't work on these models,
so despite being (probably) the best thing to so it has its own downside.

> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -131,6 +131,44 @@ static int video_detect_portege_r100(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +struct video_detect_runtime_dependent_data {
> +	phys_addr_t address;
> +	u8 mask;
> +	enum acpi_backlight_type backlight_type_if_true;
> +	enum acpi_backlight_type backlight_type_if_false;
> +};
> +
> +static struct video_detect_runtime_dependent_data asus_a16_dmi_drvdata = {
> +	.address = 0xfedd83b8,
> +	.mask = 1,
> +	.backlight_type_if_true = acpi_backlight_native,
> +	.backlight_type_if_false = acpi_backlight_nvidia_wmi_ec,
> +};
> +
> +static int video_detect_runtime_dependent(const struct dmi_system_id *d)
> +{
> +	const struct video_detect_runtime_dependent_data *data = d->driver_data;
> +	void __iomem *map;
> +	u8 val;
> +
> +	map = ioremap(data->address, 1);
> +	if (!map) {
> +		pr_warn("Unable to map backlight selection register at %pa; skipping quirk\n",
> +		       &data->address);
> +		return 0;
> +	}
> +
> +	val = readb(map);
> +	iounmap(map);
> +
> +	if (val & data->mask)
> +		acpi_backlight_dmi = data->backlight_type_if_true;
> +	else
> +		acpi_backlight_dmi = data->backlight_type_if_false;
> +
> +	return 0;
> +}
> +
>  static const struct dmi_system_id video_detect_dmi_table[] = {
>  	/*
>  	 * Models which should use the vendor backlight interface,
> @@ -986,6 +1024,19 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>  		},
>  	},
> +
> +	/*
> +	 * This notebook is supposed to select the backlight control device
> +	 * based on runtime state readable from the EC's MMIO region, but
> +	 * ends up requesting the EC backlight driver regardless of the state.
> +	 */
> +	{
> +	 .callback = video_detect_runtime_dependent,
> +	 .matches = {
> +		 /* XXX supply appropriate DMI_MATCH() macros here */
> +		},
> +	 .driver_data = &asus_a16_dmi_drvdata,
> +	},
>  	{ },
>  };
>  
