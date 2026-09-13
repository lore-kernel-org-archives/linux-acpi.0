Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F037998A;
	Sun, 13 Sep 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288257; cv=none; b=kpyfPS6uOnNoyBIqZBR9uKcLStwe16YBu0yByQwLgmIfkzoxTE+ZInHeuPCCMmzowHvtqI8XIqNtJ8dwov+bizfkudgvz//49DT3AaWI5WaQoqKQBqWl7Y8ElOkob26JVbh06cF6QA4xwDUowyO6O4UmCKJ7UVzkukMhRa2eYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288257; c=relaxed/simple;
	bh=Z5z6bLqwiLc1VA1HLy5fnos6G9gmup/7LK7VZ8qLVGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dCG5m+H8O8V3J/9F9h0T8SB6e6R8vL5wffvPsCend1Ez3/DZSrJjDXFCPIoRBCHoreK3M/a8cU78jFA1QYDpbZgeK8UTYHB34++s54PgGbHPwqevy6rTmf5k7orTac91/MwsfSpSkNJuFQrkJxRTfga74UFWKGwC8jL6i1JMyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JshStNX9; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JshStNX9"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hjLyr5JmBz967P;
	Sun, 13 Sep 2026 10:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789288116;
	bh=Z5z6bLqwiLc1VA1HLy5fnos6G9gmup/7LK7VZ8qLVGE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=JshStNX9k56QwkYNjs8i8jFQJ5jhqklRtRH/BDlG8T8Yy3GIRRMx2xMJw9PJBRhc9
	 t02H2f/aWCeaMSRiBWuoya+G5eeDOlRv09uLfISGHh6x2Yezq9K29X/nkFkNLTQdEO
	 E62oXQUHGHgWwTt/d2gbSYE0bb18InjIJRxTa7YtTeU4nJU2T0ozcHkDwpelGlGi/s
	 adZkWxZ3NCgAzwn5tVe/SegeDh7wzthDLtR3xg5q0pcNMI1nev5eUOqdEJPk9Zuyyo
	 Ihs57OQ38vccA1miaJgtXli8Z0dnQR7fhXnF12kOexfhtOhsho/yqn4g/P2ko/pyO/
	 qy813ZldYUP/g==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hjLxQ6gCJz7xL3;
	Sun, 13 Sep 2026 10:27:22 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hjLxP6yjJz8svb;
	Sun, 13 Sep 2026 10:27:21 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id B1FB05F8E7;
	Sun, 13 Sep 2026 10:27:16 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d7f4a573-1a2e-4274-8c8f-41d398592356@leemhuis.info>
Date: Sun, 13 Sep 2026 10:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: scan: Honor _DEP for Intel CVS devices
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Miguel Vadillo <miguel.vadillo@intel.com>, linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
 mehdi.djait@linux.intel.com, wei.a.xu@intel.com, atul.raut@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260601194040.18223-1-miguel.vadillo@intel.com>
 <6e450fa2-8b40-48b6-b0b0-a1c4b72a383d@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <6e450fa2-8b40-48b6-b0b0-a1c4b72a383d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178928803725.1306370.15081822844060054080@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B1FB05F8E7
X-NC-CID: c4Zsd3J8r7IoqcAnfSthMgCT2G7U/9e5HQYyWt7mswx8/zn/Kg0=

On 9/12/26 18:50, Thorsten Leemhuis wrote:
> On 6/1/26 21:40, Miguel Vadillo wrote:
>> CVS (Computer Vision Sensing) is an ACPI-enumerated device that sits
>> inline in the CSI-2 path between the camera sensor and Intel IPU.
>> On platforms where CVS is present, the camera sensor's ACPI node
>> declares a _DEP dependency on the CVS device.
>>
>> The CVS driver must be fully initialized before camera sensor drivers
>> probe, because CVS controls the CSI-2 link ownership handshake (via
>> GPIO REQ/RESP), the MIPI/CSI-2 lane configuration, and the camera
>> power domain. Without CVS ready, the sensor driver can bind but the
>> CSI-2 stream will not function correctly.
>>
>> The CVS driver calls acpi_dev_clear_dependencies() at the end of its
>> probe() to unblock waiting consumers once it is ready.
>>
>> Move the CVS HIDs from acpi_ignore_dep_ids[] to acpi_honor_dep_ids[]
>> so that camera sensor enumeration is deferred until the CVS driver has
>> finished probing, matching the behavior already in place for IVSC.
> 
> TWIMC, there is a bug report where one or two people claim that this
> change caused a regression; the report is quite verbose (guess LLM
> assisted) and hard to grasp for me as outsider; requests for
> clarifications from my side were not really fruitful. Not sure what to
> make of this, but I thought I'd let you know; for details see:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=221988

For completeness, a report that is more straight forward to read (at
least for me) was now posted here:
https://lore.kernel.org/all/20260912185836.309071-1-manuel.knitza@googlemail.com/

Cia, Thorsten

>> Signed-off-by: Miguel Vadillo <miguel.vadillo@intel.com>
>> ---
>> Note: this patch has a functional dependency on the CVS driver and its
>> IPU bridge support, which are queued in media-next for v7.2. Without
>> those drivers, no code will call acpi_dev_clear_dependencies() for the
>> CVS HIDs and camera sensors will remain deferred indefinitely.
>>
>> The CVS driver series (v5) can be found at:
>>   https://lore.kernel.org/linux-media/20260527170531.383871-1-miguel.vadillo@intel.com/
>>
>>  drivers/acpi/scan.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 530547cda8b2..1463eb3a4f6e 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -848,8 +848,6 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
>>  static const char * const acpi_ignore_dep_ids[] = {
>>  	"PNP0D80", /* Windows-compatible System Power Management Controller */
>>  	"INT33BD", /* Intel Baytrail Mailbox Device */
>> -	"INTC10DE", /* Intel CVS LNL */
>> -	"INTC10E0", /* Intel CVS ARL */
>>  	"LATT2021", /* Lattice FW Update Client Driver */
>>  	NULL
>>  };
>> @@ -861,6 +859,9 @@ static const char * const acpi_honor_dep_ids[] = {
>>  	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
>>  	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
>>  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
>> +	"INTC10DE", /* CVS (LNL) driver must be loaded to allow camera streaming */
>> +	"INTC10E0", /* CVS (ARL) driver must be loaded to allow camera streaming */
>> +	"INTC10E1", /* CVS (PTL) driver must be loaded to allow camera streaming */
>>  	"RSCV0001", /* RISC-V PLIC */
>>  	"RSCV0002", /* RISC-V APLIC */
>>  	"RSCV0005", /* RISC-V SBI MPXY MBOX */
> 
> 

