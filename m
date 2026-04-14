Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533325A357;
	Tue, 14 Apr 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184319; cv=none; b=jMn/ej7Nb4kwssJ2Eb9j7/R2CM7zP2lRFu7xkorA1hG0cCsiu2DSa9Rso+j6JH5mYsgqSSc+gMaqesjeBLrHiy071al+aou4elYYgnCUWy0vdvFLeWq9G1BEgG2o17ZF27dZguTHUBS/aDFx7xgT/95VeA9EHfH5p8iQ0X2ecxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184319; c=relaxed/simple;
	bh=z/DZ6HU3GofZiHyEMJzqlAJvWefQHWAuskaXNMazL8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4ZG+j50gZ7z1CJCNnEWS6SAGXwriMX7w54/Kup4lYcgD3TnB3+9gypcIfM9/DlUIsWuzf8hVln1VLtFpiDyHhjhCCOeL8UkU4Xn4udDgnIM8LVgP5ZmnvXpaJJ16jn/VmMsMovvnfXaYTplmrBl+J9K6hAHcuhAfPboz7U9HvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=f7oDisXd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="f7oDisXd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FdXE2tVp66RJrAxYD1Fn/hCeXeICiymZD7gAr383aF4=; b=f7oDisXdB29ztjU627r7TbiRs2
	z5xgC0uzYAUQyBwftf25Zi9Na8S12Zg3JYr2SriHdpKwl1NdB2zVetQb+8FXQg1ljsuOyiAR8ZJgY
	FGNC8Iz70NZrs8VNe3mDkvOcYG7SwbBFDN1toDiWHi4/FLiAh9tPHddphByjYZGECqUm8H8Qn+JWx
	x+TCUyjSRBrzb0YBDTmgsNp1JrFyIK9mt1ctcvVvFv7RMQMMwXFD3uXOINRtDbidzYkpAyXNzWWxT
	DOTW/hQS4hMttMtqessxS4Exckl4nI8sPqysMJ9E49OUHrg/11GAGnkPMVeo56fNAQo1KS74Za570
	U4G4HieA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCgfr-00DCFn-1Z;
	Tue, 14 Apr 2026 16:31:39 +0000
Date: Tue, 14 Apr 2026 09:31:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "lihuisong (C)" <lihuisong@huawei.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, lpieralisi@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pjaroszynski@nvidia.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, 
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
Message-ID: <ad5qxncafOiTeLNg@gmail.com>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
 <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
 <ad4UWJ__dnDQtrj8@gmail.com>
 <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
 <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla>
 <ad48gItCwrC-ar34@gmail.com>
 <20260414-excellent-hidden-dodo-5bb98e@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-excellent-hidden-dodo-5bb98e@sudeepholla>
X-Debian-User: leitao

Hello Sudeep,

On Tue, Apr 14, 2026 at 03:10:03PM +0100, Sudeep Holla wrote:
> On Tue, Apr 14, 2026 at 06:14:19AM -0700, Breno Leitao wrote:
> > Hello Sudeep,
> >
> > On Tue, Apr 14, 2026 at 01:25:53PM +0100, Sudeep Holla wrote:
> > > So while I understand that the kernel did not report an error previously, that
> > > does not mean the _LPI table is merely moot on this platform when it contains
> > > only a WFI state.
> >
> > Can you clarify whether datacenter ARM systems are expected to expose
> > deeper idle states beyond WFI in their _LPI tables?
> >
>
> Of course any system that prefers to save power when its idling must have
> these _LPI deeper idle states.
>
> > Backing up, I'm observing 72 pr_err() messages during boot on these
> > hosts and trying to determine whether this indicates a firmware issue or
> > if the kernel needs adjustment.
>
> I consider this a firmware issue, but not a fatal one. What matters more is
> the behavior after those errors are reported.

I understand. While I'm not a hardware or firmware vendor myself, I can
see how they might consider power management features _optional_ for certain
server configurations.

> If you force success, either through your change or through the PSCI approach
> suggested by lihuisong, then in practice you are only enabling a cpuidle
> driver with a single usable state: WFI. That is not inherently wrong, but it
> also does not provide much benefit.

Given that this isn't a critical error, would it make sense to downgrade
the pr_err() to pr_debug()? is it a reasonable compromise. I just want
to avoid these pr_err() all accross the board, affecting kernel health
metrics in large fleets.

My proposal:

commit c98007f9e10fe229672d29c3844c96705cecaed5
Author: Breno Leitao <leitao@debian.org>
Date:   Tue Apr 14 05:28:28 2026 -0700

    ACPI: processor: idle: Downgrade FFH LPI probe failure message to pr_debug()
    
    The "Invalid FFH LPI data" message is printed at pr_err() level for every
    CPU when acpi_processor_ffh_lpi_probe() fails. On platforms where the FFH
    probe legitimately returns an error (e.g., no deep idle states beyond
    WFI), this floods the kernel log with per-CPU error messages that are not
    actionable.
    
    Downgrade to pr_debug() since this is a diagnostic message, not a
    critical error.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee5facccbe10c..ab93a2c10a9ad 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1259,7 +1259,7 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 	if (pr->flags.has_lpi) {
 		ret = acpi_processor_ffh_lpi_probe(pr->id);
 		if (ret)
-			pr_err("CPU%u: Invalid FFH LPI data\n", pr->id);
+			pr_debug("CPU%u: Invalid FFH LPI data\n", pr->id);
 	}
 
 	return ret;


