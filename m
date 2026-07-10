Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0BD405C47
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681405; cv=none; b=OyytmvNBfWRKfTPNJ8d+qTOk6jyisXo/cogZfmAl8etyxWpKCei8uNO63Lf88Bw5Ge7thvNu/R9X8y/YwjhYvSGFNYu7p0tOS3iFapbz3QGJC2Xg2RJMDBXrU6UAZ1cwOunbeR+iYGlLY45DVi/HMh7rH0jNAmYG51AlUF8NWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681405; c=relaxed/simple;
	bh=e066uGzH4hlBmddQyFCAWURjWwySKtH8Vk5WaPICBvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CthHReqgqnUF/BmKgNwgLqPLr+QZxDIgbEMzvFICnM+EgxunBBOlF/PlVA/jsiFYxSURFg6kvfLhqNgmV8FZVRFiSAS9zhk3qOozQz1uDHlj1UQNn828HPDn4cU+d/YPLrvGEB2TXjSGcSalGedpgR0/eB9O4Y/l0zV3ZqF1ENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dwqNili5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dwqNili5"
Date: Fri, 10 Jul 2026 19:03:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783681401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dajv8rRLLQqL/bHcBInspiOpIt5vQWx2zXLDiMTgElk=;
	b=dwqNili5ix7ZeKTpYl9LMHTAH/HpedCS1XU7PRBhkr+YckQWobYMV0lDq0M7vigSGzGmtP
	8oE1zk1v0HMDOHmuNXFiY9SE0CTVtEmn+1v0Q+3ybmj/4Otu9dN0YE55TB35Rw3htM03ax
	KCWV20IHbRMa+JFFP5IWPiK7C35cyLw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com,
	vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <alDRawveM-auCHwB@MiWiFi-R3L-srv>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
 <aYvi4Y_HNqk_u1-v@fedora>
 <ak0JSScR3EYgLEf9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0JSScR3EYgLEf9@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 07/07/26 at 07:13am, Breno Leitao wrote:
> Hello Baoquan,
> 
> On Wed, Feb 11, 2026 at 10:01:05AM +0800, Baoquan He wrote:
> > On 02/02/26 at 06:27am, Breno Leitao wrote:
> > > Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
> > > hardware error recovery statistics that are already tracked by the
> > > kernel. This allows userspace monitoring tools to track recovered
> > > hardware errors without requiring kernel crashes.
> > > 
> > > This is useful to track recoverable hardware errors in a time series,
> > > even if the host doesn't crash.
> > > 
> > > The sysfs directory contains one file per error subsystem:
> > > 
> > >   /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
> > >   /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
> > >   /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
> > >   /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
> > >   /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors
> > > 
> > > Each file contains a single integer representing the count of recovered
> > > errors for that subsystem.
> > > 
> > > These statistics provide visibility into the health of the system's
> > > hardware and can be used by system administrators to proactively detect
> > > failing components before they cause system crashes.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > > 
> > > diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> > > index e2784038bbed7..b7fcd21be7c59 100644
> > > --- a/kernel/vmcore_info.c
> > > +++ b/kernel/vmcore_info.c
> > 
> > Since we agreed hwerr_recovery_stats has nothing to do with vmcore, it
> > seems inappropriate to put its sysfs handling code in
> > kernel/vmcore_info.c. File kernel/vmcore_info.c is only used to build
> > vmcore info for later vmcore dumping. And hwerr_log_error_type() should
> > not be put in kernel/vmcore_info.c. either. I didn't check this
> > carefully before, sorry. Please reconsider if these can be handled better.
> 
> I've sent an RFC to move it to RAS code, which I think it belongs
> better. Does it make more sense?
> 
> https://lore.kernel.org/all/20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org/

Dude, you pinged me but didn't add me in patch posting thread. It at
least should be CC-ed to kexec mailing list since there's code change in
kernel/vmcoreinfo.c.

Anyway, I am glad to see it's been taken out of vmcoreinfo.c,
which is going in the right way from kdump side. For its migrating
into driver folder, leave it to the relevant reviewer to review and
decide.

For kdump part,

Acked-by: Baoquan He <baoquan.he@linux.dev>

Thanks
Baoquan
