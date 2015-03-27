From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/7] minor cleanups for ACPI processor driver
Date: Fri, 27 Mar 2015 14:03:36 +0000
Message-ID: <20150327140336.GG1562@arm.com>
References: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-acpi@vger.kernel.org

Hanjun,

On Fri, Mar 27, 2015 at 01:55:04PM +0000, Hanjun Guo wrote:
> This patch set are some minor cleanups for ACPI processor driver
> to address the comments which raised by Rafael in ARM64 ACPI core
> patches, so this patch set is on top of ARM64 ACPI core patches
> the git tree is
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> branch for-next/acpi.
> 
> Rafael, I assume this patchset will be taken with your tree if
> it makes sense, any rebase work needed please let me know.
> 
> the last patch - ACPI / processor: Introduce invalid_phys_cpuid()
> will cut u64 mpidr to int, but I think it is ok for error values,
> correct me if I'm wrong.

I appreciate that you probably have a bunch of code building on top of
the series that's in linux-next, but sending it out at the moment is
hugely confusing -- particularly when this is targetting an independent
tree. If you have patches for 4.2, please can you wait until after the
merge window before posting for review?

Right now most maintainers are probably trying to stabilise their current
queues, so the most helpful thing you can do is test linux-next and send
fixes for any issues you find there.

It doesn't help that the series you posted seems to include two patch
series (n/7 and n/2).

Will
