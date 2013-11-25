From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Mon, 25 Nov 2013 17:45:52 +0000
Message-ID: <20131125174552.GA7417@srcf.ucam.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
 <528F9C65.7010302@linaro.org>
 <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
 <4285284.l8TssFvumi@vostro.rjw.lan>
 <528FF15C.4060300@linaro.org>
 <20131123163854.GA1817@srcf.ucam.org>
 <1AE640813FDE7649BE1B193DEA596E880248D1A8@SHSMSX101.ccr.corp.intel.com>
 <20131125153016.GA3243@srcf.ucam.org>
 <52938C3F.20905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56957 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab3KYRqC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 12:46:02 -0500
Content-Disposition: inline
In-Reply-To: <52938C3F.20905@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Mon, Nov 25, 2013 at 10:43:27AM -0700, Al Stone wrote:
> On 11/25/2013 08:30 AM, Matthew Garrett wrote:
> >Is ACPI_REDUCED_HARDWARE supposed to indicate support for the reduced
> >hardware profile, or that the platform *only* implements the reduced
> >hardware profile?
> 
> From what I can see in ACPICA, ACPI_REDUCED_HARDWARE indicates the
> platform *only* implements the reduced hardware profile.  This *seems*
> to be consistent with the specification -- see 3.11.1, second bullet,
> for example:

Ok, so a kernel built without ACPI_REDUCED_HARDWARE would still support 
the reduced hardware profile?

> ...if by "not supported" one takes that to mean "does not exist when
> compiled."  I can look at the ACPICA code again, just the same; perhaps
> there is some reasonable way to at least select one or the other at boot
> as the first step, and then allow switching between modes as a later
> step.

I don't think you'd ever want to switch after init time. There's a flag 
in the FADT that indicates whether a system is implementing the reduced 
hardware profile or not.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
