Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D05581F7;
	Tue, 22 Sep 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090262; cv=none; b=T0O25ZtgIYWEeunEchxFNdc84BqdTFZ/dumgsUQMrvgphl07a1aKLc8YjOFsTR4N9DiNQUIpPTyXfSdE/aZUJaXA9Ntp17UYcszbN8Yv0/Jk0ZOXZwtlRUvi0Xv1RQ/TtmS/1hjssIv9i25qolJupFXlSeTfmhajzNGnYeoVlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090262; c=relaxed/simple;
	bh=WJQlexOEFB2+rLfSFe39873Vz8dqsCQdE/Ket6GyZWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8udFSj5E2qoZnNTwzdRi399XWi0SZeGFkmt6py+urAVnjcJpJU58aBh5WgVrXMi/aKHwqgkznxw1RE8lvpErwcXr3q9t+UY9OjdUBpzdW9eesDLZSclNs1RI4v3JF5vHIPenPNZRr/HmaVfz1yrLDxoM1e9SfoeFx90TuNqeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rbbtwE1o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rbbtwE1o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAA3E1576;
	Tue, 22 Sep 2026 08:17:35 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3B5E3F86F;
	Tue, 22 Sep 2026 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790090259; bh=WJQlexOEFB2+rLfSFe39873Vz8dqsCQdE/Ket6GyZWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rbbtwE1ovFBalioA6W+2gPtB+Lf+eeY2UhEbfO4cyQAl6aEdNz/ibBXCm8yq2qud/
	 4Louz5/9Gmmuqn+m4/QJHqLBdKAqr3l3GaqDV/UlaAGU2bLOrCwwsvMCkOhwAMZ9FL
	 QonY6Pasx3dWe8xeQ5MvLOTFa1SK5C7RpOGceWT4=
Message-ID: <7d0fa712-bbc4-441c-90c2-38e9faeee228@arm.com>
Date: Tue, 22 Sep 2026 16:17:37 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: Provide !ACPI stub for acpi_device_uid()
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <513319f19ed6b0b6d4c76dc517074531966b98f5.1789745223.git.robin.murphy@arm.com>
 <CAJZ5v0j72dht4wiVcoFmk2Rt1pvPL7Yrr_29jihzfKAb3Pu24g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAJZ5v0j72dht4wiVcoFmk2Rt1pvPL7Yrr_29jihzfKAb3Pu24g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/09/2026 12:40 pm, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 18, 2026 at 5:27 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> While the likes of acpi_dev_uid_to_integer() and acpi_dev_uid_match()
>> already have stubs for !ACPI, the basic acpi_device_uid() getter does
>> not. As with acpi_device_hid(), add one for the convenience of portable
>> drivers who just want the string itself - in fact they are so much alike
>> that we can simply alias the exact same stub definition.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   include/acpi/acpi_bus.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 1a45e0d521d8..ed309ea4785d 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -963,6 +963,7 @@ static inline const char *acpi_device_hid(struct acpi_device *device)
>>   {
>>          return "";
>>   }
>> +#define acpi_device_uid acpi_device_hid
>>
>>   static inline bool
>>   acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
>> --
> 
> Sashiko has reservations that look valid:
> 
> https://sashiko.dev/#/patchset/513319f19ed6b0b6d4c76dc517074531966b98f5.1789745223.git.robin.murphy%40arm.com

Oops, indeed apparently I missed that acpi_device_pnp::unique_id isn't 
actually const - it probably should be IMO, but that would be a whole 
other patch.

FWIW I can't see that the return value itself actually matters here 
since !ACPI code couldn't have a valid acpi_device to legitimately call 
this with at runtime. In fact even for compile-testing, references 
should usually be under a condition like has_acpi_companion() which 
would lead to them getting DCE's under !ACPI without needing the stub - 
this was really just for completeness to shut up annoying Sashiko noise 
on that point.

Thanks,
Robin.
