From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [patch 2/4]  acpiphp: handle dock bridges
Date: Wed, 18 Jan 2006 13:43:07 +0900
Message-ID: <43CDC75B.8070408@jp.fujitsu.com>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:16317 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964938AbWAREqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2006 23:46:39 -0500
In-Reply-To: <1137545819.19858.47.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz

Kristen Accardi wrote:
> +static acpi_status handle_dock(struct acpiphp_func *func, int dock)
> +{
> +	acpi_status status;
> +	struct acpi_object_list arg_list;
> +	union acpi_object arg;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +
> +	dbg("%s: enter\n", __FUNCTION__);
> +
> +	/* _DCK method has one argument */
> +	arg_list.count = 1;
> +	arg_list.pointer = &arg;
> +	arg.type = ACPI_TYPE_INTEGER;
> +	arg.integer.value = dock;
> +	status = acpi_evaluate_object(func->handle, "_DCK",
> +					&arg_list, &buffer);
> +	if (ACPI_FAILURE(status))
> +		err("%s: failed to dock!!\n", MY_NAME);
> +
> +	return status;
> +}

I think you need to add acpi_os_free() for freeing buffer.pointer.

Thanks,
Kenji Kaneshige
