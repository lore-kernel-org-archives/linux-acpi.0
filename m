From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.17-rc6] Fix the memory leak in acpi_evaluate_integer()
Date: Wed, 7 Jun 2006 14:17:50 +0200
Message-ID: <6bffcb0e0606070517h37df2e95y3da73d59b2b65066@mail.gmail.com>
References: <20060607113354.9720.85323.stgit@localhost.localdomain>
	 <6bffcb0e0606070515j797d6cb2o66d055947550d48b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:28208 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932231AbWFGMRv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jun 2006 08:17:51 -0400
Received: by wr-out-0506.google.com with SMTP id i11so414266wra
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jun 2006 05:17:51 -0700 (PDT)
In-Reply-To: <6bffcb0e0606070515j797d6cb2o66d055947550d48b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@gmail.com
Cc: linux-acpi@vger.kernel.org

On 07/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Catalin,
>
> On 07/06/06, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > From: Catalin Marinas <catalin.marinas@arm.com>
> >
> > A leak can happen because of the early returns from this function
> > (discovered by kmemleak).
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
>
> all
> orphan pointer 0xf7e97654 (size 40):
>   c0151044: <kmem_cache_alloc>
>   c01e8656: <acpi_os_acquire_object>
>   c01fe087: <acpi_ut_allocate_object_desc_dbg>
>   c01fdf1b: <acpi_ut_create_internal_object_dbg>
>   c01ec2a0: <acpi_ev_execute_reg_method>
>   c01ec898: <acpi_ev_reg_run>
>   c01f7453: <acpi_ns_walk_namespace>
>   c01ec859: <acpi_ev_execute_reg_methods>
>
> are gone. But now I get a lot of
>
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

Ups, sorry for noise. I forgot about CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH=16

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
