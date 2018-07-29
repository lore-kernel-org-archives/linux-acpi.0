From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: AML Parser: ignore control method status in
 module-level code
Date: Sun, 29 Jul 2018 12:25:26 +0200
Message-ID: <CAJZ5v0jQuBSFDZXtrWmmsKHexuk-0X5pHMkbQAJ3sqPJGH7EQQ@mail.gmail.com>
References: <20180728210519.20195-1-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180728210519.20195-1-erik.schmauss@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, oleksandr@natalenko.name, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jul 28, 2018 at 11:05 PM, Erik Schmauss <erik.schmauss@intel.com> wrote:
> Previous change in the AML parser code blindly set all non-successful
> dispatcher statuses to AE_OK. This approach is incorrect because
> successful control method invocations from module-level return
> AE_CTRL_TRANSFER. Overwriting AE_OK to this status causes the AML
> parser to think that there was no return value from the control
> method invocation.
>
> fixes: 73c2a01c52b6 (ACPICA: AML Parser: ignore dispatcher error status during table load)
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> ---
>  drivers/acpi/acpica/psloop.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
> index ee840be150b5..44f35ab3347d 100644
> --- a/drivers/acpi/acpica/psloop.c
> +++ b/drivers/acpi/acpica/psloop.c
> @@ -709,15 +709,20 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
>                         } else
>                             if ((walk_state->
>                                  parse_flags & ACPI_PARSE_MODULE_LEVEL)
> +                               && status != AE_CTRL_TRANSFER
>                                 && ACPI_FAILURE(status)) {
>                                 /*
> -                                * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
> -                                * executing it as a control method. However, if we encounter
> -                                * an error while loading the table, we need to keep trying to
> -                                * load the table rather than aborting the table load. Set the
> -                                * status to AE_OK to proceed with the table load. If we get a
> -                                * failure at this point, it means that the dispatcher got an
> -                                * error while processing Op (most likely an AML operand error.
> +                                * ACPI_PARSE_MODULE_LEVEL flag means that we are currently
> +                                * loading a table by executing it as a control method.
> +                                * However, if we encounter an error while loading the table,
> +                                * we need to keep trying to load the table rather than
> +                                * aborting the table load (setting the status to AE_OK
> +                                * continues the table load). If we get a failure at this
> +                                * point, it means that the dispatcher got an error while
> +                                * processing Op (most likely an AML operand error) or a
> +                                * control method was called from module level and the
> +                                * dispatcher returned AE_CTRL_TRANSFER. In the latter case,
> +                                * leave the status alone, there's nothing wrong with it.
>                                  */
>                                 status = AE_OK;
>                         }
> --

Applied, thanks!
