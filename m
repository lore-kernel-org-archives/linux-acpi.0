From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to prevent
 accessing PM registers
Date: Wed, 18 Sep 2013 17:31:32 +0800
Message-ID: <523972F4.9070703@linaro.org>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com> <52366F91.30204@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47985 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab3IRJeF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Sep 2013 05:34:05 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so8021819pad.16
        for <linux-acpi@vger.kernel.org>; Wed, 18 Sep 2013 02:34:04 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>

On 2013-9-17 1:26, Moore, Robert wrote:
> + #define ACPI_REDUCED_HARDWARE           TRUE
> 
> The intent of this feature is of course, to remove all code that is not needed -- specifically for hardware-reduced machines where the size of the kernel is important.
> 
> On a larger machine, the hardware-reduced flag should be sufficient. However, I would think that the host OS would look at this flag and realize that it should not be doing certain ACPI hardware-related things up front, rather than later when it finds out that a write to some ACPI hardware fails because the hardware isn't there.

Do you mean we should change the ACPI device driver instead of changing the
ACPICA code? that would be a hard job, because hardware ACPI is used
everywhere.

Thanks
Hanjun

> 
> This is not to say that it is probably a good thing to return an error from the ACPI hardware code in the hardware-reduced case.
> 
> Bob
> 


