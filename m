Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1846AF0D;
	Fri, 22 May 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461665; cv=none; b=VlzXSbwPbyboOpiwoe6snNBipBWi6oM9rRA/SO8J/oCjAWF0RVMEgf1/wfunWxzF5hCjPo8A0a8GG+gtDAhv5+PrLha+1Hd/MEsl3yutTwHGYS7v1Wk5bc/sywEhWJ1GSqfsKHateYgwfioQ2L/M6VpZFF8qAzSGAw3cMF1Nht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461665; c=relaxed/simple;
	bh=DiJbsVk6CR3ZMq9sxNf6yMdKpaW+JlWOs56VMIS2bZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ur4Copva/3LeIBerCim3y9zVLzanYx3pqetugn9FLJQ+LymBlaTw6/BGaiB3NRX04E6fcoBsqikjJyBZciJcDKGKFoGG0BlaW2aDRtBfVkXlcXkDjHTqg/4eqJWG0OcmKeNKlC+I2L85UAMMn0GShHrTDQx3BHsSW47sW3Mu+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwmCRWj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwmCRWj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4181F000E9;
	Fri, 22 May 2026 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461664;
	bh=Hl0xr83JFZ00R8HGTZsC9DFUq1D2e/cPY5F+PA0CWiU=;
	h=From:To:Cc:Subject:Date;
	b=fwmCRWj7BjFH3+Qcn0b7CwQ2mTzTItIvigKrFIgCfSY/k92zmT19XbVDsA6DAD1d7
	 bOtW37OhnVAB+wrNP2K6fmw6acwDgy4jT18EcYEIUHQpUG+UvKdDip+T7Kns6OnZ3o
	 dOGoIytjPrD3MWbOW/tDFZY7H7Z5toPGhiLgA42GF8ct4/DNG/9oxlUvn7dREAqSLC
	 O0II1CxtPSYsJqtIwOwnK917sOVtn/Riy8TjupORQv5HVL5yHFA+iLFD6ck+j3sKAW
	 9z8jEowDD5igyY/69USnjPRxubDyeelsoaNZ3Ls2GjINNUj70AM8B15CplzFwLeIR6
	 C5ClEnHqwLhtQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v2 0/3] ACPI: button: Fixes related to GPE handling and probe error
 path
Date: Fri, 22 May 2026 16:48:41 +0200
Message-ID: <2046403.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-acpi/5996185.DvuYhMxLoT@rafael.j.wysocki/

sent to address sashiko.dev feedback on patch [2/3]:

> > @@ -106,8 +109,7 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device,
> > u32 gpe_number)> > 
> >  	 */
> >  	
> >  	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
> >  	if (gpe_event_info) {
> > 
> > -		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
> > -		    ACPI_GPE_DISPATCH_NONE) {
> > +		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) & dispatch_type_mask)
> > {
> 
> Does this incorrectly treat sequential enumeration values as bit flags?
> ACPI_GPE_DISPATCH_METHOD is defined as 1, and ACPI_GPE_DISPATCH_NOTIFY is 3.
> Since dispatch_type_mask is passed as ACPI_GPE_DISPATCH_METHOD (1) from
> acpi_button_probe(), this bitwise AND evaluates to true for both METHOD
> (1 & 1 == 1) and NOTIFY (3 & 1 == 1).
> Could this unintentionally enable GPEs for NOTIFY handlers?

The original series description below still applies.

This series fix three issues related to the ACPI button driver,
one introduced during the 6.15 development cycle, one from the 7.0
cycle, and one that has been there for a long time, but has been
omitted by mistake by a recent commit.

Thanks!



