From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 10/13] Remove acpi_os_create_lock(),
 acpi_os_delete_lock()
Date: Fri, 2 Jun 2006 12:24:09 -0700
Message-ID: <20060602122409.a75f3d79.akpm@osdl.org>
References: <B28E9812BAF6E2498B7EC5C427F293A4634DE2@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:19848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751456AbWFBTYN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2006 15:24:13 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4634DE2@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, adobriyan@gmail.com

On Fri, 2 Jun 2006 12:09:14 -0700
"Moore, Robert" <robert.moore@intel.com> wrote:

> This will not always be the case, in fact we are about to expand the use
> of the spinlock interfaces.

Sure, but this function is absolutely crackers.  All it does is to
dynamically allocate and initialise a spinlock.  But the storage for the
pointer-to-spinlock is the same as, or larger than the spinlock itself.

This thing has to die - please kill it before it spreads.  The spinlock
should be aggregated by value into the containing structure.  Not by
reference.

