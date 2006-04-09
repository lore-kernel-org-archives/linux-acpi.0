From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.17-rc1-mm1: drivers/acpi/numa.c compile error
Date: Sun, 9 Apr 2006 17:44:46 +0200
Message-ID: <20060409154446.GE8454@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060407122757.GI7118@stusta.de> <20060407135937.56a84d44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43013 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750797AbWDIPor (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Apr 2006 11:44:47 -0400
Content-Disposition: inline
In-Reply-To: <20060407135937.56a84d44.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yasunori Goto <y-goto@jp.fujitsu.com>, tony.luck@intel.com, Andi Kleen <ak@muc.de>, Dave Hansen <haveblue@us.ibm.com>

On Fri, Apr 07, 2006 at 01:59:37PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > I'm getting the following compile error with CONFIG_ACPI_NUMA=y:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      drivers/acpi/numa.o
> > drivers/acpi/numa.c: In function 'acpi_numa_init':
> > drivers/acpi/numa.c:231: error: 'NR_NODE_MEMBLKS' undeclared (first use in this function)
> 
> I'm not quite sure how we managed that, but I guess
> unify-pxm_to_node-and-node_to_pxm.patch triggered it?

Yes, obviously (I got this error on i386):

 config ACPI_NUMA
        bool "NUMA support"
        depends on NUMA
-       depends on (IA64 || X86_64)
+       depends on (X86_32 || IA64 || X86_64)
        default y if IA64_GENERIC || IA64_SGI_SN2


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

