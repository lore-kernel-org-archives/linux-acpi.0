From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/2] [Patch-next -v2] ACPI, APEI Fix the return
 value(==NULL) of acpi_pre_map().
Date: Wed, 18 Aug 2010 12:16:58 +0800
Message-ID: <1282105018.2744.1538.camel@yhuang-dev>
References: <4C6B1F63.9050703@np.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28195 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab0HRERC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Aug 2010 00:17:02 -0400
In-Reply-To: <4C6B1F63.9050703@np.css.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andi Kleen <andi@firstfloor.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, LKLM <linux-kernel@vger.kernel.org>, ACPI <linux-acpi@vger.kernel.org>

On Wed, 2010-08-18 at 07:46 +0800, Jin Dongming wrote:
> acpi_pre_map() is used for remapping the physical address of I/O, so
> it should be return NULL or remapped virtual address. The problem is
> that when (paddr - pg_off) equals 0, no matter whether I/O remapping is
> successful or not, the function returns NULL.
> 
> In acpi_pre_map(), after the physical address is remapped sucessfully,
> it will check whether the physical address has been added into acpi_iomaps
> list again.
>    - If the physical address has beed added into acpi_iomaps, the virtual
>      address will be saved in vaddr.
>    - Otherwise, NULL be saved in vaddr.
> 
> So if the physical address is the first time to be remapped, vaddr will be
> NULL always.
> 
> In many cases, (paddr - pg_off) may not equal 0. So the function could work
> well. In our machine, (paddr - pg_off) equals 0, so the return value of
> acpi_pre_map() is NULL.
> 
> This patch fixed it and I confirmed it on x86_64 next-tree.
> 
> Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Acked-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying


