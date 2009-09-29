From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] cmpc_acpi: Added support for Classmate PC ACPI devices.
Date: Tue, 29 Sep 2009 13:17:52 -0700
Message-ID: <1254255472.3797.12.camel@Joe-Laptop.home>
References: <1254188280-29155-1-git-send-email-cascardo@holoscopio.com>
	 <20090929130522.ecf4d5ec.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:1428 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbZI2URt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Sep 2009 16:17:49 -0400
In-Reply-To: <20090929130522.ecf4d5ec.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-kernel@vger.kernel.org, len.brown@intel.com, don@syst.com.br, linux-acpi@vger.kernel.org

On Tue, 2009-09-29 at 13:05 -0700, Andrew Morton wrote:
> static acpi_status cmpc_start_accel(acpi_handle handle)
> {
> 	union acpi_object param[2];
> 	struct acpi_object_list input;
> 	acpi_status status;
> 
> 	param[0].type = ACPI_TYPE_INTEGER;
> 	param[0].integer.value = 0x3;
> 	param[1].type = ACPI_TYPE_INTEGER;
> 	input.count = 2;
> 	input.pointer = param;
> 	status = acpi_evaluate_object(handle, "ACMD", &input, NULL);
> 	return status;
> }
> 
> puts a smile on our faces.

Much better, but what appears to be incomplete initialization
of stack variables is also a bit offputting.

cheers, Joe


