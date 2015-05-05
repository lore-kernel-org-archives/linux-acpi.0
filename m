From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/7] ACPI / processor: Introduce invalid_logical_cpuid()
Date: Tue, 05 May 2015 14:04:08 +0200
Message-ID: <3818196.qc8c4isrQe@vostro.rjw.lan>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org> <5548A641.6050407@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53854 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758382AbbEELjH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2015 07:39:07 -0400
In-Reply-To: <5548A641.6050407@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Tuesday, May 05, 2015 12:15:13 PM Sudeep Holla wrote:
> 
> On 05/05/15 03:46, Hanjun Guo wrote:
> > In ACPI processor drivers, we use direct comparisons of cpu logical
> > id with -1 which are error prone in case logical cpuid is accidentally
> > assinged an error code and prevents us from returning an error-encoding
> > cpuid directly in some cases.
> >
> > So introduce invalid_logical_cpuid() to identify cpu with invalid
> > logical cpu num, then it will be used to replace the direct comparisons
> > with -1.
> >
> 
> Ah, OK I see that this fixes the issue I raised in PATCH 1/7, so I think
> you need to reorder this and 1/7 patch IMO.

Well, comparing an unsigned int with -1 is not technically invalid (although it
involves an implicit type conversion), but yes, Hanjun, please reorder the
patches.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
