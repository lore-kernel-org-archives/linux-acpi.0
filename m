From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: Fix dispatcher timeout mechanism
Date: Tue, 16 Oct 2018 00:44:03 +0200
Message-ID: <CAJZ5v0jDv3ufH+MOXmrygHkBgu4CgT6DZL38xq1ViGiju8VxqQ@mail.gmail.com>
References: <20181015221848.256323-1-bvanassche@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181015221848.256323-1-bvanassche@acm.org>
Sender: stable-owner@vger.kernel.org
To: bvanassche@acm.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, kbuild test robot <fengguang.wu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 16, 2018 at 12:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> This patch avoids that the following warning is reported during hibernation:

Well, what exactly is the problem and why is the patch the right way
to address it?

> WARNING: CPU: 0 PID: 612 at kernel/time/timekeeping.c:751 ktime_get+0x116/0x120
> RIP: 0010:ktime_get+0x116/0x120
> Call Trace:
>  acpi_os_get_timer+0xe/0x30
>  acpi_ds_exec_begin_control_op+0x175/0x1de
>  acpi_ds_exec_begin_op+0x2c7/0x39a
>  acpi_ps_create_op+0x573/0x5e4
>  acpi_ps_parse_loop+0x349/0x1220
>  acpi_ps_parse_aml+0x25b/0x6da
>  acpi_ps_execute_method+0x327/0x41b
>  acpi_ns_evaluate+0x4e9/0x6f5
>  acpi_ut_evaluate_object+0xd9/0x2f2
>  acpi_rs_get_method_data+0x8f/0x114
>  acpi_walk_resources+0x122/0x1b6
>  acpi_pci_link_get_current.isra.2+0x157/0x280
>  acpi_pci_link_set+0x32f/0x4a0
>  irqrouter_resume+0x58/0x80
>  syscore_resume+0x84/0x380
>  hibernation_snapshot+0x20c/0x4f0
>  hibernate+0x22d/0x3a6
>  state_store+0x99/0xa0
>  kobj_attr_store+0x37/0x50
>  sysfs_kf_write+0x87/0xa0
>  kernfs_fop_write+0x1a5/0x240
>  __vfs_write+0xd2/0x410
>  vfs_write+0x101/0x250
>  ksys_write+0xab/0x120
>  __x64_sys_write+0x43/0x50
>  do_syscall_64+0x71/0x220
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Fixes: 164a08cee135 ("ACPICA: Dispatcher: Introduce timeout mechanism for infinite loop detection")
> References: https://lists.01.org/pipermail/lkp/2018-April/008406.html
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  drivers/acpi/acpica/aclocal.h   | 2 +-
>  drivers/acpi/acpica/dscontrol.c | 9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 0f28a38a43ea..7b093bcbaef5 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -588,7 +588,7 @@ struct acpi_control_state {
>         union acpi_parse_object *predicate_op;
>         u8 *aml_predicate_start;        /* Start of if/while predicate */
>         u8 *package_end;        /* End of if/while block */
> -       u64 loop_timeout;       /* While() loop timeout */
> +       unsigned long loop_timeout;     /* While() loop timeout */
>  };
>
>  /*
> diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
> index 0da96268deb5..9dbea4549484 100644
> --- a/drivers/acpi/acpica/dscontrol.c
> +++ b/drivers/acpi/acpica/dscontrol.c
> @@ -84,8 +84,8 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
>                 control_state->control.package_end =
>                     walk_state->parser_state.pkg_end;
>                 control_state->control.opcode = op->common.aml_opcode;
> -               control_state->control.loop_timeout = acpi_os_get_timer() +
> -                   (u64)(acpi_gbl_max_loop_iterations * ACPI_100NSEC_PER_SEC);
> +               control_state->control.loop_timeout = jiffies +
> +                   acpi_gbl_max_loop_iterations * HZ;

jiffies is Linux-specific and so it should not be used in the ACPICA code.

>
>                 /* Push the control state on this walk's control stack */
>
> @@ -179,9 +179,8 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state *walk_state,
>                          * written AML when the hardware does not respond within a while
>                          * loop and the loop does not implement a timeout.
>                          */
> -                       if (ACPI_TIME_AFTER(acpi_os_get_timer(),
> -                                           control_state->control.
> -                                           loop_timeout)) {
> +                       if (time_after(jiffies,
> +                                      control_state->control.loop_timeout)) {
>                                 status = AE_AML_LOOP_TIMEOUT;
>                                 break;
>                         }
> --
