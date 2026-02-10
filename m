Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FC2EBB84;
	Tue, 10 Feb 2026 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749176; cv=none; b=cjlWGXkbIgpHwGybPz7wiKuevZlxrlzJ267SitJJxhqQseB0sNBmkNR2/nf7kBdR2XM+eLhzaWupqUTwygRzFvYE/szY+iLq+xBf0NIodIa+2kQ2CfGoBNz52eKocjfQNHfGscbXW9Z4a17TGY1dtjYcpuHDAqlBLOfn3vd1tHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749176; c=relaxed/simple;
	bh=cQmAZOlgqDEJoNzb/KC5ffX6k09b7GesQWLKzu3capA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NymtpJ2+S/rih5tyneBHdM23yW5nS7oZfPCTH9N/J1GZUchIr/H+4iB8fM9LiDePIvo+CfHrTEWNXzcKqtrfYCoixwkLNv1RLillCE1nbOcvjyRRhkK/hUHFuNZr6unEPQq8bXJdREw3GUOOZIpDwDjywUSaXDQXmM9OHf2CJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ym6yPVTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ym6yPVTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55664C116C6;
	Tue, 10 Feb 2026 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770749173;
	bh=cQmAZOlgqDEJoNzb/KC5ffX6k09b7GesQWLKzu3capA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ym6yPVTBOhUVK/R/XVvltsP0cb1lHsrBaN4N1frOdcI8ZO64AV9b6SjsYgFVyTrbn
	 2cgUFXabTY94F3aq2P8f4EETK2GqF9meau0+2NHKE37IQXjDtx9EKJlkDQFxvbIEVT
	 V6OjTffRlf2V1OMY/UxL3QtyZ+9VrQLYOVjfLzeY=
Date: Tue, 10 Feb 2026 10:46:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: bhe@redhat.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com,
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com,
 kernel-team@meta.com
Subject: Re: [PATCH v2 0/2] vmcoreinfo: Expose hardware error recovery
 statistics via sysfs
Message-Id: <20260210104612.5547717cb6b5da794d9c4724@linux-foundation.org>
In-Reply-To: <aYr154HW4IiIw3PH@gmail.com>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
	<aYr154HW4IiIw3PH@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 01:11:41 -0800 Breno Leitao <leitao@debian.org> wrote:

> Hello Andrew,
> 
> On Mon, Feb 02, 2026 at 06:27:38AM -0800, Breno Leitao wrote:
> > The kernel already tracks recoverable hardware errors (CPU, memory, PCI,
> > CXL, etc.) in the hwerr_data array for vmcoreinfo crash dump analysis.
> > However, this data is only accessible after a crash.
> >
> > This series adds a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to
> > expose these statistics at runtime, allowing monitoring tools to track
> > hardware health without requiring a kernel crash.
> >
> > The directory contains one file per error subsystem:
> >   /sys/kernel/hwerr_recovery_stats/{cpu, memory, pci, cxl, others}
> >
> > Each file contains a single integer representing the error count.
> >
> > This is useful for:
> > - Proactive detection of failing hardware components
> > - Time-series tracking of recoverable errors
> > - System health monitoring in cloud environments
> 
> Is there a chance this could be included in the 6.20 merge window?

During the 7.0 merge window?  Sure.  I'll be taking a look at this (and
a whole lot more) after 7.0-rc1 is released.  
