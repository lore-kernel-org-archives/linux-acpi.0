From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc6] Fix the memory leak in acpi_evaluate_integer()
Date: Wed, 7 Jun 2006 13:37:22 +0100
Message-ID: <b0943d9e0606070537s3b1b0283v1706c63f6c318a40@mail.gmail.com>
References: <20060607113354.9720.85323.stgit@localhost.localdomain>
	 <6bffcb0e0606070515j797d6cb2o66d055947550d48b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:34068 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750708AbWFGMhX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jun 2006 08:37:23 -0400
Received: by nz-out-0102.google.com with SMTP id s18so164673nze
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jun 2006 05:37:22 -0700 (PDT)
In-Reply-To: <6bffcb0e0606070515j797d6cb2o66d055947550d48b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 07/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> orphan pointer 0xf7ea1654 (size 40):
>   c015208c: <kmem_cache_alloc>
>   c01eb6c2: <acpi_os_acquire_object>
>   c02010f7: <acpi_ut_allocate_object_desc_dbg>
>   c0200f8b: <acpi_ut_create_internal_object_dbg>
>   c01ef310: <acpi_ev_execute_reg_method>
>   c01ef908: <acpi_ev_reg_run>
>   c01fa4c3: <acpi_ns_walk_namespace>
>   c01ef8c9: <acpi_ev_execute_reg_methods>
>   c01ef293: <acpi_ev_initialize_op_regions>
>   c02000d4: <acpi_initialize_objects>
>   c03a0a37: <acpi_bus_init>
>   c03a0ada: <acpi_init>
>   c038e871: <do_initcalls>
>   c038e91e: <do_basic_setup>
>   c0100367: <init>

I didn't manage to track this problem completely. It looks to me like
a real leak - two objects are allocated in acpi_ev_execute_reg_method
but, when returning from acpi_ns_evaluate_by_handle(), params[1] has
the reference_count = 2 (params[0] has this set to 1) and therefore
not released via acpi_ut_remove_reference().

-- 
Catalin
