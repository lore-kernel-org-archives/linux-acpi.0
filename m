From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 2/5] genirq: irqdomain: Remove irqdomain dependency on
 struct device_node
Date: Wed, 22 Jul 2015 16:13:39 +0800
Message-ID: <55AF50B3.5090804@linaro.org>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com> <1437473280-11431-3-git-send-email-marc.zyngier@arm.com> <20150721175623.GA32187@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36349 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbbGVINs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jul 2015 04:13:48 -0400
Received: by pdjr16 with SMTP id r16so137357184pdj.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2015 01:13:47 -0700 (PDT)
In-Reply-To: <20150721175623.GA32187@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>

On 07/22/2015 01:56 AM, Lorenzo Pieralisi wrote:
> On Tue, Jul 21, 2015 at 11:07:57AM +0100, Marc Zyngier wrote:
>> struct device_node is very much DT specific, and the original authors
>> of the irqdomain subsystem recognized that tie, and went as far as
>> mentionning that this could be replaced by some "void *token",
>> should another firmware infrastructure be using it.
>
> Yes, that's similar to the problem Rafael solved with fwnode_handle,
> I do not know if we can extend the fwnode_handle to manage these
> generic tokens too, but the approach you have taken seem the right
> one to me (and you are doing this for components that are not really
> attached to struct device so I am not sure the fwnode_handle approach
> can be shoehorned to solve it).

If I understand correctly, fwnode_handle is not better , since
we need to update every caller of irqdomain functions as it's a new
type of pointer, that's will be the big change, void * is just fine.

Thanks
Hanjun
