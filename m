From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to prevent
 accessing PM registers
Date: Sun, 22 Sep 2013 11:26:33 +0800
Message-ID: <523E6369.3050803@linaro.org>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com> <52366F91.30204@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com> <523972F4.9070703@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFA437@ORSMSX102.amr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFEA4D@ORSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47525 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab3IVD2t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Sep 2013 23:28:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so953394pab.11
        for <linux-acpi@vger.kernel.org>; Sat, 21 Sep 2013 20:28:49 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFEA4D@ORSMSX102.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>

On 2013-9-19 10:37, Moore, Robert wrote:
> While we are at it, here is the *complete* list of ACPICA interfaces that are 
> meaningless on a hardware-reduced platform. If we are going to dynamically
> disable some of these interfaces, we will need to disable all of them -- for
> completeness. So, this is actually not a trivial change.

Yes, you are right.
Actually, before I send this patch out, I searched all the ACPICA API on
a hardware-reduced platform as you did, I found some of them will finally call
acpi_hw_register_read/write(), so some of the ACPICA API do not need to change.

Some of these APIs are already disabled in linux kernel tree now, such as
acpi_enable():
acpi_status acpi_enable(void)
{
	acpi_status status;
	int retry;

	ACPI_FUNCTION_TRACE(acpi_enable);

	/* ACPI tables must be present */

	if (!acpi_tb_tables_loaded()) {
		return_ACPI_STATUS(AE_NO_ACPI_TABLES);
	}

	/* If the Hardware Reduced flag is set, machine is always in acpi mode */

	if (acpi_gbl_reduced_hardware) {
		return_ACPI_STATUS(AE_OK);
	}
...
}

and some of them need to be disabled as you said.

> 
> I'll let the linux experts chime in on this one.
> Bob
> 
> 
> AcpiInstallSciHandler
> AcpiRemoveSciHandler
> AcpiInstallGlobalEventHandler
> AcpiInstallFixedEventHandler
> AcpiRemoveFixedEventHandler
> AcpiInstallGpeHandler
> AcpiRemoveGpeHandler
> AcpiAcquireGlobalLock
> AcpiReleaseGlobalLock
> AcpiEnable
> AcpiDisable
> AcpiEnableEvent
> AcpiDisableEvent
> AcpiClearEvent
> AcpiGetEventStatus
> AcpiUpdateAllGpes
> AcpiEnableGpe
> AcpiDisableGpe
> AcpiSetGpe
> AcpiSetupGpeForWake
> AcpiSetGpeWakeMask
> AcpiClearGpe
> AcpiGetGpeStatus
> AcpiFinishGpe
> AcpiDisableAllGpes
> AcpiEnableAllRuntimeGpes
> AcpiInstallGpeBlock
> AcpiRemoveGpeBlock
> AcpiGetGpeDevice
> AcpiGetTimerResolution
> AcpiGetTimer
> AcpiGetTimerDuration
> AcpiReadBitRegister
> AcpiWriteBitRegister
> AcpiSetFirmwareWakingVector
> AcpiSetFirmwareWakingVector64
> AcpiEnterSleepStateS4bios


