From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Mon, 25 Nov 2013 15:30:16 +0000
Message-ID: <20131125153016.GA3243@srcf.ucam.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
 <528F9C65.7010302@linaro.org>
 <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
 <4285284.l8TssFvumi@vostro.rjw.lan>
 <528FF15C.4060300@linaro.org>
 <20131123163854.GA1817@srcf.ucam.org>
 <1AE640813FDE7649BE1B193DEA596E880248D1A8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54543 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab3KYPac (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 10:30:32 -0500
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880248D1A8@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Al Stone <al.stone@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Mon, Nov 25, 2013 at 05:10:46AM +0000, Zheng, Lv wrote:
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Matthew Garrett
> > Ugh. Really? People have been fairly careful about making sure that the
> > x86 SoC code is selected correctly at runtime, and losing that because
> > ACPICA is broken would be a shame. I think this is something that needs
> > to support runtime switching even if there's also support for building
> > kernels that only implement the reduced hardware profile.
> 
> If my reading is correct, do you mean x86 SoCs should have already tested the code.

I don't know if anyone has deployed x86 SoCs with reduced hardware yet, 
but it seems like something that might happen.

> So if ARM need ACPI_REDUCED_HARDWARE to be defined, the <include/acpi/platform/aclinux.h> should have lines like:
> #ifdef CONFIG_ARCH_IS_ACPI_REDUCED_HARDWARE
> #define ACPI_REDUCED_HARDWARE TRUE
> #endif
> And ARCH_IS_ACPI_REDUCED_HARDWARE should only be selected by CONFIG_ARM.

Is ACPI_REDUCED_HARDWARE supposed to indicate support for the reduced 
hardware profile, or that the platform *only* implements the reduced 
hardware profile?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
