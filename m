Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C453148D9;
	Tue,  7 Jul 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433614; cv=none; b=IqoVmwCGnhqo5+E1jCegQqL7Ggd/2oa51T3f3uaI1skvRhMy2hPCU2jTDxZJyCgMnnu1JwiySpda6RD5b+eC05de20AXCQRiJUQGxZSyYZq9NLu+72J+8AT58hySeNq+lJRy+91sZi0DtmwWhQRpdstB1uZy/5ehOtFwK8xOADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433614; c=relaxed/simple;
	bh=+Desexj++txHlFkvOGaGwhKT15TEpfMYQEYTcKP+nPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXdbZmf9oauWQl8hl4z/g40w6/ayzn+2Xv3VoJ7+NIm/LBV8T2k2ADlSogx4dyOZr+C5IGV63s9FErIMZjUdVfaEs6dpJcCMunuOzc2s0hWKI/p4I+dTRwDbpiuMcXbPLtn0KKAOzke4GQJ0GR4O0wNoA3eTzX+mak5XbcpzbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ejOqxuNT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ejOqxuNT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qJU2XGVhSEv1ni06jwC+Qhuuf8bPMa73T2Ir76oTEp8=; b=ejOqxuNTKTjLbZuwtqIPSsU3+7
	eMbelaDQNg5wM4Z11J2mvOLa5s4Ehkv45pnuoVqtKJEX8kN+2BQ9Cn9Z7DQNxB+HrDS+j8JWooiZX
	yukfQy/K+JYUeIIo5p+fg31buL+1pkkowHLQczas9gLPSe9bd81HZz+W1ap2qTxyMDFe8w5Jv1IR2
	pmAPsIb7oDtrHYBJIc8XibSsgsWQtWPVYwVVXkhSSKb485djHRerHqvpxigdiiXGmTu55NuD9HQfv
	Yh93JohoNOCZeopQYfGDlKU+tQduX64dMg7pIXlbecOtFec+LQMMTvFoGFrAIuUWhtDWrdGoAuuq3
	DtO9C9NQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh6Y8-002FAT-1W;
	Tue, 07 Jul 2026 14:13:24 +0000
Date: Tue, 7 Jul 2026 07:13:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
	vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <ak0JSScR3EYgLEf9@gmail.com>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
 <aYvi4Y_HNqk_u1-v@fedora>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYvi4Y_HNqk_u1-v@fedora>
X-Debian-User: leitao

Hello Baoquan,

On Wed, Feb 11, 2026 at 10:01:05AM +0800, Baoquan He wrote:
> On 02/02/26 at 06:27am, Breno Leitao wrote:
> > Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
> > hardware error recovery statistics that are already tracked by the
> > kernel. This allows userspace monitoring tools to track recovered
> > hardware errors without requiring kernel crashes.
> > 
> > This is useful to track recoverable hardware errors in a time series,
> > even if the host doesn't crash.
> > 
> > The sysfs directory contains one file per error subsystem:
> > 
> >   /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
> >   /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
> >   /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
> >   /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
> >   /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors
> > 
> > Each file contains a single integer representing the count of recovered
> > errors for that subsystem.
> > 
> > These statistics provide visibility into the health of the system's
> > hardware and can be used by system administrators to proactively detect
> > failing components before they cause system crashes.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> > 
> > diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> > index e2784038bbed7..b7fcd21be7c59 100644
> > --- a/kernel/vmcore_info.c
> > +++ b/kernel/vmcore_info.c
> 
> Since we agreed hwerr_recovery_stats has nothing to do with vmcore, it
> seems inappropriate to put its sysfs handling code in
> kernel/vmcore_info.c. File kernel/vmcore_info.c is only used to build
> vmcore info for later vmcore dumping. And hwerr_log_error_type() should
> not be put in kernel/vmcore_info.c. either. I didn't check this
> carefully before, sorry. Please reconsider if these can be handled better.

I've sent an RFC to move it to RAS code, which I think it belongs
better. Does it make more sense?

https://lore.kernel.org/all/20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org/

Thanks,
--breno
