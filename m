From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc1-mm1: drivers/acpi/numa.c compile error
Date: Fri, 7 Apr 2006 13:59:37 -0700
Message-ID: <20060407135937.56a84d44.akpm@osdl.org>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060407122757.GI7118@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:62378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964843AbWDGVA2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2006 17:00:28 -0400
In-Reply-To: <20060407122757.GI7118@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yasunori Goto <y-goto@jp.fujitsu.com>

Adrian Bunk <bunk@stusta.de> wrote:
>
> I'm getting the following compile error with CONFIG_ACPI_NUMA=y:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/acpi/numa.o
> drivers/acpi/numa.c: In function 'acpi_numa_init':
> drivers/acpi/numa.c:231: error: 'NR_NODE_MEMBLKS' undeclared (first use in this function)

I'm not quite sure how we managed that, but I guess
unify-pxm_to_node-and-node_to_pxm.patch triggered it?
