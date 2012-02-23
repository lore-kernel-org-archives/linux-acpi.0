From: "Jan Beulich" <jbeulich@suse.com>
Subject: Re: [PATCH 1/2] RFC: Prepare PAD for native and xen platform
Date: Thu, 23 Feb 2012 14:54:03 +0000
Message-ID: <4F46530B020000780007F751@nat28.tlf.novell.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD088@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:35461 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab2BWOyI convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Thu, 23 Feb 2012 09:54:08 -0500
In-Reply-To: <DE8DF0795D48FD4CA783C40EC82923350AD088@SHSMSX101.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jinsong.liu@intel.com, konrad.wilk@oracle.com
Cc: keir.xen@gmail.com, len.brown@intel.com, shaohua.li@intel.com, lenb@kernel.org, xen-devel@lists.xensource.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

>>> "Liu, Jinsong" <jinsong.liu@intel.com> 02/23/12 2:29 PM >>>
>--- a/drivers/acpi/Kconfig
>+++ b/drivers/acpi/Kconfig
>@@ -213,10 +213,11 @@ config ACPI_HOTPLUG_CPU
>    default y
 >
>config ACPI_PROCESSOR_AGGREGATOR
>-    tristate "Processor Aggregator"
>+    bool "Processor Aggregator"

There must be ways to address whatever strange problem you see without
making this piece of code non-modular.

>    depends on ACPI_PROCESSOR
>    depends on EXPERIMENTAL
>    depends on X86
>+    default n

This is pointless.

>    help
>      ACPI 4.0 defines processor Aggregator, which enables OS to perform
>      specific processor configuration and control that applies to all

Jan

