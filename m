From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 46/73] ACPICA: Fixed a couple memory leaks associated with "implicit return" objects when the AML Interpreter slack mode is enabled
Date: Tue, 22 Apr 2008 14:24:49 -0400
Message-ID: <200804221424.49706.lenb@kernel.org>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <eebfce1bc757911d1d03a687356ce43e03078253.1207973800.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53603 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbYDVSZJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2008 14:25:09 -0400
In-Reply-To: <eebfce1bc757911d1d03a687356ce43e03078253.1207973800.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Bob reports that this one breaks implicit return,
so I'm dropping it.

thanks,
-Len

On Saturday 12 April 2008, Len Brown wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> Lin Ming BZ 349
> 
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/dispatcher/dsmethod.c |    3 +++
>  drivers/acpi/dispatcher/dsmthdat.c |    2 ++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
> index 7a99740..9e24641 100644
> --- a/drivers/acpi/dispatcher/dsmethod.c
> +++ b/drivers/acpi/dispatcher/dsmethod.c
> @@ -103,6 +103,9 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
>  						    NULL);
>  		acpi_ex_enter_interpreter();
>  	}
> +
> +	acpi_ds_clear_implicit_return(walk_state);
> +
>  #ifdef ACPI_DISASSEMBLER
>  	if (ACPI_FAILURE(status)) {
>  
> diff --git a/drivers/acpi/dispatcher/dsmthdat.c b/drivers/acpi/dispatcher/dsmthdat.c
> index ba4626e..38510d1 100644
> --- a/drivers/acpi/dispatcher/dsmthdat.c
> +++ b/drivers/acpi/dispatcher/dsmthdat.c
> @@ -172,6 +172,8 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state)
>  		}
>  	}
>  
> +	acpi_ds_clear_implicit_return(walk_state);
> +
>  	return_VOID;
>  }
>  


