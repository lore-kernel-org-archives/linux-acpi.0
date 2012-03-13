From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V2 1/4] ACPI: Fix up _PLD methods
Date: Tue, 13 Mar 2012 15:07:16 +0400
Message-ID: <4F5F2A64.8030403@mvista.com>
References: <1331588747-1247-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33693 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab2CMLIm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Mar 2012 07:08:42 -0400
Received: by bkcik5 with SMTP id ik5so283222bkc.19
        for <linux-acpi@vger.kernel.org>; Tue, 13 Mar 2012 04:08:41 -0700 (PDT)
In-Reply-To: <1331588747-1247-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org

Hello.

On 13-03-2012 1:45, Matthew Garrett wrote:

> _PLD is defined as returning a package of buffers, but many implementations
> simply return a buffer. Fix this up.

> (Original patch by Bob Moore<robert.moore@intel.com>)

> Signed-off-by: Matthew Garrett<mjg@redhat.com>
> ---
>   drivers/acpi/acpica/nsrepair.c |   15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

> diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
> index 9c35d20..6217cfd 100644
> --- a/drivers/acpi/acpica/nsrepair.c
> +++ b/drivers/acpi/acpica/nsrepair.c
> @@ -151,9 +151,18 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
>   		}
>   	}
>   	if (expected_btypes&  ACPI_RTYPE_PACKAGE) {
> -		status = acpi_ns_convert_to_package(return_object,&new_object);
> -		if (ACPI_SUCCESS(status)) {
> -			goto object_repaired;
> +		if (return_object->common.type == ACPI_TYPE_BUFFER) {
> +			status = acpi_ns_repair_package_list(data,&return_object);
> +			if (ACPI_SUCCESS(status)) {
> +				*return_object_ptr = return_object;
> +				data->flags |= ACPI_OBJECT_REPAIRED;
> +				return (AE_OK);
> +			}
> +		} else {
> +			status = acpi_ns_convert_to_package(return_object,&new_object);
> +			if (ACPI_SUCCESS(status)) {
> +				goto object_repaired;
> +			}

     {} here are against the CodingStyle.

WBR, Sergei
