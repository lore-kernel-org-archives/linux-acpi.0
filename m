From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [patch] acpiphp: handle dock stations
Date: Thu, 02 Feb 2006 14:09:21 +0900
Message-ID: <43E19401.6060500@jp.fujitsu.com>
References: <20060201233005.GA4999@nerpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:39108 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161115AbWBBFMK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Feb 2006 00:12:10 -0500
In-Reply-To: <20060201233005.GA4999@nerpa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristenc@cs.pdx.edu>
Cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com, len.brown@intel.com, pavel@ucw.cz, linux-kernel@vger.kernel.org, muneda.takahiro@jp.fujitsu.com, linux-acpi@vger.kernel.org

Kristen Carlson Accardi wrote:
> +int is_dependent_device(acpi_handle handle)
> +{
> +	struct dependent_device *dd;
> +
> +	if (!ds)
> +		return 0;
> +
> +	list_for_each_entry(dd, &ds->dependent_devices, device_list) {
> +		if (handle == dd->handle)
> +			return 1;
> +	}
> +	return 0;
> +}
(snip.)
> +struct dependent_device * get_dependent_device(acpi_handle handle)
> +{
> +	struct dependent_device *dd;
> +
> +	list_for_each_entry(dd, &ds->dependent_devices, device_list) {
> +		if (handle == dd->handle)
> +			return dd;
> +	}
> +	return NULL;
> +}

Those look very similar...



> +
> +	/* make sure we are dependent on the dock device */
> +	acpi_get_name(dck_handle, ACPI_FULL_PATHNAME, &buffer);
> +	status = acpi_evaluate_object(handle, "_EJD", NULL, &ejd_buffer);
> +	if (ACPI_FAILURE(status)) {
> +		err("Unable to execute _EJD!\n");
> +		goto find_ejd_out;
> +	}
> +
> +	/* because acpi_get_name will pad the names if they are less
> +	 * than 4 characters, we can't compare the strings returned
> +	 * from _EJD with those returned from acpi_get_name.  So,
> +	 * we have to get a handle to the object referenced by _EJD
> +	 * and then call get name on that.
> +	 */
> +	ejd_obj = ejd_buffer.pointer;
> +	status = acpi_get_handle(NULL, ejd_obj->string.pointer, &tmp);
> +	if (ACPI_FAILURE(status))
> +		goto find_ejd_out;
> +	acpi_get_name(tmp, ACPI_FULL_PATHNAME, &ejd_name_buffer);
> +
> +	dck_obj = buffer.pointer;
> +	if (!strncmp(ejd_objname, objname, strlen(ejd_objname))) {

I don't think you need to compare pathnames.
Why not just compare ACPI handles like below?

	if (dck_handle == tmp) {
		...

Thanks,
Kenji Kaneshige

