Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59F3F86EC;
	Wed,  8 Jul 2026 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531334; cv=none; b=dOqiNvEQv+sWnzLQiy3omkooZxba28Ni7Q7cVUNO4gCddqazyEb4q64Yp3303CnF7udAtSMeStUedvzGgRLkjDrOH4Oi57JkH6A96Tk/0Sc819iZQS/VQ+iwS7T9ncKcVuL7x5DT/QE3mclHjxS6hWrA3aPmDoX4jF0+cjU8PlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531334; c=relaxed/simple;
	bh=T4DolrksHpBlFffH/pVsAhemSkqQ2fajQ+WonnBkFcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU1K5DGCyXXAnZ+3GQm6ONxiAd/o7heEbXbXUeUDEKx0WLmWpXKRJQZZn55oLNLX/UUXNwwYmrIRt7+E7nnx+Io1O4MnuJ9IFYBVjfIJDgtAljDRL/GeNZkRFuqpaPO6TjMR0n9crzlfsrvf3fQ3X0ATDAfQRmVjOJ6nth1U3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oquNZy40; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oquNZy40"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF2071A9A;
	Wed,  8 Jul 2026 10:22:07 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E233F3F905;
	Wed,  8 Jul 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783531332; bh=T4DolrksHpBlFffH/pVsAhemSkqQ2fajQ+WonnBkFcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oquNZy40VlB4u+ad+r39/E4zUwKgSz7vkaY1izkGo4d74I/MvaS6c0Vp7C719P/gx
	 f3GDkS6LHtD112cjRIwbCfMFsK/mXPh875q8wpbyUXgagUpJQyRh96GhP6xgAGug11
	 cOb/y3R5iARSx9k3/c6PcMUOXX9dBr4HY5Z7zVZ0=
Date: Wed, 8 Jul 2026 18:22:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ruidong Tian <tianruidong@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com,
	James Morse <james.morse@arm.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 00/16] Support Armv8 RAS Extensions for Kernel-first
 error handling
Message-ID: <ak6HPmosSUleJFYU@arm.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
 <20260708024131.GCak242z-9YE2xL6q0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708024131.GCak242z-9YE2xL6q0@fat_crate.local>

On Tue, Jul 07, 2026 at 07:41:31PM -0700, Borislav Petkov wrote:
> On Tue, Jun 02, 2026 at 03:15:23PM +0800, Ruidong Tian wrote:
> >  Documentation/ABI/testing/debugfs-arm64-ras |   87 ++
> >  MAINTAINERS                                 |   11 +
> >  arch/arm64/include/asm/ras.h                |   99 ++
> >  drivers/acpi/arm64/Kconfig                  |   10 +
> >  drivers/acpi/arm64/Makefile                 |    1 +
> >  drivers/acpi/arm64/aest.c                   |  423 ++++++++
> >  drivers/ras/Kconfig                         |    1 +
> >  drivers/ras/Makefile                        |    1 +
> >  drivers/ras/arm64/Kconfig                   |   16 +
> >  drivers/ras/arm64/Makefile                  |    9 +
> >  drivers/ras/arm64/ras-cmn.c                 |  479 +++++++++
> >  drivers/ras/arm64/ras-core.c                | 1026 +++++++++++++++++++
> >  drivers/ras/arm64/ras-inject.c              |  130 +++
> >  drivers/ras/arm64/ras-storm.c               |  198 ++++
> >  drivers/ras/arm64/ras-sysfs.c               |  319 ++++++
> >  drivers/ras/arm64/ras.h                     |  374 +++++++
> >  drivers/ras/debugfs.c                       |    3 +-
> >  drivers/ras/ras.c                           |    3 +
> >  include/linux/acpi_aest.h                   |   36 +
> >  include/linux/cpuhotplug.h                  |    1 +
> >  include/linux/ras.h                         |   10 +
> >  include/ras/ras_event.h                     |   79 ++
> >  22 files changed, 3315 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/debugfs-arm64-ras
> >  create mode 100644 arch/arm64/include/asm/ras.h
> >  create mode 100644 drivers/acpi/arm64/aest.c
> >  create mode 100644 drivers/ras/arm64/Kconfig
> >  create mode 100644 drivers/ras/arm64/Makefile
> >  create mode 100644 drivers/ras/arm64/ras-cmn.c
> >  create mode 100644 drivers/ras/arm64/ras-core.c
> >  create mode 100644 drivers/ras/arm64/ras-inject.c
> >  create mode 100644 drivers/ras/arm64/ras-storm.c
> >  create mode 100644 drivers/ras/arm64/ras-sysfs.c
[...]
> But that's still not that important - what is even more important is who from
> ARM is going to review and maintain this? I can take a look at the generic
> bits so that the RAS stuff coexists fine in drivers/ras/ but I'd need an ARM
> person to take care of this.
> 
> There are enough on Cc so let's see if anyone moves.

I will volunteer James Morse (he doesn't know yet) as the Arm RAS
expert. He's away this week, hopefully can have a look when he gets
back. For the ACPI bits, we have Lorenzo, Hanjun, Sudeep who should be
able to review.

Adding Rob Herring as well who's been giving some feedback on the DT
counterpart:

https://lore.kernel.org/all/20260505-aest-devicetree-support-v1-0-d5d6ffacf0a5@oss.qualcomm.com/

I have some vague recollection James wanting to start with something
simpler like EDAC and do DT first but I may be wrong or things could
have changed since. So, let's wait for James to comment.

-- 
Catalin
