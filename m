From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: Fix unused function warning when CONFIG_PM_SLEEP=n
Date: Tue, 11 Oct 2016 23:54:32 +0200
Message-ID: <15070756.yRzbHa5m24@vostro.rjw.lan>
References: <1475688796-17936-1-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475688796-17936-1-git-send-email-ebiggers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: lv.zheng@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, October 05, 2016 10:33:16 AM Eric Biggers wrote:
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/acpi/ec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 6805310..48e19d0 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -526,6 +526,7 @@ static void acpi_ec_enable_event(struct acpi_ec *ec)
>  		acpi_ec_clear(ec);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static bool acpi_ec_query_flushed(struct acpi_ec *ec)
>  {
>  	bool flushed;
> @@ -557,6 +558,7 @@ static void acpi_ec_disable_event(struct acpi_ec *ec)
>  	spin_unlock_irqrestore(&ec->lock, flags);
>  	__acpi_ec_flush_event(ec);
>  }
> +#endif /* CONFIG_PM_SLEEP */
>  
>  static bool acpi_ec_guard_event(struct acpi_ec *ec)
>  {
> 

Applied.

Thanks,
Rafael
