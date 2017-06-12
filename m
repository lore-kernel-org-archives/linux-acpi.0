From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 4/4] ACPI: Fix memory mapping leaks in current sysfs dumpable ACPI tables support
Date: Mon, 12 Jun 2017 15:12:01 +0200
Message-ID: <5405056.jcq3epAkXF@aspire.rjw.lan>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com> <f0ecac8fbdfbd7f23db77e523a7a16704134671f.1494309338.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46198 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751944AbdFLNTH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jun 2017 09:19:07 -0400
In-Reply-To: <f0ecac8fbdfbd7f23db77e523a7a16704134671f.1494309338.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, May 09, 2017 01:57:54 PM Lv Zheng wrote:
> This patch adds acpi_put_table() to make all acpi_get_table() clone
> invocations balanced for sysfs ACPI table dump code.
> 
> Since Linux does not use all of the tables, this can help to reduce some
> usless memory mappings.
> 
> While originally, all tables will be remained to be mapped after a
> userspace acpidump execution, potentially causing problem on server
> platforms. With the new APIs, it is possible to release such useless table
> mappings.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/sysfs.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 2bbf722..14425dc 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -346,11 +346,22 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
>  	return len;
>  }
>  
> +static bool acpi_table_has_multiple_instances(char *signature)
> +{
> +	acpi_status status;
> +	struct acpi_table_header *header;
> +
> +	status = acpi_get_table(signature, 2, &header);
> +	if (ACPI_FAILURE(status))
> +		return false;
> +	acpi_put_table(header);
> +	return true;
> +}

To be honest, I'm not convinced this is the best way to do that.

AFAICS there's no guarantee that the second instance would not go away after it
had been found and before this returned.

Thanks,
Rafael

