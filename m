From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
Date: Fri, 22 Nov 2013 17:56:31 +0800
Message-ID: <528F2A4F.90908@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-2-git-send-email-al.stone@linaro.org> <1AE640813FDE7649BE1B193DEA596E880248C95D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40123 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab3KVJ42 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 04:56:28 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so1098708pad.12
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 01:56:27 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880248C95D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "al.stone@linaro.org" <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <ahs3@redhat.com>

On 2013-11-22 14:14, Zheng, Lv wrote:
[...]
>>  endif	# ACPI
>> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
>> index 28f4f4d..ae93a91 100644
>> --- a/include/acpi/platform/aclinux.h
>> +++ b/include/acpi/platform/aclinux.h
>> @@ -67,6 +67,10 @@
>>
>>  /* Host-dependent types and defines for in-kernel ACPICA */
>>
>> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
>> +#define ACPI_REDUCED_HARDWARE TRUE
>> +#endif
>> +
> 
> Maybe you put this here because of my previous wrong comment.
> 
> For ACPICA environments that work like Kconfigs for Linux, it is good to define them before including any ACPICA files.
> While putting things here cannot cover <asm/acpi.h>.

Good catch! thanks for the reminding.

> 
> Normally, I will do:
> 
> ...
> 
> #ifdef __KERNEL__
> 
> /* some comment */
> (one empty line as ACPICA enforces 1 empty line after 1 line comment and no empty lines after a block of comments)
> #ifdef CONFIG_ACPI_REDUCED_HARDWARE
> #define ACPI_REDUCED_HARDWARE(spaces not tabs here according to ACPICA's coding style)TRUE
> #endif
> 
> #include <linux/string.h>

There is a problem when I try yours suggestion, it is a compiling warning:

warning: "TRUE" is not defined

And I find that "TRUE" is defined in include/acpi/actypes.

So, is this ok to you?

--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -63,6 +63,13 @@
 #ifdef EXPORT_ACPI_INTERFACES
 #include <linux/export.h>
 #endif
+
+#define TRUE    (1 == 1)
+
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+#define ACPI_REDUCED_HARDWARE TRUE
+#endif
+
 #include <asm/acpi.h>

> 
> The coding style can help ACPICA release process to generate correct Linuxized patches.
> It would be good to Linux developers to follow this currently for ACPICA internal code or we may see a small useless divergences commit generated from a back ported Linux commit :-( .
> I'm sorry for the inconvenience.

ok, will update in next version.

> 
> Thanks
> -Lv

