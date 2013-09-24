From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
 prevent accessing PM registers
Date: Tue, 24 Sep 2013 00:20:08 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802465946@SHSMSX101.ccr.corp.intel.com>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com>
 <52366F91.30204@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
 <523972F4.9070703@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFA437@ORSMSX102.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFEA4D@ORSMSX102.amr.corp.intel.com>
 <523E6369.3050803@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35661 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406Ab3IXAUK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Sep 2013 20:20:10 -0400
In-Reply-To: <523E6369.3050803@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>

> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> Sent: Sunday, September 22, 2013 11:27 AM
> 
> On 2013-9-19 10:37, Moore, Robert wrote:
> > While we are at it, here is the *complete* list of ACPICA interfaces that are
> > meaningless on a hardware-reduced platform. If we are going to dynamically
> > disable some of these interfaces, we will need to disable all of them -- for
> > completeness. So, this is actually not a trivial change.
> 
> Yes, you are right.
> Actually, before I send this patch out, I searched all the ACPICA API on
> a hardware-reduced platform as you did, I found some of them will finally call
> acpi_hw_register_read/write(), so some of the ACPICA API do not need to change.
> 

I agreed.

My idea is to keep the call path implemented using non-HWREDUCED ACPI silicon not-changed, but changing the code inside of a function implemented with the non-HWREDUCED logic to contain a HWREDUCED logic.
This might be more reasonable.
So IMO, it is not a good idea to reduce the APIs, but need to re-implement the APIs using HWREDUCED logic.
And the non-HWREDUCED code inside of an API should be marked with ACPI_HARDWARE_REDUCED macro rather than the API itself be marked out.
If the APIs (aka., ACPI functionalities) are kept un-modified, the device drivers can be kept un-modified on HWREDUCED platforms.

Thanks
-Lv

> Some of these APIs are already disabled in linux kernel tree now, such as
> acpi_enable():
> acpi_status acpi_enable(void)
> {
> 	acpi_status status;
> 	int retry;
> 
> 	ACPI_FUNCTION_TRACE(acpi_enable);
> 
> 	/* ACPI tables must be present */
> 
> 	if (!acpi_tb_tables_loaded()) {
> 		return_ACPI_STATUS(AE_NO_ACPI_TABLES);
> 	}
> 
> 	/* If the Hardware Reduced flag is set, machine is always in acpi mode */
> 
> 	if (acpi_gbl_reduced_hardware) {
> 		return_ACPI_STATUS(AE_OK);
> 	}
> ...
> }
> 
> and some of them need to be disabled as you said.
> 
> >
> > I'll let the linux experts chime in on this one.
> > Bob
> >
> >
> > AcpiInstallSciHandler
> > AcpiRemoveSciHandler
> > AcpiInstallGlobalEventHandler
> > AcpiInstallFixedEventHandler
> > AcpiRemoveFixedEventHandler
> > AcpiInstallGpeHandler
> > AcpiRemoveGpeHandler
> > AcpiAcquireGlobalLock
> > AcpiReleaseGlobalLock
> > AcpiEnable
> > AcpiDisable
> > AcpiEnableEvent
> > AcpiDisableEvent
> > AcpiClearEvent
> > AcpiGetEventStatus
> > AcpiUpdateAllGpes
> > AcpiEnableGpe
> > AcpiDisableGpe
> > AcpiSetGpe
> > AcpiSetupGpeForWake
> > AcpiSetGpeWakeMask
> > AcpiClearGpe
> > AcpiGetGpeStatus
> > AcpiFinishGpe
> > AcpiDisableAllGpes
> > AcpiEnableAllRuntimeGpes
> > AcpiInstallGpeBlock
> > AcpiRemoveGpeBlock
> > AcpiGetGpeDevice
> > AcpiGetTimerResolution
> > AcpiGetTimer
> > AcpiGetTimerDuration
> > AcpiReadBitRegister
> > AcpiWriteBitRegister
> > AcpiSetFirmwareWakingVector
> > AcpiSetFirmwareWakingVector64
> > AcpiEnterSleepStateS4bios
> 

