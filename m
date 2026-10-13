Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7D24A069;
	Tue, 13 Oct 2026 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918754; cv=none; b=YU01qrCmptokyn+JpcjrQ3nKNvssZjd/lbzH7ebLoXSEuQjhB3IQNchbyF34E0xC8IWuL/zZ586wQc72pm5f4eoLiX6JIVWrSkaRJcdpIiap1MBicS/1HP/B6V9jmIoX6F4vagDtqxHOgWE0Y0cVm29E6Qe4sn7i4vku4Yx8JS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918754; c=relaxed/simple;
	bh=c4EUgzZsTO+qsJH9dQuqn+aNtOPLoJLZ6vRQcFELIfQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OA8AsDmp+TXL2I+ces4lhOF3ygH2aH+sIjdvmZ38FXs3GtAlL8InF7nyL/zwTv89Nlq+i7LJQGnYtnAWVb3ybe0NrkzDRVhD+qwPIyEEV91NIakSfYIuGyHBOx7ADv5bXvSQbbgu4/Eb4nj6tUn3AnqMf/WPmtxw0xQKx12nHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=l9p6Ud9L; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="l9p6Ud9L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=Y9TtydOueDU8IiefSuYCfC3jARI8l7/hNk33zUo/NSs=; b=l9p6Ud9L87o/d5j4xo4fwRkg4E
	WPgIrOOVLE7iG+FopqOKSX+HY4H95CN0tfhELefA4sN4XUxr+GT1lz5M/u1U3uETHWayh9Thy63KA
	gJrJ6mpShQvYqsjhny8AL2aohTEEsFgjm1xeePuuYzesoLAkM7wDMxX0Yy3MJzooFMBbLoROmueQc
	pBXjfoIQtRIDiohgyfsQTDCOGCd1j9TsAZkBsUPh3hKq1Obd+NGSZNHUUuf/sNDqqXSismIwhdXbA
	huNtGPFgulmzy0Ck/1honnhURPy4A9DDpx/jS6+5WxtzSB3F0d1rO/Gb4tZ6fEGg2WI6PpEQLaflB
	elYI05Kw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xGhvH-00HFcx-NQ; Tue, 13 Oct 2026 21:12:27 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xGhvH-008sXm-0C;
	Tue, 13 Oct 2026 21:12:27 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <uajain@igalia.com>)
	id 1xGhvG-00000009Js8-3ufN;
	Tue, 13 Oct 2026 21:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 21:12:26 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 1/2] acpi: battery: Query Battery charge time ("_BCT")
 method
In-Reply-To: <CAJZ5v0i0UPcGiiAxNbjUnzn=8D2jcTCo_wtM8aMbOKhqb37EDA@mail.gmail.com>
References: <20260923082932.1049270-1-uajain@igalia.com>
 <20260923082932.1049270-2-uajain@igalia.com>
 <CAJZ5v0i0UPcGiiAxNbjUnzn=8D2jcTCo_wtM8aMbOKhqb37EDA@mail.gmail.com>
Message-ID: <bbe784378cf3f8c0ce43ce24d22465b7@igalia.com>
X-Sender: uajain@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.007
X-Spam-Score: -48
X-Spam-Bar: ----

Hi Rafael,

Thanks for the review.

On 2026-10-12 17:15, Rafael J. Wysocki (Intel) wrote:
> On Wed, Sep 23, 2026 at 10:28 AM Umang Jain <uajain@igalia.com> wrote:
>>
>> Add plumbing for querying the Battery Charge Time ("_BCT") method.
>> If present, set ACPI_BATTERY_BCT_PRESENT in battery flags to denote
>> that the method is supported in ACPI.
>>
>> Signed-off-by: Umang Jain <uajain@igalia.com>
>> ---
>>  drivers/acpi/battery.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 670853ec3a4d..a1b7a821abaf 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
>>  enum {
>>         ACPI_BATTERY_ALARM_PRESENT,
>>         ACPI_BATTERY_XINFO_PRESENT,
>> +       ACPI_BATTERY_BCT_PRESENT,
>>         ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
>>         /* On Lenovo Thinkpad models from 2010 and 2011, the power unit
>>          * switches between mWh and mAh depending on whether the system
>> @@ -110,6 +111,7 @@ struct acpi_battery {
>>
>>         struct mutex property_lock; /* Protects properties below. */
>>         unsigned long update_time;
>> +       unsigned long long charge_time;
> 
> This doesn't need to be unsigned long long.  As per the spec, unsigned
> int should be sufficient.
> 
>>         int revision;
>>         int rate_now;
>>         int capacity_now;
>> @@ -613,6 +615,10 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>>         int result = 0;
>>         acpi_status status = 0;
>>         struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +       union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>> +       struct acpi_object_list args = { 1, &arg0 };
>> +
>> +       arg0.integer.value = 100;
> 
> Please move the definitions of the variables related to _BCT
> evaluation to the code block where it gets evaluated.
> 
>>
>>         lockdep_assert_held(&battery->property_lock);
>>
>> @@ -638,6 +644,15 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>>         battery->update_time = jiffies;
>>         kfree(buffer.pointer);
>>
>> +       if (test_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags)) {
>> +               status = acpi_evaluate_integer(battery->device->handle, "_BCT",
>> +                                              &args, &battery->charge_time);
> 
> Currently, you only need to evaluate _BCT to implement the quirk in
> the second patch AFAICS, so it is not useful to evaluate _BCT if the
> quirk is not going to be used.  Any chance to rearrange the code to
> avoid evaluating _BCT when it is not needed?

Currently yes, _BCT is not useful in all cases, but since it is a ACPI
specification component, I didn't keep it behind the quirk and read as a
global param to read out.

I've re-arranged the code to evaluate _BCT if the quirk is present, but
want to double sure if that's the design we need to go ahead with?

> 
>> +       if (ACPI_FAILURE(status))
>> +               acpi_handle_info(battery->device->handle,
>> +                                "_BCT evaluation failed: %s",
>> +                                acpi_format_exception(status));
> 
> Missing indentation.

Looks fine to me, what's wrong? The patches sent are sanitized with
./scripts/checkpatch.pl, unless I am missing something?
> 
>> +       }
>> +
>>         /* For buggy DSDTs that report negative 16-bit values for either
>>          * charging or discharging current and/or report 0 as 65536
>>          * due to bad math.
>> @@ -1083,6 +1098,8 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>>                         if (result)
>>                                 return result;
>>                         acpi_battery_init_alarm(battery);
>> +                       if (acpi_has_method(battery->device->handle, "_BCT"))
>> +                               set_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags);
>>                 }
>>
>>                 result = acpi_battery_get_state(battery);
>> --
