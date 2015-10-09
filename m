From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 2/3] acpi: add a utility function for evaluating _FIT
Date: Fri, 09 Oct 2015 13:28:45 -0400
Message-ID: <x497fmwj6ia.fsf@segfault.boston.devel.redhat.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	<1444254577-23744-3-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758597AbbJIR2r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2015 13:28:47 -0400
In-Reply-To: <1444254577-23744-3-git-send-email-vishal.l.verma@intel.com>
	(Vishal Verma's message of "Wed, 7 Oct 2015 15:49:36 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@ml01.01.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

>  /**
> + * acpi_evaluate_fit: Evaluate _FIT method to get an updated NFIT
> + * @handle: ACPI device handle
> + * @buf: buffer for the updated NFIT
> + *
> + * Evaluate device's _FIT method if present to get an updated NFIT
> + */
> +acpi_status acpi_evaluate_fit(acpi_handle handle, struct acpi_buffer **buf)
> +{
> +	acpi_status status;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +	status = acpi_evaluate_object(handle, "_FIT", NULL, &buffer);
> +
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	*buf = &buffer;

Umm, unless I'm missing something, you're returning a stack address.

-Jeff
