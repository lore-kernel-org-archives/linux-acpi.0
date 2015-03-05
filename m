From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v9 09/21] ARM64 / ACPI: Introduce early_param "acpi=" to
 enable/disable ACPI
Date: Thu, 5 Mar 2015 10:11:31 -0800
Message-ID: <20150305181131.GC4932@quad.lixom.net>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-10-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:41505 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbbCESLZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 13:11:25 -0500
Received: by pablj1 with SMTP id lj1so38282785pab.8
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2015 10:11:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424853601-6675-10-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Wed, Feb 25, 2015 at 04:39:49PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> This implements the following policy to decide whether ACPI should
> be used to boot the system:
> - acpi=off: ACPI will not be used to boot the system, even if there is
>   no alternative available (e.g., device tree is empty)
> - acpi=force: only ACPI will be used to boot the system; if that fails,
>   there will be no fallback to alternative methods (such as device tree)
> - otherwise, ACPI will be used as a fallback if the device tree turns out
>   to lack a platform description; the heuristic to decide this is whether
>   /chosen is the only node present at depth 1
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>



-Olof
