Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0724DD3B8;
	Fri, 25 Sep 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353741; cv=none; b=pNFLCSLw5jv4eQTGZuRhPB/HD6HXFjXd2ABNpZR/b/gJ/gz2oqQCzcx/9UHQl3abF7mP7G/AuqDFfoyGyHfn+MnN5YVsBBdT8nfu/935LkZ2ugDMj+2K+zmsBg+R71OqqT3zU2+rmoVV+9bSjSB9hoXD0TEFtELPtrgQEu02aQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353741; c=relaxed/simple;
	bh=jNDd/graX9OchAT6WnZI9niaY2EK/vJZyAgSEuYOqOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDUlfMFEC+Raxr+3SKGBmimlbO4JoSPtTsZcCp1tdVLcHGyrw6Ia2nI4Pjau61FgARutL4RlJOfxZaOVWgzfNJNiyzYwkTlQgba4dVlu+sG+zjssytUIrPC5L+vBKXgjHi0B/nYgaDiEmNM53ggc+EpwjYFngwtgk8OBCAKlHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM/woM/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM/woM/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7611F000FF;
	Fri, 25 Sep 2026 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790353740;
	bh=zNhTvX83Ty9pz9HXP45gbDudt7dFw2l3uvY+umTfvMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HM/woM/sPf5qkXEai/h8f0iXzsogLDR8Qa7fAw4XdCZhNVhRPTRygnT2SkK5cV7Xb
	 HZJf0obYqHuk4OVqUoNOH4j42iS6synyAh7wLRa1HaXXdoTV6B2RGHg2T3Y1UNUFpp
	 WvMLiNfkNAFFQEGy+80d5K6PLNpx3whVFtBM3KiR19P9iP+mArJFWE1xjv1wp82xUd
	 kFhIvMwMpAe/ZOegkGrEAxbyOguuhXuu/S40KMJ/qdbdrm1UKK2BFDezR7jcYIBMhh
	 uRrGKoay0UftJ0f/xdVW3my/aP7EQYww5ABfkYSSiJcfd7Z5+7IdlNqjSqu5LkVb1M
	 Zhd8RRxwkim2w==
Date: Fri, 25 Sep 2026 17:28:56 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v3 0/4] ACPI/PCC: Correct PCC OperationRegion handling
Message-ID: <20260925-agama-of-immense-jest-fa4ce3@sudeepholla>
References: <20260922144302.3847593-1-sudeep.holla@kernel.org>
 <CAJZ5v0j63FKQQRq+RtwU6SpMCKXw1edM5baddKjZNtN1YARheQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j63FKQQRq+RtwU6SpMCKXw1edM5baddKjZNtN1YARheQ@mail.gmail.com>

On Fri, Sep 25, 2026 at 06:19:20PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Tue, Sep 22, 2026 at 4:43 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:

[...]

> >
> > Sudeep Holla (4):
> >   ACPICA: Fix PCC OperationRegion command offsets
> >   ACPI: PCC: Preserve shared memory signature in OpRegion handler
> >   ACPI: PCC: Free channel on OpRegion deactivation
> >   ACPI: PCC: Cache OpRegion command timeout
> >
> >  drivers/acpi/acpi_pcc.c       | 55 ++++++++++++++++++++++++++---------
> >  drivers/acpi/acpica/exfield.c | 11 +++----
> >  2 files changed, 48 insertions(+), 18 deletions(-)
> 
> Applied as 7.4 material, but please note that Sashiko reports
> pre-existing issues in this code:
> 
> https://sashiko.dev/#/patchset/20260722131553.2117835-1-sudeep.holla%40kernel.org
> 
> Thanks!
> 

Couple of patches in this series were result of its existing bug reports.
I will have a look and see what more needs fixing.

-- 
Regards,
Sudeep
