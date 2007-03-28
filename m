From: Greg KH <greg@kroah.com>
Subject: Re: Fw: Re: 2.6.21-rc4-mm1 + 4 hotfixes -- BUG: unable to handle
	kernel paging request at virtual address 6b6b6ceb -- EIP is at
	module_put+0x7/0x1f
Date: Tue, 27 Mar 2007 21:19:58 -0700
Message-ID: <20070328041958.GA7669@kroah.com>
References: <20070322095232.f992794a.akpm@linux-foundation.org> <1174615467.23591.3.camel@sli10-conroe.sh.intel.com> <20070323051613.GA9560@kroah.com> <1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:49137 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXC1E42 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Mar 2007 00:56:28 -0400
Content-Disposition: inline
In-Reply-To: <1175053953.10369.2.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

On Wed, Mar 28, 2007 at 11:52:33AM +0800, Shaohua Li wrote:
> +static void cpuidle_state_sysfs_release(struct kobject *kobj)
> +{
> +	/* Nothing required to do here, just workaround kobject warning*/
> +}

NO!!!

Do people think that I add warnings to the kernel so that people can
just work around them by passing empty functions to the driver core?

Sometimes I wonder why I even try...

Please fix this code, it is wrong.

greg k-h
