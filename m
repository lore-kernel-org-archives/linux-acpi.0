From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/7] ACPI / processor: Introduce invalid_logical_cpuid()
Date: Tue, 05 May 2015 12:15:13 +0100
Message-ID: <5548A641.6050407@arm.com>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44474 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbbEELPR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 May 2015 07:15:17 -0400
In-Reply-To: <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>



On 05/05/15 03:46, Hanjun Guo wrote:
> In ACPI processor drivers, we use direct comparisons of cpu logical
> id with -1 which are error prone in case logical cpuid is accidentally
> assinged an error code and prevents us from returning an error-encoding
> cpuid directly in some cases.
>
> So introduce invalid_logical_cpuid() to identify cpu with invalid
> logical cpu num, then it will be used to replace the direct comparisons
> with -1.
>

Ah, OK I see that this fixes the issue I raised in PATCH 1/7, so I think
you need to reorder this and 1/7 patch IMO.

Regards,
Sudeep
