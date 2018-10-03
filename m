From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/sbshc: Fix rare oops when removing modules.
Date: Wed, 03 Oct 2018 11:26:27 +0200
Message-ID: <6138243.jYEBpdSlFa@aspire.rjw.lan>
References: <20181001025313.GA9144@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001025313.GA9144@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?ISO-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, October 1, 2018 4:53:13 AM CEST Ronald Tschalär wrote:
> There was a small race when removing the sbshc module where
> smbus_alarm() had queued acpi_smbus_callback() for deferred execution
> but it hadn't been run yet, so that when it did run hc had been freed
> and the module unloaded, resulting in an invalid paging request.
> 
> A similar race existed when removing the sbs module with regards to
> acpi_sbs_callback() (which is called from acpi_smbus_callback()).
> 
> We therefore need to ensure no callbacks are pending or executing before
> the cleanups are done and the modules are removed.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/acpi/osl.c   | 1 +
>  drivers/acpi/sbshc.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 8df9abfa947b..9d139727f164 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1129,6 +1129,7 @@ void acpi_os_wait_events_complete(void)
>  	flush_workqueue(kacpid_wq);
>  	flush_workqueue(kacpi_notify_wq);
>  }
> +EXPORT_SYMBOL(acpi_os_wait_events_complete);
>  
>  struct acpi_hp_work {
>  	struct work_struct work;
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index 7a3431018e0a..5008ead4609a 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -196,6 +196,7 @@ int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc)
>  	hc->callback = NULL;
>  	hc->context = NULL;
>  	mutex_unlock(&hc->lock);
> +	acpi_os_wait_events_complete();
>  	return 0;
>  }
>  
> @@ -292,6 +293,7 @@ static int acpi_smbus_hc_remove(struct acpi_device *device)
>  
>  	hc = acpi_driver_data(device);
>  	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
> +	acpi_os_wait_events_complete();
>  	kfree(hc);
>  	device->driver_data = NULL;
>  	return 0;
> 

Applied, thanks!
