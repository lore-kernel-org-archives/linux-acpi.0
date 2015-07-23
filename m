From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH 2/5] genirq: irqdomain: Remove irqdomain dependency on
 struct device_node
Date: Thu, 23 Jul 2015 15:59:37 +0700
Message-ID: <55B0ACF9.4080403@amd.com>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-3-git-send-email-marc.zyngier@arm.com>
 <20150721175623.GA32187@red-moon> <55AF50B3.5090804@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55AF50B3.5090804@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org



On 7/22/15 15:13, Hanjun Guo wrote:
> On 07/22/2015 01:56 AM, Lorenzo Pieralisi wrote:
>> On Tue, Jul 21, 2015 at 11:07:57AM +0100, Marc Zyngier wrote:
>>> struct device_node is very much DT specific, and the original authors
>>> of the irqdomain subsystem recognized that tie, and went as far as
>>> mentionning that this could be replaced by some "void *token",
>>> should another firmware infrastructure be using it.
>>
>> Yes, that's similar to the problem Rafael solved with fwnode_handle,
>> I do not know if we can extend the fwnode_handle to manage these
>> generic tokens too, but the approach you have taken seem the right
>> one to me (and you are doing this for components that are not really
>> attached to struct device so I am not sure the fwnode_handle approach
>> can be shoehorned to solve it).
>
> If I understand correctly, fwnode_handle is not better , since
> we need to update every caller of irqdomain functions as it's a new
> type of pointer, that's will be the big change, void * is just fine.

Also, the fwnode_handle is mainly used to represent the DSDT device 
entry. In case of ACPI, GICv2m and ITS domain does not have a 
corresponded DSDT entry, but it uses other table. I am agree with just 
keeping this as void *.

Thanks,

Suravee
