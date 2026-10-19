Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423800;
	b=JlgFqLef7UP2AqRaAlSWQcRtb4WMO4/eghyYSN3I8arly4iwdEisAlHDw51R5OsDCWAs
	 rpn0ELy+LfIf2s3b1TDHpHPcu8+gSwDeYJczuYGQ2Uu5o06iVebY0MWl8lzu9nqX/Ik6n
	 K6/0nvrZyVhVEoY2JqVIj+TCJpXfznq0EM2LXulGfVCPqFnFwNBY6ZGniR3WAmKLVgON+
	 7l6HLDTvDaDrmsqkteCVPy5gHJNBwA8PuHtPQ69dGZaa20ldRrVVdAxIc18TcdEfOTwGH
	 pmC9ZSfUsuNHuWLaQjO6pSrHcEzz0j7eisvAxHGaTuIm07Svfdx6Dl6hY96rQr2TZFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423800;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0Ox1Ujdl0kmFVWRH+4ko0JaFVUrXfqFPovWffpVTDCo=;
	b=NdFLwFHT4BcknExBX7g3nsoZi8N9hAMo+vUWRUy4iHUgXKn2LWhLS3pearQci/owrqG2
	 pM/2VmaUUtEjbI9NKQ81LaIfqL78L/4RNrjgOVOlY0x5aDFxwqxhdn8F0uzRnsYZG5Vf3
	 XxBUUTcgxzoZEHrwwzZr0yaF/xwNY5q4ch22DRYDcLcLYhj4DQ6QZP4W6yJv6oCwBTn0s
	 vCbWc78qxLvrg0fDfqc5/zUt+3qmSRpPE1+ilri6oiy6Aj9sm6S6vErIa2i8f5k/whBQQ
	 haZKrdV7AIJlFb94f789vQMo3Bng0m22hGueNIgmne0lJ+oBHicn4jxiv8R0J+UPRQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OODeuySA;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918560AA0E5;
	Mon, 19 Oct 2026 15:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2918560AA0E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OODeuySA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792423799; x=1823959799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4HUTwF3X/nk9CqMhpUFjBBN8tlgbBBBRcj4Saukig+c=;
  b=OODeuySAyMCDN6xG60T6ucP5udB2u4DtCjWybqCn5bhMuAH7jWsZjary
   /j8ntOlMzI7+7M1qAl9xFrXWFR19YYhdXC/DCydAh6tzHUJShjAh9kx7W
   ccTAAvZi913kyMSyYuaXlVbXaGbzfXHYaKUMKDAePZuwdQVWwVWKR4UgW
   yS11ygp4vlgaM94zlMcgQT+wUZk6ExwSZU4l60VcgkPBooZSqpFdJOgc1
   GNNyQwaKrCWd9tmdTlSEhRNJfDOp5Y8Qkug0UvBwWNI3CMhYqzMYD23Ns
   0DHVipGBTcQaXmgC+hEDIhUinEf+I9ZAh/DL9RoyeK3px3ktlBYE7Ii5q
   A==;
X-CSE-ConnectionGUID: fvbJsdvuTZOnYO0wgLUkyQ==
X-CSE-MsgGUID: NJKXbFNWSeqyxIWoNiAnOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1135097"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1135097"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 08:29:58 -0700
X-CSE-ConnectionGUID: hStl7rhfQ/uTrFFTcemNAg==
X-CSE-MsgGUID: WyuNNWzgTFuNBVqI/0Qigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2985550"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.28]) ([10.125.111.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 08:29:58 -0700
Message-ID: <10926256-ce32-4403-9f45-84f42fefe29c@intel.com>
Date: Mon, 19 Oct 2026 08:29:57 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>, Jiale Yao <yaojiale02@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261016144154.2818962-1-yaojiale02@163.com>
 <20261016161547.bc418897d11f3f19924065b4@linux-foundation.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261016161547.bc418897d11f3f19924065b4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/26 4:15 PM, Andrew Morton wrote:
> On Fri, 16 Oct 2026 22:41:54 +0800 Jiale Yao <yaojiale02@163.com> wrote:
> 
>> The generic firmware table walker dispatches matching entries after only
>> checking that a generic subtable header is present. A record whose
>> declared length is shorter than its header or extends past the table can
>> therefore reach a handler before its bounds have been established.
>>
>> Validate the complete generic header and the declared record range
>> before looking up or invoking a handler. This also rejects zero-length
>> records and prevents malformed lengths from advancing the cursor outside
>> the table.
> 
> Thanks.
> 
> get_maintainer is quite unreliable with lib/ files.  Please always use
> git-blame when determining who should be cc'ed.
> 
> Dave, can you please take a look?
> 
>> --- a/lib/fw_table.c
>> +++ b/lib/fw_table.c
>> @@ -172,7 +172,20 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>  	    ((unsigned long)table_header + table_size);
>>  	subtable_len = acpi_get_subtable_header_length(&entry);
>>  
>> -	while (((unsigned long)entry.hdr) + subtable_len < table_end) {
>> +	while ((unsigned long)entry.hdr < table_end) {
>> +		if (table_end - (unsigned long)entry.hdr < subtable_len) {
>> +			pr_err("[%4.4s] Invalid subtable header\n", id);
>> +			return -EINVAL;
>> +		}
>> +
>> +		entry_len = acpi_get_entry_length(&entry);
>> +		if (entry_len < subtable_len ||
>> +		    entry_len > table_end - (unsigned long)entry.hdr) {
>> +			pr_err("[%4.4s:0x%02lx] Invalid length %lu\n", id,
>> +			       acpi_get_entry_type(&entry), entry_len);
>> +			return -EINVAL;
>> +		}
>> +
>>  		for (i = 0; i < proc_num; i++) {
>>  			if (acpi_get_entry_type(&entry) != proc[i].id)
>>  				continue;
>> @@ -186,16 +199,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>  			break;
>>  		}
>>  
>> -		/*
>> -		 * If entry->length is 0, break from this loop to avoid
>> -		 * infinite loop.
>> -		 */
>> -		entry_len = acpi_get_entry_length(&entry);
>> -		if (entry_len == 0) {
>> -			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
>> -			return -EINVAL;
>> -		}
>> -
>>  		entry.hdr = (union acpi_subtable_headers *)
>>  		    ((unsigned long)entry.hdr + entry_len);
>>  	}
>> -- 
>> 2.34.1

Can this turn a previously accepted table into a fatal parse error? My
main concern is breaking previously tolerated behavior and we end up
breaking deployed systems. Given this code has been around a long time.
Maybe Rafael or Len can comment.

The old loop stopped quietly when subtable_len or fewer bytes remained
after the last entry. Here subtable_len is sizeof() the subtable header
structure, 2 bytes for MADT or 4 for CDAT, not the entry's length field.

Now fewer than subtable_len leftover bytes return -EINVAL. Exactly
subtable_len leftover bytes are read as a header, and fail the entry_len
check below unless they happen to hold a valid one. A table with a few
bytes of padding after the last entry now fails the whole parse.

On x86 that error is not contained to one entry type:

early_acpi_process_madt()
  early_acpi_parse_madt_lapic_addr_ovr()
    acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE, ...)
      -> -EINVAL

	if (error == -EINVAL) {
		...
		pr_err("Invalid BIOS MADT, disabling ACPI\n");
		disable_acpi();
	}

Would it be safer to keep tolerating leftover bytes too small to hold a
subtable header, and reject only entries whose declared length is
invalid? The loop condition can end the walk in that case without a
separate check:

	while ((unsigned long)entry.hdr + subtable_len <= table_end) {
		entry_len = acpi_get_entry_length(&entry);
		if (entry_len < subtable_len ||
		    entry_len > table_end - (unsigned long)entry.hdr) {
			...
			return -EINVAL;
		}
