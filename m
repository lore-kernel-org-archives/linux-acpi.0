From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 00/11] Hot-plug and Online/Offline framework
Date: Wed, 12 Dec 2012 15:56:57 -0800
Message-ID: <20121212235657.GD22764@kroah.com>
References: <1355354243-18657-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1355354243-18657-1-git-send-email-toshi.kani@hp.com>
Sender: owner-linux-mm@kvack.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: rjw@sisk.pl, lenb@kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, jiang.liu@huawei.com, wency@cn.fujitsu.com, guohanjun@huawei.com, yinghai@kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 12, 2012 at 04:17:12PM -0700, Toshi Kani wrote:
> This patchset is an initial prototype of proposed hot-plug framework
> for design review.  The hot-plug framework is designed to provide 
> the common framework for hot-plugging and online/offline operations
> of system devices, such as CPU, Memory and Node.  While this patchset
> only supports ACPI-based hot-plug operations, the framework itself is
> designed to be platform-neural and can support other FW architectures
> as necessary.
> 
> The patchset has not been fully tested yet, esp. for memory hot-plug.
> Any help for testing will be very appreciated since my test setup
> is limited.
> 
> The patchset is based on the linux-next branch of linux-pm.git tree.
> 
> Overview of the Framework
> =========================

<snip>

Why all the new framework, doesn't the existing bus infrastructure
provide everything you need here?  Shouldn't you just be putting your
cpus and memory sticks on a bus and handle stuff that way?  What makes
these types of devices so unique from all other devices that Linux has
been handling in a dynamic manner (i.e. hotplugging them) for many many
years?

Why are you reinventing the wheel?

confused,

greg k-h

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
