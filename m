From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] genirq: irqdomain: Use an accessor for the of_node
 field
Date: Wed, 22 Jul 2015 09:58:45 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507220958090.18576@nanos>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com> <1437473280-11431-2-git-send-email-marc.zyngier@arm.com> <55AF47D7.8010304@linaro.org> <55AF4BBA.5030209@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AF4BBA.5030209@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 22 Jul 2015, Marc Zyngier wrote:
> 
> Looks like my coccinelle foo is still lacking a bit... Oh well.

Please post your semantic patch and don't forget to Cc Julia Lawall :)
