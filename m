Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73337A850;
	Mon, 20 Jul 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561463; cv=none; b=NNSatsPDHSBhvz2Z0pPJ3Fv7ndlTWBSCqvsLulwBslL3kSWDkZujVt5H4QaNO7qdrxRHH/cHR4xlFM+usqvbE2rhhE3ru+4bq/4/pUDwWHL+esORWJbDZii/vi7LpW/yD+5GWJ6gQ3NqjiAHmqJc/rqTBI5T3blkes+cgunHwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561463; c=relaxed/simple;
	bh=1T/+fU4BOb18RNWaYZqrszIYLOLf0njFgGIRGnlW6Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9D7y7u5XdmgQmbAvQt1Jjlgv4ucK2vqMvX/2Fynvov6Uh9NSI0fCvOLid9wQbUKsBBPRdFdE5Z8Nl6QiGxIEwmoOtPweHw9qN+uQR0M+EPaq1LaXol2FpokhDjKhz1m+tJloTtNLpY8C9QDT013dlD70j4xUjO1v4/s+IT+2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tSZhNLyZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSZhNLyZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bc4NQoolZld0IsjePf8E8yoUuXGWRvYzJkp+/BpR1+E=; b=tSZhNLyZSLR0N16TD6j0J5Xsc7
	bUF6ViVOXyVtq6y9WNjeK5D0EF86Yxfj1fC7BqJTZcNH8jPrYsbVBA0Ruxp8NyYlRAfH0qsRvmJW+
	7ismpFu9fxJRpkjkRfWftz+LVKckjIGrIt6GDSMYB3BdolSa+M7n5Zt8P8yRB968CtOBmVdsP+2PP
	iFN6Xhst/M4/tUVTRCNfZPqPZEjLevuCEB5Y2lk37ZGnqMzc/wItWSuAIdUxeAQEVfTom9P7vTe3/
	a9KZUqlRsC/E9cuS+nTDsxttCKCDK8EFpFLjq942TuSSQDVj8KdlgS2Yc3nztKmTep9hX/gYnM1rf
	zCYc4a+g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpxM-00000007CQ3-2FWv;
	Mon, 20 Jul 2026 15:31:00 +0000
Message-ID: <25e056d9-708b-4477-ac63-726e1a01fdd0@infradead.org>
Date: Mon, 20 Jul 2026 08:30:59 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device property: add missing kernel-doc for
 property_entry
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev
References: <20260719223640.2864890-1-rdunlap@infradead.org>
 <al4LwVQ8aLSlP-dk@ashevche-desk.local>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <al4LwVQ8aLSlP-dk@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/20/26 4:51 AM, Andy Shevchenko wrote:
> On Sun, Jul 19, 2026 at 03:36:40PM -0700, Randy Dunlap wrote:
>> Add kernel-doc for the missing fields in union value:
>>
>> Warning: include/linux/property.h:406 struct member 'u8_data' not
>>  described in 'property_entry'
>> Warning: include/linux/property.h:406 struct member 'u16_data' not
>>  described in 'property_entry'
>> Warning: include/linux/property.h:406 struct member 'u32_data' not
>>  described in 'property_entry'
>> Warning: include/linux/property.h:406 struct member 'u64_data' not
>>  described in 'property_entry'
>> Warning: include/linux/property.h:406 struct member 'str' not described
>>  in 'property_entry'
> 
> ...
> 
>>   * @pointer: Pointer to the property when it is not stored inline.
>>   * @value: Value of the property when it is stored inline.
> 
>> + * @u8_data: @value as an array of u8 numbers
>> + * @u16_data: @value as an array of u16 numbers
>> + * @u32_data: @value as an array of u32 numbers
>> + * @u64_data: @value as an array of u64 numbers
>> + * @str: @value as an array of char pointers
> 
> I think the proper fix is to add
> 
> 	/* private: internal representation of @value */
> 
>>   */

OK :)

-- 
~Randy

