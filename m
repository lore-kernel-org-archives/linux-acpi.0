From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/7] minor cleanups for ACPI processor driver
Date: Tue, 05 May 2015 01:50:01 +0200
Message-ID: <3387207.gDIT3Sn6JX@vostro.rjw.lan>
References: <1427464948-14564-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56791 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750832AbbEDXZB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 19:25:01 -0400
In-Reply-To: <1427464948-14564-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Friday, March 27, 2015 10:02:21 PM Hanjun Guo wrote:
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
> 
> Comments are welcomed.

The patches look OK to me and all their dependencies should be met for 4.2,
so can you please make sure that they still apply and possibly resend on
top of the current Linus' tree?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
