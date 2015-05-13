From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Registering a device driver before _INI?
Date: Thu, 14 May 2015 00:14:43 +0200
Message-ID: <3348174.NCS7iW2FVj@vostro.rjw.lan>
References: <CAOf41NnAjRG-2H=h8pUDBPQs2pePH4GNY0+XNnC+iXiRf30srA@mail.gmail.com> <5553A0F8.8000505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51474 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932137AbbEMVtc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2015 17:49:32 -0400
In-Reply-To: <5553A0F8.8000505@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: Adam Goode <agoode@google.com>, linux-acpi@vger.kernel.org

On Wednesday, May 13, 2015 01:07:36 PM Al Stone wrote:
> On 05/13/2015 10:25 AM, Adam Goode wrote:
> > The Macmini7,1 addresses SystemCMOS memory in _INI methods. Currently,
> > this fails since _INI is called before the acpi_cmos_rtc_space_handler
> > is registered.
> > 
> > I proposed registering a default handler on the ACPICA list, but was
> > told that because the device has a _HID it should require a device
> > driver.
> > 
> > So, is it possible to register a device driver before _INI is called?
> > Otherwise, Thunderbolt doesn't get initialized properly on this
> > hardware.
> 
> I take it from the question that the _INI methods are using the predefined
> SystemCMOS OperationRegion, correct?  Are the _INI methods invoking _REG
> before trying to access that region?  Looking at the spec, the _INI methods
> must first call _REG to see if SystemCMOS is available for use (see section
> 6.5.1), and there is no requirement that SystemCMOS must be available for
> use by _INI (see 6.5.4).  So, if I think about this from the spec point of
> view, it sounds like the _INI methods are non-compliant.  From the kernel
> perspective, the SystemCMOS region is created at a reasonable time and is
> available when it is required to be.
> 
> It seems to me that the correct answer is that there should indeed be a device
> driver connected to the _HID, but that it gets invoked just like any other
> driver, and has as part of its probe an invocation of some method to access
> the necessary items in the SystemCMOS (maybe add the method in an SSDT loaded
> at run-time?).  One could also hack around this by moving where in the kernel
> the SystemCMOS region gets created to some place before the _INI functions are
> invoked, but that feels klunky to me to handle firmware that may not be correct.

There may be another way: Add a DMI quirk for the affected Apple system to
acpi_cmos_rtc.c that would install the address space handler early (ie. before
_INI is executed) and make acpi_install_cmos_rtc_space_handler() return
immediately if the address space handler is already installed.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
