Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEF3E6DC1;
	Tue, 14 Apr 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172482; cv=none; b=bE5OHTvaL/GSB45uKe/zvjE0gtPgiIAUX4zrnuI+pILSiNyJJJsJpf6dJSifjbYs4OE5EsVeO5/9qA75G8oAvvj5MXg8I69wBfBvi6iEwrsdr+JwY+6voQGbEZg9nKgw2gapOZg7SZd8f0IfDk3eA6gdWV6CcxtWgKlM0PfWmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172482; c=relaxed/simple;
	bh=p6w550N0MxEwxNAHSInqETjhVWVfzaLbGQYn5bMQkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHqP7FzlXYWBzPX6nfwI+nhXcoHEt95+RlfDzLWl7TOliDrsW2poO3Qmjhh8azUkgeE9bkL2XgFSxJptjW1SJPu1XsGPT30jW8YiDVBFFJ6oNeBh0w2h0TD+Y6NU1YlSlO+sBUoTv1HJlZYK5QZZA/rSU618FBE7XxS38CTT/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XlTlVTrF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XlTlVTrF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p6w550N0MxEwxNAHSInqETjhVWVfzaLbGQYn5bMQkuk=; b=XlTlVTrF7k4kweRqsnLhib6u2s
	JBVZbhwkXgqWFEOAq1frC3U41CvvnE4H7d5DcfmfLjYN3/IjfFYQCWSnIXeNP322WjdezqWyz7JH8
	4dw41S+JTbqQrEDCQIZy1J7L7MaJenecODg6bLCc6UPpAp60Tkdimy5zFCB3Mw4VVXbvkW3uErNt2
	otJo5JbZIeOH4QLsrNHhI29zee0WDcpO8TBVsm69UOYvmuPE8VtS5CI6favDXclujdaLLZrGEmwvJ
	10fSHky5bxCsBXlFdslmXX+LID5KESeqvgYGCfxv2oiDqvXkZ5nmRNByU9jGspmYIdaup0sABsG3S
	v6S+BV2Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCday-00D5gf-1t;
	Tue, 14 Apr 2026 13:14:24 +0000
Date: Tue, 14 Apr 2026 06:14:19 -0700
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
Message-ID: <ad48gItCwrC-ar34@gmail.com>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
 <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
 <ad4UWJ__dnDQtrj8@gmail.com>
 <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
 <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla>
X-Debian-User: leitao

Hello Sudeep,

On Tue, Apr 14, 2026 at 01:25:53PM +0100, Sudeep Holla wrote:
> So while I understand that the kernel did not report an error previously, that
> does not mean the _LPI table is merely moot on this platform when it contains
> only a WFI state.

Can you clarify whether datacenter ARM systems are expected to expose
deeper idle states beyond WFI in their _LPI tables?

Backing up, I'm observing 72 pr_err() messages during boot on these
hosts and trying to determine whether this indicates a firmware issue or
if the kernel needs adjustment.
