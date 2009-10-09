From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.32-rc3: floating-point build failure (undefined reference
 to `__udivdi3' in menu governor)
Date: Fri, 09 Oct 2009 10:12:15 -0700
Message-ID: <4ACF6EEF.3090101@linux.intel.com>
References: <20091007104125.GA1449@rhlx01.hs-esslingen.de> <4ACCA44B.3070706@linux.intel.com> <20091007173457.GA25415@rhlx01.hs-esslingen.de> <20091007174553.GC11702@bombadil.infradead.org> <20091009160123.GA14808@rhlx01.hs-esslingen.de> <4ACF658D.4010605@linux.intel.com> <20091009170803.GE11702@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49664 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761158AbZJIRNa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2009 13:13:30 -0400
In-Reply-To: <20091009170803.GE11702@bombadil.infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Kyle McMartin wrote:
> On Fri, Oct 09, 2009 at 09:32:13AM -0700, Arjan van de Ven wrote:
>>> Hmpf. Rather stuck now, ain'tcha, given that gcc 3.2.3 doesn't even have those?
>>>
>> wonder if making a new define with the value of RESOLUTION * DECAY
>> (the actual value obviously) convinces your gcc that it really is a power of two ?
>>
> 
> It shouldn't. Maybe just add a BUILD_BUG_ON and change the divide to a
> shift directly. How expected are these values to ever change, really?
> 

so far... they haven't. I don't really expect these to change much.
maybe once a year or so... to other powers of two

