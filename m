From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/3] xen/enlighten: Expose MWAIT and MWAIT_LEAF if
 hypervisor OKs it.
Date: Fri, 24 Feb 2012 18:52:28 -0500
Message-ID: <20120224235228.GA26913@phenom.dumpdata.com>
References: <1330036270-20015-1-git-send-email-konrad.wilk@oracle.com>
 <1330036270-20015-3-git-send-email-konrad.wilk@oracle.com>
 <4F4775410200007800074992@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:42692 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2BXX5E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Feb 2012 18:57:04 -0500
Content-Disposition: inline
In-Reply-To: <4F4775410200007800074992@nat28.tlf.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: ke.yu@intel.com, kevin.tian@intel.com, lenb@kernel.org, xen-devel@lists.xensource.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> > +DEFINE_GUEST_HANDLE(uint32_t);
> 
> Do you really need to introduce (step by step) handles for all those
> uintNN_t types in a way different from Xen's
> (__DEFINE_XEN_GUEST_HANDLE(uint32, uint32_t))?

Oh, no. Good eye - I will change it be uint32.

> 
> Looks good to me otherwise.

Thank you for time!
