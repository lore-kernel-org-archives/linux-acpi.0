From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [RFC PATCH] Fix _FIT vs. NFIT processing breakage
Date: Thu, 19 Nov 2015 15:16:37 -0500
Message-ID: <564E2E25.2050705@hpe.com>
References: <20151118175359.GA2209@ljk840.redhat.com>		 <1447880848.30346.9.camel@intel.com> <564CED90.5000501@hpe.com>		 <1447885355.21443.159.camel@hpe.com> <1447890234.30346.20.camel@intel.com>	 <564DF807.7080208@hpe.com> <1447960056.30346.28.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t6214.austin.hp.com ([15.73.96.122]:45915 "EHLO
	g1t6214.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161428AbbKSUQj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2015 15:16:39 -0500
In-Reply-To: <1447960056.30346.28.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "elliott@hpe.com" <elliott@hpe.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On 11/19/2015 2:07 PM, Verma, Vishal L wrote:
> On Thu, 2015-11-19 at 11:25 -0500, Linda Knippers wrote:
>
> <>
>> Yes, I will do that.  I've only tested the boot path of the patch though.
>> Is there an easy way for me to trigger the notification so I can test the
>> other code path?
>>
>
> Hm, I don't believe there is an easy way yet. I believe KVM enabling for
> NVDIMMS using the NFIT is under way, and once they are ready we might have a
> way to test that path, but for now I just tested acpi_nfit_init onward using
> the test framework in tools/testing/nvdimm.

After looking around for some generic way to get an ACPI device
notify function called and failing miserably, I ended up just hacking the
nfit.c revision_show() function to call the notify function any time I look
at the /sys/.../nfit/revision file.

It's complaining that the new nfit deletes entries so I'm looking into that.

-- ljk
