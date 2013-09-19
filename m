From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
 prevent accessing PM registers
Date: Thu, 19 Sep 2013 04:42:40 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFEA7E@ORSMSX102.amr.corp.intel.com>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com>
 <52366F91.30204@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
 <523972F4.9070703@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFA437@ORSMSX102.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFEA4D@ORSMSX102.amr.corp.intel.com>
 <BA42942F2D0DED45AFB0A6216D1E951D49C82D4E@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31142 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab3ISEmm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Sep 2013 00:42:42 -0400
In-Reply-To: <BA42942F2D0DED45AFB0A6216D1E951D49C82D4E@SATLEXDAG01.amd.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Duran, Leo" <leo.duran@amd.com>, 'Hanjun Guo' <hanjun.guo@linaro.org>
Cc: "Box, David E" <david.e.box@intel.com>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>, "'Rafael J. Wysocki'" <rjw@sisk.pl>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, 'Len Brown' <lenb@kernel.org>



> -----Original Message-----
> From: Duran, Leo [mailto:leo.duran@amd.com]
> Sent: Wednesday, September 18, 2013 8:53 PM
> To: Moore, Robert; 'Hanjun Guo'
> Cc: Box, David E; 'linaro-kernel@lists.linaro.org'; 'patches@linaro.org';
> 'linaro-acpi@lists.linaro.org'; 'Rafael J. Wysocki'; 'linux-
> acpi@vger.kernel.org'; Zheng, Lv; 'Len Brown'
> Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
> prevent accessing PM registers
> 
> Ummh...
> 
> > -----Original Message-----
> > From: linaro-acpi-bounces@lists.linaro.org [mailto:linaro-acpi-
> > bounces@lists.linaro.org] On Behalf Of Moore, Robert
> > Sent: Wednesday, September 18, 2013 9:38 PM
> > To: 'Hanjun Guo'
> > Cc: Box, David E; 'linaro-kernel@lists.linaro.org';
> > 'patches@linaro.org'; 'linaro-acpi@lists.linaro.org'; 'Rafael J.
> > Wysocki'; 'linux-acpi@vger.kernel.org'; Zheng, Lv; 'Len Brown'
> > Subject: Re: [Linaro-acpi] [PATCH] ACPICA / hwreg: Use
> > acpi_gbl_reduced_hardware to prevent accessing PM registers
> >
> > While we are at it, here is the *complete* list of ACPICA interfaces
> > that are meaningless on a hardware-reduced platform.
> 
> Events are supported by hw-reduced ACPI 5.0, just in a different (non-
> legacy) way: GPIO-signaled events.
> So I'm wondering if perhaps a bit of refactoring is in order, rather than
> complete removal of all those functions?
> Leo
> 


GPIO events are drastically different than any other ACPI events. The model that ACPICA is using for these is that the native GPIO driver loads on detection of a GPIO _HID during the device detection namespace walk. Then:

Text from the ACPI specification below. Comments in parentheses are mine:

OSPM (GPIO driver) handles GPIO-signaled events as follows:
* The GPIO interrupt is handled by OSPM (GPIO driver) because it is listed in the _AEI object under a GPIO controller.
* When the event fires, OSPM (GPIO driver) handles the interrupt according to its mode and invokes the _EVT method (via AcpiEvaluateObject), passing it the pin number of the event.
* From this point on, handling is exactly like that for GPEs. The _EVT method does a Notify() on the appropriate device, (AcpiInstallNotifyHandler) and OS-specific mechanisms are used to notify the driver of the event.

None of the ACPICA interfaces below are required for this sequence of events.

Bob



> > If we are going to dynamically disable some of these interfaces, we
> > will need to disable all of them -- for completeness. So, this is
> > actually not a trivial change.
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
> >
> >
> >
> >
> >
> >
> >
> > > -----Original Message-----
> > > From: Moore, Robert
> > > Sent: Wednesday, September 18, 2013 8:09 AM
> > > To: Hanjun Guo
> > > Cc: 'Rafael J. Wysocki'; 'Len Brown'; Box, David E; Zheng, Lv;
> > 'linux-
> > > acpi@vger.kernel.org'; 'patches@linaro.org'; 'linaro-
> > > kernel@lists.linaro.org'; 'linaro-acpi@lists.linaro.org'
> > > Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware
> > > to prevent accessing PM registers
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> > > > Sent: Wednesday, September 18, 2013 2:32 AM
> > > > To: Moore, Robert
> > > > Cc: 'Rafael J. Wysocki'; 'Len Brown'; Box, David E; Zheng, Lv;
> > 'linux-
> > > > acpi@vger.kernel.org'; 'patches@linaro.org'; 'linaro-
> > > > kernel@lists.linaro.org'; 'linaro-acpi@lists.linaro.org'
> > > > Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware
> > to
> > > > prevent accessing PM registers
> > > >
> > > > On 2013-9-17 1:26, Moore, Robert wrote:
> > > > > + #define ACPI_REDUCED_HARDWARE           TRUE
> > > > >
> > > > > The intent of this feature is of course, to remove all code that
> > is
> > > > > not
> > > > needed -- specifically for hardware-reduced machines where the
> > > > size
> > of
> > > > the kernel is important.
> > > > >
> > > > > On a larger machine, the hardware-reduced flag should be
> > sufficient.
> > > > However, I would think that the host OS would look at this flag
> > > > and realize that it should not be doing certain ACPI
> > > > hardware-related things up front, rather than later when it finds
> > > > out that a write
> > to
> > > > some ACPI hardware fails because the hardware isn't there.
> > > >
> > > > Do you mean we should change the ACPI device driver instead of
> > > > changing the ACPICA code? that would be a hard job, because
> > hardware
> > > > ACPI is used everywhere.
> > > >
> > >
> > >
> > > I don't really know the answer to this, but something tells me that
> > bad
> > > things may happen when a driver expects the ACPI hardware to be
> > there, and
> > > it finds out that it isn't, simply by calling one of the ACPI
> > hardware
> > > interfaces.
> > >
> > > Or, we could word it this way: if a driver is expecting the ACPI
> > hardware
> > > to exist, and we are running on a hardware-reduced platform, why is
> > the
> > > driver being loaded in the first place?
> > >
> > > BTW, hardware-reduced is not restricted to ARM platforms.
> > >
> > >
> > >
> > >
> > > > Thanks
> > > > Hanjun
> > > >
> > > > >
> > > > > This is not to say that it is probably a good thing to return an
> > > > > error
> > > > from the ACPI hardware code in the hardware-reduced case.
> > > > >
> > > > > Bob
> > > > >
> > > >
> >
> >
> > _______________________________________________
> > Linaro-acpi mailing list
> > Linaro-acpi@lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-acpi
> 

