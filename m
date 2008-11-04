From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH]: ACPI Cleanup :Initialize EC global lock based on the
 return status
Date: Tue, 04 Nov 2008 12:38:51 +0300
Message-ID: <4910182B.6090201@suse.de>
References: <20081031184233.8588.42241.stgit@thinkpad>	 <1225784509.26020.73.camel@yakui_zhao.sh.intel.com>	 <49100241.2030205@suse.de> <1225791444.26020.84.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55133 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752293AbYKDJiy (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 4 Nov 2008 04:38:54 -0500
In-Reply-To: <1225791444.26020.84.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>

Zhao Yakui wrote:
> On Tue, 2008-11-04 at 16:05 +0800, Alexey Starikovskiy wrote:
>> NAK
> Will you please describe the detailed reason?
> 
> In the bug 11917 the regression is related with the following commit:
>     >commit 27663c5855b10af9ec67bc7dfba001426ba21222
>     >Author: Matthew Wilcox <willy@linux.intel.com>
>     >Date:   Fri Oct 10 02:22:59 2008 -0400
>     >ACPI: Change acpi_evaluate_integer to support 64-bit on 32-bit
> kernels
> 
>     But IMO the main reason is that EC driver misuses the Linux-ACPI
> utility interface.(acpi_evaluate_integer).  
Did you _read_ the interface specification?
It explicitly states that if any function call does not succeed it will not
change the data passed to it.
So it is again only your not-so-humble opinion.
>     It will be better to determine whether the return value of ACPI
> object is effective according to the return status. In such case the
> code still can work well even after the Linux-ACPI utility interface is
> changed again.
Code works fine until someone tries to optimize it...

Regards,
Alex.

