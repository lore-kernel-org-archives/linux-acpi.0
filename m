From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/5] genirq: irqdomain: Use an accessor for the of_node
 field
Date: Wed, 22 Jul 2015 13:43:34 +0100
Message-ID: <55AF8FF6.3080901@arm.com>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com> <1437473280-11431-2-git-send-email-marc.zyngier@arm.com> <55AF47D7.8010304@linaro.org> <55AF4BBA.5030209@arm.com> <alpine.DEB.2.11.1507220958090.18576@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35660 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbbGVMni (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jul 2015 08:43:38 -0400
In-Reply-To: <alpine.DEB.2.11.1507220958090.18576@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>

On 22/07/15 08:58, Thomas Gleixner wrote:
> On Wed, 22 Jul 2015, Marc Zyngier wrote:
>>
>> Looks like my coccinelle foo is still lacking a bit... Oh well.
> 
> Please post your semantic patch and don't forget to Cc Julia Lawall :)
> 

Bah, found the problem. My semantic patch is extremely simple:

@init@
struct irq_domain *ptr;
position pos;
@@

(
ptr@pos->of_node
)


@ script:python @
p1 << init.pos;
@@

for p in p1:
    print "%s:%s" % (p.file,p.line)

as I'm just grepping through the tree (I don't feel confident enough to
do the patching, and some cases are a bit more complicated).

But I forgot to add arch/$ARCH/include/asm as an include search path for
spatch. That had the side effect of spatch being unable to identify
constructs like:

arch/$ARCH/include/asm/foo.h:

	struct foo {
		struct irq_domain *bar;
	};

arch/$ARCH/.../foo.c:

	struct foo foo;
	if (foo->bar->of_node) { ... }

Since spatch knows nothing about struct foo, it cannot identify bar as a
struct irq_domain, hence missing this occurrence.

Once I fixed the include path, I found an additional couple of victims.
I really love this thing! :-)

	M.
-- 
Jazz is not dead. It just smells funny...
