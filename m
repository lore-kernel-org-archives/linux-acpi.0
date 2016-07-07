From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: Regression between rc2 and rc6: ACPI EC problems
Date: Thu, 7 Jul 2016 00:30:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC007CE@SHSMSX101.ccr.corp.intel.com>
References: <20160706141410.GA1430@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57271 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755811AbcGGAaK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2016 20:30:10 -0400
In-Reply-To: <20160706141410.GA1430@tetsubishi>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Wolfram

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Wolfram Sang
> Subject: Regression between rc2 and rc6: ACPI EC problems
> 
> Hi,
> 
> when upgrading from v4.7-rc2 to rc6 on my Dell Mini 9, battery and
> temperature status info got bogus. Here is the major change between the
> boot logs:
> 
> ACPI : EC: EC stopped
> ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for
> [EmbeddedControl] (20160422/evregion-300)
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG]
> (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
> ACPI Exception: AE_BAD_PARAMETER, from region _REG,
> [EmbeddedControl] (20160422/evregion-397)
> ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for
> [EmbeddedControl] (20160422/evregion-300)
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG]
> (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
> ACPI Exception: AE_BAD_PARAMETER, from region _REG,
> [EmbeddedControl] (20160422/evregion-397)
> ACPI : EC: GPE = 0x19, I/O: command/status = 0x66, data = 0x62
> ACPI : EC: EC started
> 
> The only config changes between the kernels were enabling MMC block
> devices and DM_CRYPT. Not likely to cause the above, I'd think.
> 
> Does that ring a bell for someone? This little machine has only an SSD
> without TRIM, so bisecting is not really an option. I can provide more
> info and test patches, though.
[Lv Zheng] 
Please just ignore this for several release cycles.
We need strategy to fix the ACPI initialization order issues.
This is already a noted non-function-failure issue.
We just need to fix the functional ones prior than this.

Thanks and best regards
-Lv
