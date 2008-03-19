From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI : Disable the device's ability to wake the
	sleepingsystem in the boot phase
Date: Wed, 19 Mar 2008 11:30:33 +0800
Message-ID: <1205897433.4078.15.camel@yakui_zhao.sh.intel.com>
References: <1205819272.15975.3.camel@yakui_zhao.sh.intel.com>
	 <1205894414.28955.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53088 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756836AbYCSThW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 15:37:22 -0400
In-Reply-To: <1205894414.28955.2.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Wed, 2008-03-19 at 10:40 +0800, Shaohua Li wrote:
> On Tue, 2008-03-18 at 13:47 +0800, Zhao Yakui wrote:
> > Subject: ACPI : Disable the device's ability to wake the sleeping
> > system in the boot phase
> > >From : Zhao Yakui <yakui.zhao@intel.com>
> > 
> > In some machines some GPE is shared by several ACPI devices, for
> > example:
> > sleep button, keyboard, mouse. At the same time one of them is
> > non-wake(runtime) device and the other are wake devices. In such case
> > OSPM
> > should call the _PSW object to disable the device's ability to
> > wake the sleeping system in the boot phase.
> > Otherwise there will be ACPI interrupt flood triggered by the GPE
> > input.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=9781
> > http://bugzilla.kernel.org/show_bug.cgi?id=10224
> Good catch, but I'm wondering if we should call _PSR early, eg in ACPICA
> before GPE is enabled. Before the acpi bus scan time, the GPE might
> already be invoked and cause interrupt flood.
> 
Thanks for the reminder. 
After check the source code, I think that it is unnecessary to call the
_PSM in ACPICA. The _GPE with the _PRW object will be disabled when the
FADT GPE block device is installed in ACPICA.
For the desktops in bug9781 and 10224, there will be ACPI interrupt
flood only after the shared GPE is reenabled.(This is enabled in the
button driver).

Thanks
   Yakui.
> Thanks,
> Shaohua 
> 

