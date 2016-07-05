From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPICA: Namespace: Fix lock order issue for namespace/interpreter
Date: Wed, 6 Jul 2016 01:39:11 +0200
Message-ID: <CAJZ5v0gxYO77DegHFDyqYm48P_v=zR0yPov79nrRkayUSXGWRg@mail.gmail.com>
References: <7ab2c9a68c936a6dadfdbf96dbdcfc924722c93a.1467697822.git.lv.zheng@intel.com>
 <ab9f5511168df30d374e9e6426ae1cb81832f99f.1467697822.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35975 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbcGEXjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2016 19:39:14 -0400
In-Reply-To: <ab9f5511168df30d374e9e6426ae1cb81832f99f.1467697822.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Jul 5, 2016 at 7:53 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> There is a lock order issue in acpi_load_tables(). The namespace lock is held
> before holding the interpreter lock.
> With ACPI_MUTEX_DEBUG enabled in kernel, we can reproduce this during boot:
>   [    0.885699] ACPI Error: Invalid acquire order: Thread 405884224 owns [ACPI_MTX_Namespace], wants [ACPI_MTX_Interpreter] (20160422/utmutex-263)
>   [    0.885881] ACPI Error: Could not acquire AML Interpreter mutex (20160422/exutils-95)
>   [    0.893846] ACPI Error: Mutex [0x0] is not acquired, cannot release (20160422/utmutex-326)
>   [    0.894019] ACPI Error: Could not release AML Interpreter mutex (20160422/exutils-133)
>
> The issue is introduced by the following commit:
>   Commit: 2f38b1b16d9280689e5cfa47a4c50956bf437f0d
>   ACPICA Commit: bfe03ffcde8ed56a7eae38ea0b188aeb12f9c52e
>   Subject: ACPICA: Namespace: Fix a regression that MLC support triggers
>            dead lock in dynamic table loading
> Which fixes a dead lock issue for acpi_ns_load_table() in
> acpi_ex_add_table() but doesn't take care of the lock order in
> acpi_ns_load_table().
>
> Originally (before applying the wrong fix), ACPICA uses the
> namespace/interpreter locks in the following 2 key code paths:
> 1. Table loading (before applying 2f38b1b):
> acpi_ns_load_table
>         L(Namespace)
>                 acpi_ns_parse_table
>                         acpi_ns_one_complete_parse
>         U(Namespace)
> 2. Object evaluation:
> acpi_ns_evaluate
>         L(Interpreter)
>         acpi_ps_execute_method
>                 U(Interpreter)
>                 acpi_ns_load_table
>                         L(Namespace)
>                         U(Namespace)
>                 acpi_ev_initialize_region
>                         L(Namespace)
>                         U(Namespace)
>                 address_space.setup
>                         L(Namespace)
>                         U(Namespace)
>                 address_space.handler
>                         L(Namespace)
>                         U(Namespace)
>                 acpi_os_wait_semaphore
>                 acpi_os_acquire_mutex
>                 acpi_os_sleep
>                 L(Interpreter)
>         U(Interpreter)
> During runtime, while acpi_ns_evaluate is called, lock order is always
> Interpreter -> Namespace.
>
> While the wrong fix holds the lock in the following order:
> 3. Table loading (after applying 2f38b1b):
> acpi_ns_load_table
>         L(Namespace)
>                 acpi_ns_parse_table
>                 L(Interpreter)
>                         acpi_ns_one_complete_parse
>                 U(Interpreter)
>         U(Namespace)
>
> This patch further fixes the lock order issue by moving interpreter lock
> to acpi_ns_load_table() to ensure the lock order correctness:
> 4. Table loading:
> acpi_ns_load_table
>         L(Interpreter)
>         L(Namespace)
>                 acpi_ns_parse_table
>                         acpi_ns_one_complete_parse
>         U(Namespace)
>         U(Interpreter)
>
> However, this fix is just a workaround which is compliant to the current
> design but doesn't fix the current design issues related to the namespace
> lock. For example, we can notice that in acpi_ns_evaluate(), outside of
> acpi_ns_load_table(), the namespace objects may be created by the named
> object creation control methods. And the creations of the method owned
> namespace objects are not locked by the namespace lock. This patch doesn't
> try to fix such kind of existing issues. Lv Zheng.
>
> Fixes: 2f38b1b16d92 ("ACPICA: Namespace: Fix a regression that MLC support triggers dead lock in dynamic table loading")
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

So this one is a fix and it does not really depend on the [1/2] if I'm
not mistaken.

Accordingly, I've queued up the [2/2] as a fix for 4.7 and the [1/2] for 4.8.

Thanks,
Rafael
