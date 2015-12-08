From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] ACPI: Add phylib support code for mdio
Date: Tue, 8 Dec 2015 12:55:59 -0700
Message-ID: <566735CF.30000@redhat.com>
References: <1449107683-69717-1-git-send-email-yankejian@huawei.com>
 <20151203104724.GB11655@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbbLHT4C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2015 14:56:02 -0500
In-Reply-To: <20151203104724.GB11655@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>, yankejian <yankejian@huawei.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, davem@davemloft.net, liguozhu@huawei.com, yisen.zhuang@huawei.com, huangdaode@hisilicon.com, lipeng321@huawei.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com

On 12/03/2015 03:47 AM, Graeme Gregory wrote:
> On Thu, Dec 03, 2015 at 09:54:43AM +0800, yankejian wrote:
>> Add support for getting the PHY devices on an MDIO bus by ACPI.
>> Currently many of the ethernet drivers are open coding a solution
>> for reading data out of ACPI to find the correct PHY device.
>> This patch implements a set of common routines are similar to of_mdio.c
>>
> 
> The general conclusion for the ACPI on ARM64 discussion so far has been that
> things like PHYs should be setup by the firmware before the kernel takes
> control.
> 
> I am unsure that this doing it the same way as DT with a different
> description language is the way to go.
> 
> Graeme

I have to agree with Graeme: if this is supposed to be an arm64 server using
ACPI, please make sure the PHYs/clocks/regulators are set up properly before
passing control to the kernel.  That's the consensus so far on how this is to
be done.

This also looks to be using _DSD in ACPI, which is another topic that's still
under discussion.  What does the ASL look like for these PHYs, as used in this
patch?

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
