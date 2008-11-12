From: Skywing <Skywing@valhallalegends.com>
Subject: RE: [RESEND] [PATCH 3/6] ACPI: create sysfs I/F for inactive tables
Date: Wed, 12 Nov 2008 14:32:16 -0600
Message-ID: <982D8D05B6407A49AD506E6C3AC8E7D6BEF9369129@caralain.haven.nynaeve.net>
References: <1226478545.15014.173.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.webhostone.com ([66.250.45.124]:41106 "EHLO
	smtp2.webhostone.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYKLVRc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 16:17:32 -0500
In-Reply-To: <1226478545.15014.173.camel@rzhang-dt>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Zhang Rui wrote:

> +		if (strncmp(table_attr->name, "NULL", ACPI_NAME_SIZE))
> +			memcpy(name, table_attr->name, ACPI_NAME_SIZE);
> +		else
> +			memcpy(name, "\0\0\0\0", ACPI_NAME_SIZE);
> +		status = acpi_get_table(name,
> +					table_attr->instance, &table_header);

Minor nit / suggestion: Wouldn't it be a bit better to use memset instead of memcpy for the \0\0\0\0 memcpy case?  Otherwise, you need to make sure that you have at least as many \0's in the string literal as ACPI_NAME_SIZE, which is a lil bit ugly.  If you are cleaning things up to use symbolic constants there, you might consider changing it to a memset while you're at it.

- S
