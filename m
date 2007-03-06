From: Tommi Kyntola <tommi.kyntola@ray.fi>
Subject: Re: acpi-fan-after-suspend-to-mem-fix.patch
Date: Tue, 06 Mar 2007 08:58:27 +0200
Message-ID: <45ED1113.2070406@ray.fi>
References: <20070305170418.866b3921.akpm@linux-foundation.org>
Reply-To: tommi.kyntola@ray.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from harmaja.edelkey.net ([213.138.147.141]:39866 "EHLO
	harmaja.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965831AbXCFHKb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2007 02:10:31 -0500
In-Reply-To: <20070305170418.866b3921.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>


Negative,
Konstantin explained the reasons why it's intentionally been set to _D0.

"Actually, I've meant the situation where the system could go down on thermal
(possibly h/w) shutdown during suspend. If the fans stay on during suspend,
where thermal control is possibly not working already, thermal shutdown is less
likely to occur."
(bugzilla #7122)

Also it's possible that the thing has been fixed by other means in 2.6.21-rc2
already, it's just that since the c5a7156959e89b32260ad6072bbf5077bcdfbeee
(by Bob Moore Feb 2nd) commit my laptop hasn't woken up from suspend.

Just finished bisecting that, but it seems that there are future
changes that also have impact. And as I'm writing this I'm still in the
middle of reverting that and checking how the fan works. I'll report
as soon as I'm done with that.

But to summarize, it seems like the fix I represented there is not the
way to go.

cheers,
Tommi Kyntola

Andrew Morton wrote:
> Should I merge this into mainline??
> 
> 
> From: Tommi Kyntola <tommi.kyntola@ray.fi>
> 
> acpi_fan_suspend should probably set state to ACPI_D3, rather than ACPI_D0.
>  With this change the fan works after S3 suspend atleast on HP nw8000
> laptop, for which the suspended fan has been broken since sword-and-stone.
> 
> Why this was ACPI_D0 beats me, but it's been that way since the
> _suspend/_resume functios got added in the commit
> 0feabb01d93e5801d1127416a66cfc3963280bca (2.6.18-rc1, I think).
> 
> The fan hasn't worked on my HP nw8000 laptop after an S3 suspend ever, but
> fixing that to ACPI_D3 there finally makes it work as expected.
> 
> If there was some hidden reason why that was set to ACPI_D0, then perhaps a
> config option for some ICH4 or HP laptops is called for.
> 
> Signed-off-by: Tommi Kyntola <tommi.kyntola@ray.fi>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/fan.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/fan.c~acpi-fan-after-suspend-to-mem-fix drivers/acpi/fan.c
> --- a/drivers/acpi/fan.c~acpi-fan-after-suspend-to-mem-fix
> +++ a/drivers/acpi/fan.c
> @@ -241,7 +241,7 @@ static int acpi_fan_suspend(struct acpi_
>  	if (!device)
>  		return -EINVAL;
>  
> -	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
> +	acpi_bus_set_power(device->handle, ACPI_STATE_D3);
>  
>  	return AE_OK;
>  }
> _
> 
