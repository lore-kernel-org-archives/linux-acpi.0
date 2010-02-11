From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC][PATCH 0/3] Introduce GPE refcounting (was: Re: Recent
 GPE patches - some questions.)
Date: Thu, 11 Feb 2010 19:36:13 +0200
Message-ID: <1265909773.9788.12.camel@maxim-laptop>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
	 <201002070317.47029.rjw@sisk.pl> <1265837393.8599.2.camel@maxim-laptop>
	 <201002102236.34881.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:33409 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab0BKRg3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2010 12:36:29 -0500
Received: by fxm7 with SMTP id 7so1494912fxm.28
        for <linux-acpi@vger.kernel.org>; Thu, 11 Feb 2010 09:36:28 -0800 (PST)
In-Reply-To: <201002102236.34881.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Wed, 2010-02-10 at 22:36 +0100, Rafael J. Wysocki wrote: 
> On Wednesday 10 February 2010, Maxim Levitsky wrote:
> > On Sun, 2010-02-07 at 03:17 +0100, Rafael J. Wysocki wrote: 
> > > On Sunday 07 February 2010, Rafael J. Wysocki wrote:
> > > > Hi,
> > > > 
> > > > On Wednesday 03 February 2010, Moore, Robert wrote:
> > > > > Matthew, 
> > > > > 
> > > > > Thanks for your response to my questions.
> > > > > 
> > > > > I've been thinking about these interfaces:
> > > > > 
> > > > > acpi_ref_runtime_gpe
> > > > > acpi_ref_wakeup_gpe
> > > > > acpi_unref_runtime_gpe
> > > > > acpi_unref_wakeup_gpe
> > > > > 
> > 
> > One minor, mostly off-topic question.
> > Currently to enable static wakeup one has to write /proc/acpi/wakeup.
> 
> That depends on the device.  For PCI devices there's another interface for
> that, which is /sys/devices/.../power/wakeup .
> 
> > Do you consider propagating device wakeup settings to acpi,
> > so /proc/acpi/wakeup could finally be deprecated?
> 
> We already do that for PCI devices.

Not in 2.6.33-rc6

maxim@maxim-laptop:~$ cat /proc/acpi/wakeup 
Device S-state   Status   Sysfs node
UHC1   S3 disabled  pci:0000:00:1d.0
UHC2   S3 disabled  pci:0000:00:1d.1
UHC3   S3 disabled  pci:0000:00:1d.2
UHC4   S3 disabled  pci:0000:00:1a.0
UHC5   S3 disabled  pci:0000:00:1a.1
EHC1   S3 disabled  pci:0000:00:1d.7
EHC2   S3 disabled  pci:0000:00:1a.7
EXP3   S4 disabled  pci:0000:00:1c.2
EXP5   S4 disabled  
EXP6   S4 disabled  
AZAL   S4 disabled  pci:0000:00:1b.0
MODM   S4 disabled  

maxim@maxim-laptop:~$ echo enabled | sudo tee  /sys/devices/pci0000
\:00/0000\:00\:1d.0/power/wakeup 
enabled

cat /sys/devices/pci0000\:00/0000\:00\:1d.0/power/wakeup enabled


maxim@maxim-laptop:~$ cat /proc/acpi/wakeup 
Device S-state   Status   Sysfs node
UHC1   S3 disabled  pci:0000:00:1d.0
UHC2   S3 disabled  pci:0000:00:1d.1
UHC3   S3 disabled  pci:0000:00:1d.2
UHC4   S3 disabled  pci:0000:00:1a.0
UHC5   S3 disabled  pci:0000:00:1a.1
EHC1   S3 disabled  pci:0000:00:1d.7
EHC2   S3 disabled  pci:0000:00:1a.7
EXP3   S4 disabled  pci:0000:00:1c.2
EXP5   S4 disabled  
EXP6   S4 disabled  
AZAL   S4 disabled  pci:0000:00:1b.0
MODM   S4 disabled  


Or am I mistaken somehow?

Best regards,
Maxim Levitsky

