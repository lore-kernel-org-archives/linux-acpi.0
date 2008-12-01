From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC]  [PATCH] ACPI :Remove the EC space handler explicitly
	when failing in _REG object
Date: Mon, 01 Dec 2008 10:47:53 +0800
Message-ID: <1228099673.4035.139.camel@yakui_zhao.sh.intel.com>
References: <1227689447.4053.5.camel@yakui_zhao.sh.intel.com>
	 <492DAB8B.30409@gmail.com>
	 <1227749343.4053.32.camel@yakui_zhao.sh.intel.com>
	 <492E6B70.9010006@suse.de>
	 <1227841044.4035.70.camel@yakui_zhao.sh.intel.com>
	 <492FA6F5.7070105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57028 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbYLACkf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Nov 2008 21:40:35 -0500
In-Reply-To: <492FA6F5.7070105@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Fri, 2008-11-28 at 16:08 +0800, Alexey Starikovskiy wrote:

> > In the function of acpi_install_address_space_handler the following two
> > steps are done in ACPCA:
> >    a. Install the space handler for one operation region. This space
> > handler is applied for the same type operation region of every device.
> >    b. run the _REG object for all the operation regions using the space
> > id. It will enumerate the ACPI namespace to execute the _REG object for
> > the same operation region
> Unregister space handler will do all these things in opposite order, thus calling 
> failed _REG object once again, causing more damage.
According to the Spec the main function of _REG object is to inform the
AML code of change in the availability of an operation region. And the
spec doesn't state what should be done when failed _REG object happens.

On Linux when OS fails in evaluating the _REG object for EC device, the
EC device can't be initialized correctly. In such case the warning
message will be reported and the system can't work well.

But windows can work well on such broken BIOS. Maybe the incorrect
status of EC _REG object is ignored. But we can't confirm whether all
the incorrect status of EC _REG object is ignored on windows. At the
same time we can't confirm that the incorrect status of EC _REG object
is ignored in ACPICA interface function or EC device driver. 

Maybe on Linux the incorrect status of EC _REG object should be also
ignored. And it will be more reasonable that such workaround is added in
EC device driver(High level driver decides whether the incorrect stautus
can be ignored). At the same time as we can't know whether all the
incorrect status of EC _REG object is ignored on windows, we can do as
the following step:
    a. For the specific incorrect status, we can ignore it and continue
to initialize the EC device. For example: bug10237, the incorrect status
is AE_NOT_FOUND
    b. For the most incorrect status, we will remove the EC space
handler explicitly. (If not removed, maybe the kernel panic will be
reported)
    c. When more other incorrect status is reported by EC _REG object on
some other laptops, we can ignore the incorrect status of EC _REG object
and continue to initialize EC device.

Thanks.

> > 
> > If the space handler is removed in the function of
> > acpi_install_address_space_handler when failure in _REG object happens,
> > it is unnecessary to remove the space handler explicitly. 
> >    But in fact maybe there exists the _REG object for other operation
> > region besides EC operation region. If failure in _REG object happens,
> > maybe the space handler should not be applied for the corresponding
> > device. PCI space handler is used by all the PCI devices. It is
> > unreasonable that all the PCI devices can't use the pci space handler if
> > OS fails in the _REG object of one PCI device.
> >    So it is difficult to deal with this issue in the function of
> > acpi_install_address_space_handler.
> > 
> > Maybe it will be easy to deal with such issue in driver.
> > 
> >>>     But if the EC space handler is not removed and EC flag in AML code
> >>> still indicates that EC operation region is already accessible, the EC
> >>> internal register will be accessed in AML code. At the same time the
> >>> memory region pointed by acpi_ec is already freed. This is the fourth
> >>> argument of ec_space_handler.
> >> I already told you and here is second time -- your fixes come in wrong place.
> >> You should fix acpi_install_address_space_handler(), not all the callers of it.
> > It is difficult for me to fix this issue in
> > acpi_install_address_space_handler. I am not willing to change the code
> > of ACPICA. It is not very reasonable that all the failures in _REG
> > object for all the operations region are ignored.
> You have address space identifier in this function, so if you want your 
> workaround to be "only for EC", check it. 
> > And it is also unreasonable that the space handler is removed for the
> > same type operation region of all the devices only because OS fails in
> > _REG object of one device.
> > If you have better method to fix such issue, please write it. 
> Yakui, why should I complete all your jobs?
> 
> Alex.

