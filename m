From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC]  [PATCH] ACPI :Remove the EC space handler explicitly
	when failing in _REG object
Date: Mon, 01 Dec 2008 09:53:43 +0800
Message-ID: <1228096423.4035.111.camel@yakui_zhao.sh.intel.com>
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
Received: from mga11.intel.com ([192.55.52.93]:50678 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473AbYLABqO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Nov 2008 20:46:14 -0500
In-Reply-To: <492FA6F5.7070105@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Fri, 2008-11-28 at 16:08 +0800, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > On Thu, 2008-11-27 at 17:42 +0800, Alexey Starikovskiy wrote:
> >> Zhao Yakui wrote:
> >>> On Thu, 2008-11-27 at 04:03 +0800, Alexey Starikovskiy wrote:
> >>>> This is hardly a "fix", you just disable EC on this machine... Famous 
> >>> Yes. This can't fix the issue on the box of bug11884. 
> >>> But in theory if the incorrect status is returned by
> >>> acpi_install_address_space_handler, the EC space handler should be
> >>> removed explicitly. Right? In such case the EC device will be disabled
> >>> on this box. 
> >> Wrong. If any function is allowed to fail, you should not call counter function
> >> to recover -- you don't call free() on failed malloc(), you don't call close() on
> >> failed open().
> > 
> > In the function of acpi_install_address_space_handler the following two
> > steps are done in ACPCA:
> >    a. Install the space handler for one operation region. This space
> > handler is applied for the same type operation region of every device.
> >    b. run the _REG object for all the operation regions using the space
> > id. It will enumerate the ACPI namespace to execute the _REG object for
> > the same operation region
> Unregister space handler will do all these things in opposite order, thus calling 
> failed _REG object once again, causing more damage.
Uninstall the space handler will do the above things in opposite order.
First the _REG object will be called(The second argument of _REG is
zero) and then the space handler will be removed. 
    For the EC device. When the _REG object is called, it can be used to
indicate whether the EC operation region is enabled or disabled. 
     If the second argument of _REG object is one, it indicates that the
EC operation region is accessible. And the flag in AML code will be set
to one.
     If the second argument of _REG object is zero, it indicates that
the EC operation region is not accessible. And the flag in AML code will
be set to zero again.
    In such case if the failed _REG object is not called again, the EC
flag in AML code indicates that the EC operation is accessible. But the
EC device is not initialized properly. It will be inconsistent.

    Will you please describe the damage in detail if the failed _REG is
called again?   
> >
> You have address space identifier in this function, so if you want your 
> workaround to be "only for EC", check it. 
Of course it can also be workaround by checking the space id in the
function of acpi_install_address_space_handler. But on most laptops
there is no issue of failed _REG object. And it is not appropriate that
such workaround source code is added in ACPICA for so rare case.
Maybe it is convenient that the workaround is added in EC driver for so
rare case. 
Thanks.
> > And it is also unreasonable that the space handler is removed for the
> > same type operation region of all the devices only because OS fails in
> > _REG object of one device.
> > If you have better method to fix such issue, please write it. 
> Yakui, why should I complete all your jobs?
> 
> Alex.

