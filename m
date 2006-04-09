From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.17-rc1-mm1: drivers/acpi/numa.c compile error
Date: Sun, 9 Apr 2006 08:57:08 -0700
Message-ID: <20060409085708.6ed19e81.rdunlap@xenotime.net>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060407122757.GI7118@stusta.de>
	<20060407135937.56a84d44.akpm@osdl.org>
	<20060409154446.GE8454@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:16779 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750781AbWDIPyu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Apr 2006 11:54:50 -0400
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sun, 9 Apr 2006 08:54:48 -0700
In-Reply-To: <20060409154446.GE8454@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, y-goto@jp.fujitsu.com, tony.luck@intel.com, ak@muc.de, haveblue@us.ibm.com

On Sun, 9 Apr 2006 17:44:46 +0200 Adrian Bunk wrote:

> On Fri, Apr 07, 2006 at 01:59:37PM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > I'm getting the following compile error with CONFIG_ACPI_NUMA=y:
> > > 
> > > <--  snip  -->
> > > 
> > > ...
> > >   CC      drivers/acpi/numa.o
> > > drivers/acpi/numa.c: In function 'acpi_numa_init':
> > > drivers/acpi/numa.c:231: error: 'NR_NODE_MEMBLKS' undeclared (first use in this function)
> > 
> > I'm not quite sure how we managed that, but I guess
> > unify-pxm_to_node-and-node_to_pxm.patch triggered it?
> 
> Yes, obviously (I got this error on i386):
> 
>  config ACPI_NUMA
>         bool "NUMA support"
>         depends on NUMA
> -       depends on (IA64 || X86_64)
> +       depends on (X86_32 || IA64 || X86_64)
>         default y if IA64_GENERIC || IA64_SGI_SN2

The new/fixed line should just be
	depends on X86 || IA64
since X86_32 and X86_64 both set X86.

---
~Randy
