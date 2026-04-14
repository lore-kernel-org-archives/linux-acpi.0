Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3893CAE8A;
	Tue, 14 Apr 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162145; cv=none; b=UFFdeJgXR12zwdB7TEQbbmTsfgXHxs6b50sMF1TvHgw0G0dz9JOdQs0NzJ30BeZvfCQB8yMvvp8QMYP5JaX5g8EFPeNEl7jpjo1jOx5L0zqVnhmo6lYd1uDEZaIadD1PyCT2gGTv/drlwSq7a/SBK6Ce6E+YiA0TUurV88rBK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162145; c=relaxed/simple;
	bh=JoIcecRZx/cQixKD4S3F/oJmW8C02rdzT3SvIMdRREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqtsWYIFcYxDvBSU+p6LWjKFwLcHrziGgXaikIl9bB8KsldM5kKPnRWZFzqxh+BT00wCudcKbfQgDL0ne5qIEP9gDd+M6JysDZn4HjIIq/MSH2Ys9sC+oHDGDCgCXxRJK5g5eoA/ZbGmrBvZQP7m6ylpx+ew0I+LbyKBRw7piFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Sqz9M3LX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Sqz9M3LX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=mrj0TgymHiMmZwZs2Vo2Bt+4CUgM0die06+x7rWw59g=; b=Sqz9M3LXIsN+s1ZYgdcBHfRdjS
	BQPb0aiMYyE7+TUmuI9k6GybWCOqYRsB0itaIgQTGeTMoVAUOdoJxQpEvYwRRrl6oVLDShTM+qSHh
	F2A1W8mDhStkHA3/nwcRkkPFUjzP1WUr8qt2Szs2vjoGJi+5ecSuy148Mq0jkNNHjztEcceX7/VkS
	iVp1Eje/IrkowGM61e39a8ELoRKv4Nv3q8s4b7Z8yrIjLh+uV9MVCxT9fBymiIEnCAj2/VcO+muUp
	vIenLrg9CivGsD8GxC4anEpwCsbGEuFx3wHXO5TXWuyTGFWIYXfWWvzNeWhyzBGDPjAnJmJVb+s8p
	xKErlGwA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCau0-00CzuK-0k;
	Tue, 14 Apr 2026 10:21:52 +0000
Date: Tue, 14 Apr 2026 03:21:46 -0700
From: Breno Leitao <leitao@debian.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	lpieralisi@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pjaroszynski@nvidia.com, guohanjun@huawei.com, sudeep.holla@kernel.org, 
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
Message-ID: <ad4UWJ__dnDQtrj8@gmail.com>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
 <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
X-Debian-User: leitao

Hello Huisong,

On Tue, Apr 14, 2026 at 05:43:51PM +0800, lihuisong (C) wrote:
> But it is a real issue. Thanks for your report.
> I think the best way to fix your issue is that remove this verification in
> psci_acpi_cpu_init_idle().
> Because it is legal for platform to report one LPI state.
> This function just needs to verify the LPI states which are FFH.

Thank you for the prompt feedback.

Would this approach work?

commit 6c9d52840a4f778cc989838ba76ee51416e85de3
Author: Breno Leitao <leitao@debian.org>
Date:   Tue Apr 14 03:16:08 2026 -0700

    ACPI: processor: idle: Allow platforms with only one LPI state
    
    psci_acpi_cpu_init_idle() rejects platforms where power.count - 1 <= 0
    by returning -ENODEV. However, having a single LPI state (WFI) is a
    valid configuration. The function's purpose is to verify FFH idle states,
    and when count is zero, there are simply no FFH states to validate —
    this is not an error.
    
    On NVIDIA Grace (aarch64) systems with PSCIv1.1, power.count is 1 for
    all 72 CPUs, so the probe fails with -ENODEV. After commit cac173bea57d
    ("ACPI: processor: idle: Rework the handling of
    acpi_processor_ffh_lpi_probe()"), this failure propagates up and prevents
    cpuidle registration entirely.
    
    Change the check from (count <= 0) to (count < 0) so that platforms
    with only WFI are accepted. The for loop naturally handles count == 0
    by not iterating.
    
    Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handling of acpi_processor_ffh_lpi_probe()")
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
index 801f9c4501425..7791b751042ce 100644
--- a/drivers/acpi/arm64/cpuidle.c
+++ b/drivers/acpi/arm64/cpuidle.c
@@ -31,7 +31,7 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
 		return -EOPNOTSUPP;
 
 	count = pr->power.count - 1;
-	if (count <= 0)
+	if (count < 0)
 		return -ENODEV;
 
 	for (i = 0; i < count; i++) {
