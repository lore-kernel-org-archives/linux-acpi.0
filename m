Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E351D9A70;
	Wed, 14 Oct 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999085; cv=none; b=WPlrbau+2W1SaWLouEqu6v03qCY8K6IiG8+I5M39Yva6qwGhOwQ8TIHeWKPbhMpdzlDckxY7Jv6pgC/dgKsfFMYQ2tPmqz4WFzXgumgqLOJ2ZoSJpNCgsbK1MVVv3RmHhpPBWIG3hj4NGlgnkNdH9z+4fAsXQEMD7PqekwnxnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999085; c=relaxed/simple;
	bh=dhgkToCQSC3cv3cVb3QkyFhrdaxkWbOMz+N9eToBSG8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HtC2PWJqkf2wN37QYZT4PYnEDNkDBAWzrzW276YZ1HewsYVHb5Zmc9ebRBC56vjpcmqJzvMMMVJFvJwDq6ahzZKRNRvPaPM4+Plji9wQZFArdfMiAftMJpzDK2lEH97++jhbWn60aX1HNOk4ZcEkCe3Ffz7ePqkjo8FSxNaUD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OudpZFtS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OudpZFtS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=ASFu+CI6i1hPXga1E+JbqqtJuGLel7uRyJac3aak7lE=; b=OudpZFtSvj0nWOJNHpkUk/XWKz
	ztUTaoO2LQlqujtIT/9eAIPVzFn4aWlSW1SVjuwaJnd2A9hTk56KWEKJFWjeePqScFVGwWyThRo1g
	yl/PACEcLFTavEsv4D+NNo7F1JaudtFOm9s3Sk4KBdC8Rw4tMl73vn1U+z9uVyR+fB62R3DpX4rLc
	6gP/+5Bgj077n7cvJJiQMbtemH8vVovr7P4publu8lEv/dvHUUYF5g309644KAyQprNV1VCMTdlpS
	lnc1x5OlzaPw/s5yj6cHHkxciWWlQm5WakVs/EM/gFyUE113EowwxKqndhe10/qd9LaWJmrsGC2i8
	NQm0uVEA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xH2ok-0009qW-JX; Wed, 14 Oct 2026 19:31:06 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xH2ok-00AWkN-0Q;
	Wed, 14 Oct 2026 19:31:06 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <uajain@igalia.com>)
	id 1xH2ok-00000009aAq-01k2;
	Wed, 14 Oct 2026 19:31:06 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 19:31:05 +0200
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
Message-ID: <497522185b0d5edd0898edab04934d2a@igalia.com>
X-Sender: uajain@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.007
X-Spam-Score: -48
X-Spam-Bar: ----

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

Last thing before I send out v3, this is the function param-type for the
acpi_evaluate_integer()

In include/acpi/acpi_bus.h, 

acpi_status
acpi_evaluate_integer(acpi_handle handle,
		      acpi_string pathname,
		      struct acpi_object_list *arguments, unsigned long long *data);


Thanks,
Umang
