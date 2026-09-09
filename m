Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CB57ED98;
	Wed,  9 Sep 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969830; cv=none; b=DPfL/bADvKPeXo5m4+azPW+tC1BYlQidbe+1iTC6JpQUMqPrMCTqLLMTEsH4Tv7WpGy3XHSwbEbryd0rnTtQp2znr597JyrHZMR3XSf5fJOi1s3sklYLu4aIRb/HuLEVVRh0QPjFMMQDi1+oTuYGfDyuhvZn1aloQ9ZNMfzs+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969830; c=relaxed/simple;
	bh=c9NqLg6Yn6AnzBlRYM1XDFEzegqRQkO/9VyLHbpBlTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lciEeFCDtQItYP+X6nmRqwVfzFYkON1RqyOdVCZUp+7g1HSXZyRl4fQPoshHG/L7sP8IrMycOcvZh7YKGQGihehXI3N0qhrxPM7X58cY59ZrS/5KNzGL0LndCx2/K2xrboAYRKHvOhI8OVmFHjjknGeGlfjDIONqg6iLZGddFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvSm52B9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvSm52B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06BE1F00A3A;
	Wed,  9 Sep 2026 16:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969828;
	bh=OX6FrUZ8cTdJayq48jS2CIaaaz7PuLHMGIF/xlZ/rSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HvSm52B9HoHrizk+RsrfdgdcKwepmWbkdl8jk34/lMXDl9VA+nJiFaRyd3CERHfDv
	 zsU6w3THyvu+ichhp5XoImtGPv2LPvLG8k+0d+PsxHQ6OAygsZL5V/zqyljLNIIwhh
	 QT2AQq4hANN8b6e2F/dFV0cTMpldbpDFNnjNglf2p41M/hBzwqMXltid9oL6O6ytRY
	 6J9lohCIDVxO5jh5dSsuL4LUPQmehjhb/NQxGj8veYE38MLwpu+k5OzrXPXq6mKWwR
	 v3hlTyFNeIxwgo2XAuAhMBjv6mrENninYrzJqGTCX7s/DVpAWSv55GG+mLGhvn3Pj9
	 kc6U2w1UBREgA==
Message-ID: <67885235-8a79-4899-8639-1fe68d93dfd3@kernel.org>
Date: Wed, 9 Sep 2026 11:03:47 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] ACPICA: Add ACPI_MSG_DEBUG to set KERN_DEBUG for debug
 output
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20260831053420.1729024-1-superm1@kernel.org>
 <CAJZ5v0ip5QM62Xc+xFAXDu8bv-nyXNmqd647AoERXO99HfkvTw@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0ip5QM62Xc+xFAXDu8bv-nyXNmqd647AoERXO99HfkvTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/26 10:50, Rafael J. Wysocki (Intel) wrote:
> On Mon, Aug 31, 2026 at 7:34 AM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> acpi_debug_print() emits ACPI debug output using multi-part
>> acpi_os_printf() and acpi_os_vprintf() calls without any loglevel
>> prefix.
>>
>> When acpi_os_vprintf() processes a chunk without a loglevel prefix
>> (printk_get_level() returns 0), it prepends KERN_CONT. Because the initial
>> header chunk lacks a loglevel prefix, it either attaches to a preceding
>> unfinalized log message (inheriting its level) or, when split across
>> printk buffer records, falls back to the default message loglevel rather
>> than KERN_DEBUG. This can cause dmesg to misinterpret and colorize debug
>> messages as errors.
>>
>> Define ACPI_MSG_DEBUG as KERN_DEBUG in aclinux.h (with an empty fallback
>> in acutils.h for ACPICA OS-independence) and prefix debug message headers
>> and context switch output in acpi_debug_print() with ACPI_MSG_DEBUG so
>> that printk records are properly tagged with KERN_DEBUG.
>>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> Given this is purely for Linux - it's not obvious to me if it should
>> go upstream to ACPICA or directly to Linux.  Sending here for now.
> 
> Defining ACPI_MSG_DEBUG upstream would make sense in my view, so why
> don't you submit it there?

OK - No problem.  I've submitted there.

https://github.com/open-acpica/acpica/pull/1231

> 
>> ---
>>   drivers/acpi/acpica/acutils.h   | 3 +++
>>   drivers/acpi/acpica/utdebug.c   | 4 ++--
>>   include/acpi/platform/aclinux.h | 1 +
>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
>> index 9049bfee409c4..766a3080b5ea1 100644
>> --- a/drivers/acpi/acpica/acutils.h
>> +++ b/drivers/acpi/acpica/acutils.h
>> @@ -100,6 +100,9 @@ extern const char *acpi_gbl_clock_input_scale[];
>>   #ifndef ACPI_MSG_BIOS_WARNING
>>   #define ACPI_MSG_BIOS_WARNING   "Firmware Warning (ACPI): "
>>   #endif
>> +#ifndef ACPI_MSG_DEBUG
>> +#define ACPI_MSG_DEBUG          ""
>> +#endif
>>
>>   /*
>>    * Common message suffix
>> diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
>> index a31e07400c34d..1f2cab491637f 100644
>> --- a/drivers/acpi/acpica/utdebug.c
>> +++ b/drivers/acpi/acpica/utdebug.c
>> @@ -156,7 +156,7 @@ acpi_debug_print(u32 requested_debug_level,
>>          if (thread_id != acpi_gbl_previous_thread_id) {
>>                  if (ACPI_LV_THREADS & acpi_dbg_level) {
>>                          acpi_os_printf
>> -                           ("\n**** Context Switch from TID %u to TID %u ****\n\n",
>> +                           (ACPI_MSG_DEBUG "\n**** Context Switch from TID %u to TID %u ****\n\n",
>>                               (u32)acpi_gbl_previous_thread_id, (u32)thread_id);
>>                  }
>>
>> @@ -168,7 +168,7 @@ acpi_debug_print(u32 requested_debug_level,
>>           * Display the module name, current line number, thread ID (if requested),
>>           * current procedure nesting level, and the current procedure name
>>           */
>> -       acpi_os_printf("%9s-%04d ", module_name, line_number);
>> +       acpi_os_printf(ACPI_MSG_DEBUG "%9s-%04d ", module_name, line_number);
>>
>>   #ifdef ACPI_APPLICATION
>>          /*
>> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
>> index 9b30bb9ed711c..5e2ed5e79d3b8 100644
>> --- a/include/acpi/platform/aclinux.h
>> +++ b/include/acpi/platform/aclinux.h
>> @@ -169,6 +169,7 @@
>>
>>   #define ACPI_MSG_BIOS_ERROR     KERN_ERR "ACPI BIOS Error (bug): "
>>   #define ACPI_MSG_BIOS_WARNING   KERN_WARNING "ACPI BIOS Warning (bug): "
>> +#define ACPI_MSG_DEBUG          KERN_DEBUG
>>
>>   /*
>>    * Linux wants to use designated initializers for function pointer structs.
>> --
>> 2.53.0
>>

