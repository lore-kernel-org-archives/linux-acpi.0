From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [2.6.6] Oops when unloading processor module
Date: Sat, 05 Jun 2004 11:34:50 +1000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <E1BWQ5C-0006cc-00@gondolin.me.apana.org.au>
References: <20040604232817.GA11305@wiggy.net>
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S265969AbUFEBgU@vger.kernel.org>
In-Reply-To: <20040604232817.GA11305@wiggy.net>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Wichert Akkerman <wichert@wiggy.net> wrote:
> Since the IWP2100 driver has some issues with the acpi processor
> module entering C3 I tried to unload the processor module which
> resulted in the oops below.
> 
> 
> Badness in remove_proc_entry at fs/proc/generic.c:685
> Call Trace:
> [<c017d66a>] remove_proc_entry+0x10a/0x150
> [<e08e5f0e>] acpi_thermal_remove_fs+0x1d/0x2d [thermal]
> [<e08e61a7>] acpi_thermal_remove+0x77/0x80 [thermal]
> [<c01eab6d>] acpi_driver_detach+0x39/0x7c
> [<c01eac21>] acpi_bus_unregister_driver+0x12/0x51
> [<e08e61ba>] acpi_thermal_exit+0xa/0x1e [thermal]
> [<c012bf10>] sys_delete_module+0x150/0x1a0
> [<c0142faa>] do_munmap+0x14a/0x190
> [<c010411b>] syscall_call+0x7/0xb

This has been fixed in 2.6.7-rc2 already.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
