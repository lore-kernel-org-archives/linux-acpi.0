From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] ACPI/IORT: fix build regression without IOMMU
Date: Mon, 28 Aug 2017 12:23:05 +0200
Message-ID: <a67c6a9b-9ea0-ac44-9aaa-5a6747b2e8b1@leemhuis.info>
References: <20170810121114.2509560-1-arnd@arndb.de>
 <20170810142430.GA17205@red-moon>
 <3fe9e409-b505-f9af-63b7-02e91918db9d@leemhuis.info>
 <20170828095759.GB8471@e107981-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828095759.GB8471@e107981-lin.cambridge.arm.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <jroedel@suse.de>, Sricharan R <sricharan@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Lo! On 28.08.2017 11:57, Lorenzo Pieralisiwrote:
> On Mon, Aug 28, 2017 at 11:27:20AM +0200, Thorsten Leemhuis wrote:
>
>> Was there any progress? Afaics that patch hasn't hit mainline yet (or
>> was it fixed by a different patch?). Asking because the issue is
>> mentioned in the regression report for 4.13.
> I do not understand how it can be mentioned in the 4.13 regression
> report given that it is code queued for 4.14 […]

Ohh, there is a simple explanation: Because I'm stupid and missed that
the commit Arnd mentioned was not in mainline :-/ I could have sworn I
checked that, but seems I did not.

Sorry for the noise & many thx for the answer!

Ciao, Thorsten
