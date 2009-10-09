From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: 2.6.32-rc3: floating-point build failure (undefined reference
	to `__udivdi3' in menu governor)
Date: Fri, 9 Oct 2009 13:08:04 -0400
Message-ID: <20091009170803.GE11702@bombadil.infradead.org>
References: <20091007104125.GA1449@rhlx01.hs-esslingen.de> <4ACCA44B.3070706@linux.intel.com> <20091007173457.GA25415@rhlx01.hs-esslingen.de> <20091007174553.GC11702@bombadil.infradead.org> <20091009160123.GA14808@rhlx01.hs-esslingen.de> <4ACF658D.4010605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:53182 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbZJIRIn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2009 13:08:43 -0400
Content-Disposition: inline
In-Reply-To: <4ACF658D.4010605@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andreas Mohr <andi@lisas.de>, Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Oct 09, 2009 at 09:32:13AM -0700, Arjan van de Ven wrote:
>> Hmpf. Rather stuck now, ain'tcha, given that gcc 3.2.3 doesn't even have those?
>>
>
> wonder if making a new define with the value of RESOLUTION * DECAY
> (the actual value obviously) convinces your gcc that it really is a power of two ?
>

It shouldn't. Maybe just add a BUILD_BUG_ON and change the divide to a
shift directly. How expected are these values to ever change, really?

-Kyle
