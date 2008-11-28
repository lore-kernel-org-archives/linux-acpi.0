From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC]  [PATCH] ACPI :Remove the EC space handler explicitly
	when failing in _REG object
Date: Fri, 28 Nov 2008 10:57:24 +0800
Message-ID: <1227841044.4035.70.camel@yakui_zhao.sh.intel.com>
References: <1227689447.4053.5.camel@yakui_zhao.sh.intel.com>
	 <492DAB8B.30409@gmail.com>
	 <1227749343.4053.32.camel@yakui_zhao.sh.intel.com>
	 <492E6B70.9010006@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61036 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbYK1CuZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Nov 2008 21:50:25 -0500
In-Reply-To: <492E6B70.9010006@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, 2008-11-27 at 17:42 +0800, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > On Thu, 2008-11-27 at 04:03 +0800, Alexey Starikovskiy wrote:
> >> This is hardly a "fix", you just disable EC on this machine... Famous 
> > Yes. This can't fix the issue on the box of bug11884. 
> > But in theory if the incorrect status is returned by
> > acpi_install_address_space_handler, the EC space handler should be
> > removed explicitly. Right? In such case the EC device will be disabled
> > on this box. 
> Wrong. If any function is allowed to fail, you should not call counter function
> to recover -- you don't call free() on failed malloc(), you don't call close() on
> failed open().

In the function of acpi_install_address_space_handler the following two
steps are done in ACPCA:
   a. Install the space handler for one operation region. This space
handler is applied for the same type operation region of every device.
   b. run the _REG object for all the operation regions using the space
id. It will enumerate the ACPI namespace to execute the _REG object for
the same operation region

If the space handler is removed in the function of
acpi_install_address_space_handler when failure in _REG object happens,
it is unnecessary to remove the space handler explicitly. 
   But in fact maybe there exists the _REG object for other operation
region besides EC operation region. If failure in _REG object happens,
maybe the space handler should not be applied for the corresponding
device. PCI space handler is used by all the PCI devices. It is
unreasonable that all the PCI devices can't use the pci space handler if
OS fails in the _REG object of one PCI device.
   So it is difficult to deal with this issue in the function of
acpi_install_address_space_handler.

Maybe it will be easy to deal with such issue in driver.

> >     But if the EC space handler is not removed and EC flag in AML code
> > still indicates that EC operation region is already accessible, the EC
> > internal register will be accessed in AML code. At the same time the
> > memory region pointed by acpi_ec is already freed. This is the fourth
> > argument of ec_space_handler.
> I already told you and here is second time -- your fixes come in wrong place.
> You should fix acpi_install_address_space_handler(), not all the callers of it.
It is difficult for me to fix this issue in
acpi_install_address_space_handler. I am not willing to change the code
of ACPICA. It is not very reasonable that all the failures in _REG
object for all the operations region are ignored.
And it is also unreasonable that the space handler is removed for the
same type operation region of all the devices only because OS fails in
_REG object of one device.
If you have better method to fix such issue, please write it. 

> >     In such case if the EC space handler is still accessed, OS will try
> > to access the memory region already freed. Maybe the kernel panic will
> > be reported and the system can't be booted.
> >     In fact we have a similar bug 10237. And on that box of bug10237 OS
> > fails in evaluating _REG object and then kernel panic is reported. 
> >     The workaround patch is that OS ignores the error and continue to
> > initialize EC device if AE_NOT_FOUND is returned by the _REG object.
> > In such case the system can be booted very normally.
> Yes, and this workaround should not be in EC driver too.
> >> "how windows runs on this machine?" is not answered...
> > Windows can work well on such boxes while Linux can't work well.This is
> > the gap between Linux and windows. It is our target to narrow the gap.
> > Maybe on windows the incorrect status returned by EC _REG object is
> > ignored by EC driver. In such case the EC device can be initialized
> > correctly.
> So, why you disable EC driver instead of ignoring error from _REG completely?
> By doing this, you are _widening_ the gap, not narrowing it.
> Please consider moving 20edd74fcf9ad02c19efba0c13670a7b6b045099 out of the ec.c and
> widen it to ignore failure from _REG method completely.
> >> Regards,
> >> Alex.
> 

