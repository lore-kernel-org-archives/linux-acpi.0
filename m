From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: Regression in 3.1 causes Xen to use wrong idle routine
Date: Wed, 26 Oct 2011 15:57:15 +0200
Message-ID: <4EA811BB.6010005@canonical.com>
References: <4EA7DFD1.9060608@canonical.com> <20111026133003.GA6654@phenom.dumpdata.com> <4EA80CF2.5040309@canonical.com> <20111026134843.GA31609@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52021 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247Ab1JZN5T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2011 09:57:19 -0400
In-Reply-To: <20111026134843.GA31609@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: len.brown@intel.com, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 26.10.2011 15:48, Konrad Rzeszutek Wilk wrote:
>>> What about using the cpuidle_disabled() functionality and adhere to that?
>>> As so:
>>>
> .. snip..
>>
>> >From reading over it, this should work. Though I would be interested to hear
>> from the linux-acpi folks. Also to double check that calling pm_idle when
>> cpuidle.off was specified really is what is intended.
> 
> Oh yeah, definitly need the input from linux-acpi folks. And also to be actually
> tested :-)

I can volunteer to do the testing. But I am lazy enough to hold back a bit as
someone may tell us this is completely the wrong way to fix it. :)
