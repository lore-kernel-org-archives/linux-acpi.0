From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH] ACPI / APEI: Convert timers to use timer_setup()
Date: Tue, 17 Oct 2017 09:48:32 -0400
Message-ID: <056ca6a5-6612-0794-c6a0-fdebb68e9937@codeaurora.org>
References: <20171016232135.GA100431@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016232135.GA100431@beast>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Shiju Jose <shiju.jose@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 10/16/2017 7:21 PM, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Verified that the polled error sources still work with this timer setup.

Thanks,
Tyler
> ---
>   drivers/acpi/apei/ghes.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3c3a37b8503b..ebaa51ba8a22 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -774,9 +774,9 @@ static void ghes_add_timer(struct ghes *ghes)
>   	add_timer(&ghes->timer);
>   }
>   
> -static void ghes_poll_func(unsigned long data)
> +static void ghes_poll_func(struct timer_list *t)
>   {
> -	struct ghes *ghes = (void *)data;
> +	struct ghes *ghes = from_timer(ghes, t, timer);
>   
>   	ghes_proc(ghes);
>   	if (!(ghes->flags & GHES_EXITING))
> @@ -1147,8 +1147,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
>   
>   	switch (generic->notify.type) {
>   	case ACPI_HEST_NOTIFY_POLLED:
> -		setup_deferrable_timer(&ghes->timer, ghes_poll_func,
> -				       (unsigned long)ghes);
> +		timer_setup(&ghes->timer, ghes_poll_func, TIMER_DEFERRABLE);
>   		ghes_add_timer(ghes);
>   		break;
>   	case ACPI_HEST_NOTIFY_EXTERNAL:
