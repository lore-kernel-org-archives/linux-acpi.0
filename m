From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ACPI / sysfs: Restructure get_status
Date: Thu, 7 Mar 2019 10:21:04 -0800
Message-ID: <CAKwvOdkfW6ipodrfLcGspLP3RaKdxLEvz=odBqh4PcoyVYyzwA@mail.gmail.com>
References: <20190307173802.3448-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307173802.3448-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux@googlegroups.com
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 7, 2019 at 9:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/acpi/sysfs.c:667:13: warning: variable 'result' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
> Clang can't determine that all cases are covered by the two separate if
> statements. We could combine then to look like this:
>
>     int result;
>
>     if (...) {
>         ...
>     } else if {
>         ...
>     } else {
>         result -EINVAL;
>     }
>
>     return result;
>
> However, at that point, we can further simplify this function by only
> using result when absolutely needed and just direct returning the value
> of the function.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/388
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/acpi/sysfs.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 41324f0b1bee..6ed785cadad9 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -651,23 +651,18 @@ static void acpi_global_event_handler(u32 event_type, acpi_handle device,
>  static int get_status(u32 index, acpi_event_status *status,
>                       acpi_handle *handle)
>  {
> -       int result;
> -
> -       if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
> -               return -EINVAL;
> -
>         if (index < num_gpes) {
> -               result = acpi_get_gpe_device(index, handle);
> +               int result = acpi_get_gpe_device(index, handle);

I'm surprised this does not trip -Wdeclaration-after-statement.

>                 if (result) {
>                         ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
>                                         "Invalid GPE 0x%x", index));
>                         return result;
>                 }
> -               result = acpi_get_gpe_status(*handle, index, status);
> +               return acpi_get_gpe_status(*handle, index, status);
>         } else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
> -               result = acpi_get_event_status(index - num_gpes, status);
> +               return acpi_get_event_status(index - num_gpes, status);
>
> -       return result;
> +       return -EINVAL;
>  }


LGTM, thanks Nathan!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
