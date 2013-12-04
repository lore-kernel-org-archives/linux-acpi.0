From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Wed, 4 Dec 2013 01:34:30 +0000
Message-ID: <20131204013430.GA25154@srcf.ucam.org>
References: <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
 <4285284.l8TssFvumi@vostro.rjw.lan>
 <528FF15C.4060300@linaro.org>
 <20131123163854.GA1817@srcf.ucam.org>
 <1AE640813FDE7649BE1B193DEA596E880248D1A8@SHSMSX101.ccr.corp.intel.com>
 <20131125153016.GA3243@srcf.ucam.org>
 <52938C3F.20905@linaro.org>
 <20131125174552.GA7417@srcf.ucam.org>
 <52939064.6090803@linaro.org>
 <529E85C8.5050805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41022 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab3LDBel (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Dec 2013 20:34:41 -0500
Content-Disposition: inline
In-Reply-To: <529E85C8.5050805@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Tue, Dec 03, 2013 at 06:30:48PM -0700, Al Stone wrote:

> I thought I could get this to work, but I am going to have to defer
> to the ACPICA upstream folks.  For the time being, I think that all
> of the architectures that want to use ACPI in either legacy mode or
> in stripped down reduced HW mode will have to use different kernels,
> one for each mode.  I thought there might be enough safety checks to
> allow the kernel to boot in legacy mode and switch into reduced HW at
> boot, but there are not, in my opinion.  I don't see a way to make the
> switch *and* maintain conformance with the spec without significant
> change to ACPICA itself.

Ugh. That needs fixing. There's been a huge amount of work done to 
ensure that x86 only needs a single kernel image for 64-bit, it really 
needs to be runtime. We shouldn't have merged it in this state.

> For example, enforcing that various functions are not allowed while
> in reduced HW mode could be done by a check of the reduced HW flag on
> entry.  If it is set, return the value the function would have returned
> had it been stubbed out for reduced HW mode.  This is simple enough but
> to do so would require modifying at least 29 functions in ACPICA, by my
> count, not something upstream is particularly keen on -- nor am I.  I'd
> rather step back and work with ACPICA over the longer term and see if
> there's some way to get this functionality implemented properly instead
> of trying to bolt it on somehow.

How many of those are calls that we'll actually execute in the HW 
reduced case?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
