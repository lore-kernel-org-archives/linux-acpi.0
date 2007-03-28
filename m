From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
 kernel paging request at virtual address 6b6b6ceb -- EIP is at
 module_put+0x7/0x1f
Date: Tue, 27 Mar 2007 22:09:04 -0700
Message-ID: <20070327220904.4ba4f920.akpm@linux-foundation.org>
References: <20070322095232.f992794a.akpm@linux-foundation.org>
	<1174615467.23591.3.camel@sli10-conroe.sh.intel.com>
	<20070323051613.GA9560@kroah.com>
	<1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
	<20070328041958.GA7669@kroah.com>
	<20070327212719.68c7729f.akpm@linux-foundation.org>
	<20070328045124.GA8156@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:53709 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbXC1FJH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 01:09:07 -0400
In-Reply-To: <20070328045124.GA8156@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Shaohua Li <shaohua.li@intel.com>, "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Tue, 27 Mar 2007 21:51:24 -0700 Greg KH <greg@kroah.com> wrote:

> So, where do I need to put this information so that people stop trying
> to be smarter than the kernel...

Documentation/driver-model/driver.txt?

And a pointer to a sample properly-written driver would help.
