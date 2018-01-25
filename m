From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 2/2] xen: add acpi_arch_get_root_pointer() for pvh
 guests
Date: Thu, 25 Jan 2018 10:46:05 -0500
Message-ID: <b412ae20-76bf-854c-e69c-c74e876191e0@oracle.com>
References: <20180125143639.9969-1-jgross@suse.com>
 <20180125143639.9969-3-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:60738 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeAYPqS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jan 2018 10:46:18 -0500
In-Reply-To: <20180125143639.9969-3-jgross@suse.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: lenb@kernel.org, rafael.j.wysocki@intel.com, mingo@redhat.com, stable@vger.kernel.org



On 01/25/2018 09:36 AM, Juergen Gross wrote:
> Add acpi_arch_get_root_pointer() for Xen PVH guests to communicate
> the address of the RSDP table given to the kernel via Xen start info.
> 
> This makes the kernel boot again in PVH mode after on recent Xen the
> RSDP was moved to higher addresses. So up to that change it was pure
> luck that the legacy method to locate the RSDP was working when
> running as PVH mode.
> 
> Cc: <stable@vger.kernel.org> # 4.11
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
