From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Mon, 25 Nov 2013 05:10:46 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880248D1A8@SHSMSX101.ccr.corp.intel.com>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
 <528F9C65.7010302@linaro.org>
 <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
 <4285284.l8TssFvumi@vostro.rjw.lan> <528FF15C.4060300@linaro.org>
 <20131123163854.GA1817@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34426 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab3KYFKu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 00:10:50 -0500
In-Reply-To: <20131123163854.GA1817@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Al Stone <al.stone@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Matthew Garrett
> Sent: Sunday, November 24, 2013 12:39 AM
> 
> On Fri, Nov 22, 2013 at 05:05:48PM -0700, Al Stone wrote:
> 
> > For reduced hardware mode, however, I have to rely on the underlying
> > ACPICA reference implementation to behave properly.  Right now, ACPICA
> > relies on compile time changes to implement either reduced HW mode or
> > legacy mode so I have to follow suit.  When I looked at making ACPICA
> > change behavior at runtime, the changes became more and more invasive.
> > Since x86/ia64 depend on ACPICA to behave also, that seemed a far
> > more dangerous approach to me.
> 
> Ugh. Really? People have been fairly careful about making sure that the
> x86 SoC code is selected correctly at runtime, and losing that because
> ACPICA is broken would be a shame. I think this is something that needs
> to support runtime switching even if there's also support for building
> kernels that only implement the reduced hardware profile.

If my reading is correct, do you mean x86 SoCs should have already tested the code.

So if ARM need ACPI_REDUCED_HARDWARE to be defined, the <include/acpi/platform/aclinux.h> should have lines like:
#ifdef CONFIG_ARCH_IS_ACPI_REDUCED_HARDWARE
#define ACPI_REDUCED_HARDWARE TRUE
#endif
And ARCH_IS_ACPI_REDUCED_HARDWARE should only be selected by CONFIG_ARM.

Well, I don't have knowledge about "x86 ACPI_REDUCED_HARDWARE tests", so I don't have any idea on whether the above code or original one can reflect the real world.

Thanks and best regards
-Lv

> 
> --
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
