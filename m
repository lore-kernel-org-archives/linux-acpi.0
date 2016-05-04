From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 08/15] ACPICA: Dispatcher: Update thread ID for recursive
 method calls
Date: Wed, 04 May 2016 11:10:06 -0400
Message-ID: <572A10CE.20106@redhat.com>
References: <cover.1462331120.git.lv.zheng@intel.com> <b1748e389752c1f7d499770dea3fe5f4950aaecc.1462331121.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <b1748e389752c1f7d499770dea3fe5f4950aaecc.1462331121.git.lv.zheng@intel.com>
Sender: stable-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Mario_Limonciello@dell.com, stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 05/04/2016 01:48 AM, Lv Zheng wrote:
> From: Prarit Bhargava <prarit@redhat.com>
> 
> ACPICA commit 7a3bd2d962f221809f25ddb826c9e551b916eb25
> 
> Set the mutex owner thread ID.
> Original patch from: Prarit Bhargava <prarit@redhat.com>
> 
> Link: https://github.com/acpica/acpica/commit/7a3bd2d9
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

cc'ing Mario @ Dell and stable.

P.

> ---
>  drivers/acpi/acpica/dsmethod.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
> index ddfec05..47c7b52 100644
> --- a/drivers/acpi/acpica/dsmethod.c
> +++ b/drivers/acpi/acpica/dsmethod.c
> @@ -428,6 +428,9 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
>  				obj_desc->method.mutex->mutex.
>  				    original_sync_level =
>  				    obj_desc->method.mutex->mutex.sync_level;
> +
> +				obj_desc->method.mutex->mutex.thread_id =
> +				    acpi_os_get_thread_id();
>  			}
>  		}
>  
> 
