Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595465;
	b=Vx3PzVHe4xYYG9ecfgfusFwUIvx2gBiCHZA7ycHYFMiKpDL5wqGyepESj2Y5ZVTy9GE4
	 IE/pCnIg5Nt1/OepSCTmAbBUh4nhqYyEUvronY48+6nKic8ShaQ/+8cwDrDXPcvYUbWYc
	 f/oHKWklHwHmu17cqu7UK8MOgDbg+vzpRvEJx142XiNqCnnwKZwezPv7BF8Z9jhXN5x1Z
	 SEr9tNzgYerLQVK85uOm/eh0dAh9t63aK2ZxZetr1c3OOA61H7sKdhYMEEtP0HBKHMAIS
	 TsHrM+SdJ+HYV7dXsk1AT6PcGpf8V8Kcv6F+2UDR8pks3u4OJWDdIH49psEdCtSCb4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595465;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ge43eIHUMDj2Nf9HJikyp0YoVqIdxuYhYlKmwDwqUc8=;
	b=Ss9HNrJCsSKV2SRzPNFIwKlJ+zVaQHCFjJDkeQtTji/C/oV/u//X+eHnid7z/EeCdBwE
	 DmuPVzUzYc5o4oXUz8NtlrMollbi/02jdtq4331/hOnzR5n1TuS3J8TPm/1+BCX0axcz9
	 qKDYfbc8vXWYU0YtPyr8m8bbgykAqpvKPZmFIZlVpdwrwpO6Ft4b8qjDqsvWgjOrVT054
	 LqvgUTb6tWWcCN0RELIDz4PHOrsuEzlNRKzvOF5iF6ynZidetR05L8pDRjilbPd3wQv9R
	 Hw7BOVfsjkjXI3eU578q/GEMjMOGiAPy8R9Mg/azqIHfGk8rt4F3Wo7HzrxqAeR+rRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="gZ/TDgzK";
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEAA606A319;
	Wed, 21 Oct 2026 15:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFEAA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gZ/TDgzK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792595464; x=1824131464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gTDFgNaBbiHHvEgqK5fPS/5wgU6d/2pzUAVf1hPnHAU=;
  b=gZ/TDgzKTTdb2pQ59X3YV4msjIoPdKjQ5YxjFcQasRqn58YIGS35uYot
   XJiI9JoNQlWR55lj99PTjx6LVvN8C//hbU5X8sA6gvkUFAlfhB6JZZGd/
   xt6O5oq66HS530NP96//NJlSe7uc12F0QIBL9nFnvc3A71l9V8rgGGw5c
   9GSUhXYGQXxOTGJ+o/uLzsFSx/ebYF6a220i/7bOFudYQMJzRblNp0KjL
   hx7JhQbYLRSNACrQv7ilDIKD1RTktyBfnU4hKzCHGcW9WjmWcZWIxZwcM
   jKROX4wYqnTXvv26KmLQvWv2O3GH3QUO1V+4+GOXZ9oazEAR35o6CvPpv
   w==;
X-CSE-ConnectionGUID: 9K+WimJ6SiyK+veoEDNWaQ==
X-CSE-MsgGUID: u115l8poQ/+rsEHsK8KMcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1224947"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1224947"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:11:04 -0700
X-CSE-ConnectionGUID: Rnwad+ELRdu9zFnFRezKNg==
X-CSE-MsgGUID: NXdZdAywRaq0JFELYkPAAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3451749"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.133]) ([10.125.111.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:11:03 -0700
Message-ID: <68cd9767-3079-4f23-9416-4637815a4a56@intel.com>
Date: Wed, 21 Oct 2026 08:11:02 -0700
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
Subject: Re: [PATCH] lib/firmware_table: validate subtable bounds
To: jiale yao <19888972804@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261016144154.2818962-1-yaojiale02@163.com>
 <20261016161547.bc418897d11f3f19924065b4@linux-foundation.org>
 <10926256-ce32-4403-9f45-84f42fefe29c@intel.com>
 <748c0fc7.9d0c.1a15efdf1bc.Coremail.19888972804@163.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <748c0fc7.9d0c.1a15efdf1bc.Coremail.19888972804@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/26 8:04 AM, jiale yao wrote:
> At 2026-10-19 23:29:57, "Dave Jiang" <dave.jiang@intel.com> wrote:
>>
>>
>> On 10/16/26 4:15 PM, Andrew Morton wrote:
>>> On Fri, 16 Oct 2026 22:41:54 +0800 Jiale Yao <yaojiale02@163.com> wrote:
>>>
>>>> The generic firmware table walker dispatches matching entries after only
>>>> checking that a generic subtable header is present. A record whose
>>>> declared length is shorter than its header or extends past the table can
>>>> therefore reach a handler before its bounds have been established.
>>>>
>>>> Validate the complete generic header and the declared record range
>>>> before looking up or invoking a handler. This also rejects zero-length
>>>> records and prevents malformed lengths from advancing the cursor outside
>>>> the table.
>>>
>>> Thanks.
>>>
>>> get_maintainer is quite unreliable with lib/ files.  Please always use
>>> git-blame when determining who should be cc'ed.
>>>
>>> Dave, can you please take a look?
>>>
>>>> --- a/lib/fw_table.c
>>>> +++ b/lib/fw_table.c
>>>> @@ -172,7 +172,20 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>>>  	    ((unsigned long)table_header + table_size);
>>>>  	subtable_len = acpi_get_subtable_header_length(&entry);
>>>>  
>>>> -	while (((unsigned long)entry.hdr) + subtable_len < table_end) {
>>>> +	while ((unsigned long)entry.hdr < table_end) {
>>>> +		if (table_end - (unsigned long)entry.hdr < subtable_len) {
>>>> +			pr_err("[%4.4s] Invalid subtable header\n", id);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		entry_len = acpi_get_entry_length(&entry);
>>>> +		if (entry_len < subtable_len ||
>>>> +		    entry_len > table_end - (unsigned long)entry.hdr) {
>>>> +			pr_err("[%4.4s:0x%02lx] Invalid length %lu\n", id,
>>>> +			       acpi_get_entry_type(&entry), entry_len);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>>  		for (i = 0; i < proc_num; i++) {
>>>>  			if (acpi_get_entry_type(&entry) != proc[i].id)
>>>>  				continue;
>>>> @@ -186,16 +199,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>>>  			break;
>>>>  		}
>>>>  
>>>> -		/*
>>>> -		 * If entry->length is 0, break from this loop to avoid
>>>> -		 * infinite loop.
>>>> -		 */
>>>> -		entry_len = acpi_get_entry_length(&entry);
>>>> -		if (entry_len == 0) {
>>>> -			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
>>>> -			return -EINVAL;
>>>> -		}
>>>> -
>>>>  		entry.hdr = (union acpi_subtable_headers *)
>>>>  		    ((unsigned long)entry.hdr + entry_len);
>>>>  	}
>>>> -- 
>>>> 2.34.1
>>
>> Can this turn a previously accepted table into a fatal parse error? My
>> main concern is breaking previously tolerated behavior and we end up
>> breaking deployed systems. Given this code has been around a long time.
>> Maybe Rafael or Len can comment.
>>
>> The old loop stopped quietly when subtable_len or fewer bytes remained
>> after the last entry. Here subtable_len is sizeof() the subtable header
>> structure, 2 bytes for MADT or 4 for CDAT, not the entry's length field.
>>
>> Now fewer than subtable_len leftover bytes return -EINVAL. Exactly
>> subtable_len leftover bytes are read as a header, and fail the entry_len
>> check below unless they happen to hold a valid one. A table with a few
>> bytes of padding after the last entry now fails the whole parse.
>>
>> On x86 that error is not contained to one entry type:
>>
>> early_acpi_process_madt()
>>  early_acpi_parse_madt_lapic_addr_ovr()
>>    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE, ...)
>>      -> -EINVAL
>>
>> 	if (error == -EINVAL) {
>> 		...
>> 		pr_err("Invalid BIOS MADT, disabling ACPI\n");
>> 		disable_acpi();
>> 	}
>>
>> Would it be safer to keep tolerating leftover bytes too small to hold a
>> subtable header, and reject only entries whose declared length is
>> invalid? The loop condition can end the walk in that case without a
>> separate check:
>>
>> 	while ((unsigned long)entry.hdr + subtable_len <= table_end) {
>> 		entry_len = acpi_get_entry_length(&entry);
>> 		if (entry_len < subtable_len ||
>> 		    entry_len > table_end - (unsigned long)entry.hdr) {
>> 			...
>> 			return -EINVAL;
>> 		}
> Thanks for your review,
> how about this one, https://lore.kernel.org/all/20261021150159.399043-1-yaojiale02@163.com

LGTM
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Jiale

