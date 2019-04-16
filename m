From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv2 2/2] hmat: Register attributes for memory hot add
Date: Tue, 16 Apr 2019 09:01:30 -0600
Message-ID: <20190416150130.GA20546@localhost.localdomain>
References: <20190415151654.15913-1-keith.busch@intel.com>
 <20190415151654.15913-3-keith.busch@intel.com>
 <9f130b73-e5ae-0529-69a1-28bd2ca29581@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9f130b73-e5ae-0529-69a1-28bd2ca29581@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Brice Goglin <Brice.Goglin@inria.fr>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 16, 2019 at 04:55:21PM +0200, Brice Goglin wrote:
> Hello Keith
> 
> Several issues:
> 
> * We always get a memory_side_cache, even if nothing was found in ACPI.
>   You should at least ignore the cache if size==0?
> 
> * Your code seems to only work with a single level of cache, since
>   there's a single cache_attrs entry in each target structure.
> 
> * I was getting a section mismatch warning and a crash on PMEM node
>   hotplug until I applied the patch below.
> 
> WARNING: vmlinux.o(.text+0x47d3f7): Section mismatch in reference from the function hmat_callback() to the function .init.text:hmat_register_target()
> The function hmat_callback() references
> the function __init hmat_register_target().
> This is often because hmat_callback lacks a __init 
> annotation or the annotation of hmat_register_target is wrong.
> 
> Thanks
> 
> Brice

Oh, thanks for the notice. I'll add multi-level and no-caches into my
test, as I had it fixed to one. Will need to respin this series.
