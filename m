From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC]  [PATCH] ACPI :Remove the EC space handler explicitly	when
 failing in _REG object
Date: Fri, 28 Nov 2008 11:08:21 +0300
Message-ID: <492FA6F5.7070105@suse.de>
References: <1227689447.4053.5.camel@yakui_zhao.sh.intel.com>	 <492DAB8B.30409@gmail.com>	 <1227749343.4053.32.camel@yakui_zhao.sh.intel.com>	 <492E6B70.9010006@suse.de> <1227841044.4035.70.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55286 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750811AbYK1IIZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Nov 2008 03:08:25 -0500
In-Reply-To: <1227841044.4035.70.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

Zhao Yakui wrote:
> On Thu, 2008-11-27 at 17:42 +0800, Alexey Starikovskiy wrote:
>> Zhao Yakui wrote:
>>> On Thu, 2008-11-27 at 04:03 +0800, Alexey Starikovskiy wrote:
>>>> This is hardly a "fix", you just disable EC on this machine... Famous 
>>> Yes. This can't fix the issue on the box of bug11884. 
>>> But in theory if the incorrect status is returned by
>>> acpi_install_address_space_handler, the EC space handler should be
>>> removed explicitly. Right? In such case the EC device will be disabled
>>> on this box. 
>> Wrong. If any function is allowed to fail, you should not call counter function
>> to recover -- you don't call free() on failed malloc(), you don't call close() on
>> failed open().
> 
> In the function of acpi_install_address_space_handler the following two
> steps are done in ACPCA:
>    a. Install the space handler for one operation region. This space
> handler is applied for the same type operation region of every device.
>    b. run the _REG object for all the operation regions using the space
> id. It will enumerate the ACPI namespace to execute the _REG object for
> the same operation region
Unregister space handler will do all these things in opposite order, thus calling 
failed _REG object once again, causing more damage.
> 
> If the space handler is removed in the function of
> acpi_install_address_space_handler when failure in _REG object happens,
> it is unnecessary to remove the space handler explicitly. 
>    But in fact maybe there exists the _REG object for other operation
> region besides EC operation region. If failure in _REG object happens,
> maybe the space handler should not be applied for the corresponding
> device. PCI space handler is used by all the PCI devices. It is
> unreasonable that all the PCI devices can't use the pci space handler if
> OS fails in the _REG object of one PCI device.
>    So it is difficult to deal with this issue in the function of
> acpi_install_address_space_handler.
> 
> Maybe it will be easy to deal with such issue in driver.
> 
>>>     But if the EC space handler is not removed and EC flag in AML code
>>> still indicates that EC operation region is already accessible, the EC
>>> internal register will be accessed in AML code. At the same time the
>>> memory region pointed by acpi_ec is already freed. This is the fourth
>>> argument of ec_space_handler.
>> I already told you and here is second time -- your fixes come in wrong place.
>> You should fix acpi_install_address_space_handler(), not all the callers of it.
> It is difficult for me to fix this issue in
> acpi_install_address_space_handler. I am not willing to change the code
> of ACPICA. It is not very reasonable that all the failures in _REG
> object for all the operations region are ignored.
You have address space identifier in this function, so if you want your 
workaround to be "only for EC", check it. 
> And it is also unreasonable that the space handler is removed for the
> same type operation region of all the devices only because OS fails in
> _REG object of one device.
> If you have better method to fix such issue, please write it. 
Yakui, why should I complete all your jobs?

Alex.
