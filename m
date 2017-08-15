From: gengdongjiu <gengdj.1984@gmail.com>
Subject: Re: [PATCH v2] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Tue, 15 Aug 2017 22:16:20 +0800
Message-ID: <CAMj-D2CXOurgPGGGbC7qHX-uWZeMYwh9EfLOS3p3hm+=BvPq7w@mail.gmail.com>
References: <1502795713-20945-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36378 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdHOOQV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Aug 2017 10:16:21 -0400
In-Reply-To: <1502795713-20945-1-git-send-email-gengdongjiu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tbaicar@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, james.morse@arm.com, bp@suse.de, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com

Loop more people to review the patch.


2017-08-15 19:15 GMT+08:00, Dongjiu Geng <gengdongjiu@huawei.com>:
> The revision 0x300 generic error data entry is different
> from the old version, but currently iterating through the
> GHES estatus blocks does not take into account this difference.
> This will lead to failure to get the right data entry if GHES
> has revision 0x300 error data entry.
>
> Update the GHES estatus iteration to properly increment using
> acpi_hest_get_next, and correct the iteration termination condition
> because the status block data length only includes error data length.
> Clear the CPER estatus printing iteration logic to use same macro.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> CC: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/apei-internal.h | 5 -----
>  drivers/firmware/efi/cper.c       | 7 +------
>  include/acpi/ghes.h               | 5 +++++
>  3 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-internal.h
> b/drivers/acpi/apei/apei-internal.h
> index 6e9f14c0a71b..cb4126051f62 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -120,11 +120,6 @@ int apei_exec_collect_resources(struct
> apei_exec_context *ctx,
>  struct dentry;
>  struct dentry *apei_get_debugfs_dir(void);
>
> -#define apei_estatus_for_each_section(estatus, section)			\
> -	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
> -	     (void *)section - (void *)estatus < estatus->data_length;	\
> -	     section = (void *)(section+1) + section->error_data_length)
> -
>  static inline u32 cper_estatus_len(struct acpi_hest_generic_status
> *estatus)
>  {
>  	if (estatus->raw_data_length)
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 48a8f69da42a..dff454321160 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -606,7 +606,6 @@ void cper_estatus_print(const char *pfx,
>  			const struct acpi_hest_generic_status *estatus)
>  {
>  	struct acpi_hest_generic_data *gdata;
> -	unsigned int data_len;
>  	int sec_no = 0;
>  	char newpfx[64];
>  	__u16 severity;
> @@ -617,14 +616,10 @@ void cper_estatus_print(const char *pfx,
>  		       "It has been corrected by h/w "
>  		       "and requires no further action");
>  	printk("%s""event severity: %s\n", pfx, cper_severity_str(severity));
> -	data_len = estatus->data_length;
> -	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
>  	snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
>
> -	while (data_len >= acpi_hest_get_size(gdata)) {
> +	apei_estatus_for_each_section(estatus, gdata) {
>  		cper_estatus_print_section(newpfx, gdata, sec_no);
> -		data_len -= acpi_hest_get_record_size(gdata);
> -		gdata = acpi_hest_get_next(gdata);
>  		sec_no++;
>  	}
>  }
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 9f26e01186ae..9061c5c743b3 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -113,6 +113,11 @@ static inline void *acpi_hest_get_next(struct
> acpi_hest_generic_data *gdata)
>  	return (void *)(gdata) + acpi_hest_get_record_size(gdata);
>  }
>
> +#define apei_estatus_for_each_section(estatus, section)			\
> +	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
> +	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
> +	     section = acpi_hest_get_next(section))
> +
>  int ghes_notify_sea(void);
>
>  #endif /* GHES_H */
> --
> 2.14.0
>
>
