From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] IRQ resource deallocation[0/2]
Date: Wed, 08 Dec 2004 16:07:35 +0900
Message-ID: <41B6A837.4030505@jp.fujitsu.com>
References: <41B559DD.7040307@jp.fujitsu.com> <Pine.LNX.4.61.0412070820240.13396@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412070820240.13396@montezuma.fsmlabs.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Zwane Mwaikambo wrote:

> On Tue, 7 Dec 2004, Kenji Kaneshige wrote:
> 
>> I had posted the IRQ resource deallocation patch a couple of monthes
>> ago and I had incorporated all feedbacks from the mailing list
>> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109688530703122&w=2).
>> But it doesn't seems to be included yet, so I would like to try again.
>> I hope my patch is included onto -mm tree since I want the patches
>> be tested by many people.
> 
> You should remove the config option and make it unconditional.
> 

I think you're right. I'll update the patch.

Thanks,
Kenji Kaneshige

