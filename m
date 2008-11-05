From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI Cleanup :Initialize EC global lock based on the
	return status
Date: Wed, 05 Nov 2008 09:05:05 +0800
Message-ID: <1225847105.26020.100.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
	 <1225784509.26020.73.camel@yakui_zhao.sh.intel.com>
	 <49100241.2030205@suse.de>
	 <1225791444.26020.84.camel@yakui_zhao.sh.intel.com>
	 <4910182B.6090201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56687 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbYKEA6F (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 4 Nov 2008 19:58:05 -0500
In-Reply-To: <4910182B.6090201@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>

On Tue, 2008-11-04 at 17:38 +0800, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > On Tue, 2008-11-04 at 16:05 +0800, Alexey Starikovskiy wrote:
> >> NAK
> > Will you please describe the detailed reason?
> > 
> > In the bug 11917 the regression is related with the following commit:
> >     >commit 27663c5855b10af9ec67bc7dfba001426ba21222
> >     >Author: Matthew Wilcox <willy@linux.intel.com>
> >     >Date:   Fri Oct 10 02:22:59 2008 -0400
> >     >ACPI: Change acpi_evaluate_integer to support 64-bit on 32-bit
> > kernels
> > 
> >     But IMO the main reason is that EC driver misuses the Linux-ACPI
> > utility interface.(acpi_evaluate_integer).  
> Did you _read_ the interface specification?
> It explicitly states that if any function call does not succeed it will not
> change the data passed to it.
> So it is again only your not-so-humble opinion.
What do you mean "not-so-humble"?      
> >     It will be better to determine whether the return value of ACPI
> > object is effective according to the return status. In such case the
> > code still can work well even after the Linux-ACPI utility interface is
> > changed again.
> Code works fine until someone tries to optimize it...
     I agree that your patch can work well. But it depends on the
internal realization of Linux-ACPI utility interface. If Linux-ACPI
utility interface is changed, maybe it will be broken. If so, why not to
determine whether the return value is effective based on the return
status of Linux-ACPI utility?
      
> 
> Regards,
> Alex.
> 

