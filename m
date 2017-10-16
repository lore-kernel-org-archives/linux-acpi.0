From: Will Deacon <will.deacon@arm.com>
Subject: Re: [GIT PULL] ACPI IORT changes for v4.15
Date: Mon, 16 Oct 2017 16:04:57 +0100
Message-ID: <20171016150456.GB10500@arm.com>
References: <20171013152937.GA13386@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753781AbdJPPEx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Oct 2017 11:04:53 -0400
Content-Disposition: inline
In-Reply-To: <20171013152937.GA13386@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: catalin.marinas@arm.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, robin.murphy@arm.com

Hi Lorenzo,

On Fri, Oct 13, 2017 at 04:29:37PM +0100, Lorenzo Pieralisi wrote:
> Hi Catalin, Will,
> 
> here are the ACPI IORT changes I have queued aimed at the v4.15 kernel
> release.
> 
> Main changes:
> 
> - SMMUv3 MSI enablement work based on IORT issue C spec updates
>   (Hanjun Guo)
> - Clean-ups/rework in preparation for PMCG support (Lorenzo Pieralisi)
> 
> Patches have a compile time dependency on the ACPICA tree that we handled
> through an ACPI_CA_VERSION guard; I will remove it at v4.15-rc1 when
> dependencies have settled.
> 
> Reference discussion:
> 
> http://lkml.kernel.org/r/20171013130445.GA27895@red-moon
> 
> I expect no merge conflict with the arm64 tree for-next/core branch.
> 
> Patches are based on v4.14-rc4 owing to an IORT dependency on a fix
> (ie commit 37f6b42e9c ("ACPI/IORT: Fix PCI ACS enablement")) that
> was merged in v4.14-rc4.

As discussed offline, given that this is a trivial one-line conflict as
opposed to a functional dependency, could you please send another pull
request based on -rc3? The arm64 for-next/core branch is already based on
that, and this doesn't seem like a good reason to pull in -rc4.

Cheers,

Will
