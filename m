From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v6 04/10] acpi: Add some basic struct and functions in
 GTDT driver
Date: Wed, 29 Jun 2016 23:13:30 -0500
Message-ID: <57749C6A.9070900@codeaurora.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <CAJZ5v0gw7E6DnGhpACAws2WdF3j=eUkjKBhfo2RKmyKnpoLUbQ@mail.gmail.com>
 <CADyBb7v70YVL4yM_U335eQfa+NEd+jXDEaMN3iAhgnyL9Dk=WA@mail.gmail.com>
 <3079554.3ECV4uzklN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50757 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbcF3EOX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2016 00:14:23 -0400
In-Reply-To: <3079554.3ECV4uzklN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fu Wei <fu.wei@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Suravee Suthikulanit <Suravee.Suthikulpanit@amd>

Rafael J. Wysocki wrote:
> That's not enough.  The [0/10] will not go into the git log, mind you.

The changelog is placed under the "---", so it wouldn't go into the git 
log anyway.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
