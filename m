From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix up a multitude of ACPI compiler warnings on x86_64
Date: Fri, 29 Sep 2006 15:05:26 -0700
Message-ID: <20060929150526.38eec941.akpm@osdl.org>
References: <451D9236.6040902@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:35539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932162AbWI2WFf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Sep 2006 18:05:35 -0400
In-Reply-To: <451D9236.6040902@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Bligh <mbligh@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Fri, 29 Sep 2006 14:37:58 -0700
Martin Bligh <mbligh@google.com> wrote:

> 32bit vs 64 bit issues. sizeof(sizeof) and sizeof(pointer) is variable,
> but we're trying to shove it into unsigned int or u32.
>
> ...
>
> -	"RSDT/XSDT length (%X) is smaller than minimum (%X)",
> +	"RSDT/XSDT length (%X) is smaller than minimum (%lX)",
>  	table_ptr->length,
> -	sizeof(struct acpi_table_header)));
> +	(unsigned long) sizeof(struct acpi_table_header)));
> 

These two sizeof()s have already been fixed by Randy in -mm's
acpi-fix-printk-format-warnings.patch.

Randy's fix is the preferred one: sizeof() returns size_t and size_t's are
printed with %z - there's no need to use a typecast.

(Actually Randy used %Z which avoids the warning which old gcc emitted with
%z, but is old-fashioned.  I'll switch that to %z).


acpi-fix-printk-format-warnings.patch was submitted to the ACPI developers
on August 14 and on September 25 but remains unmerged.
