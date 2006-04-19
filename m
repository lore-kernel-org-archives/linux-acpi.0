From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [2/2] ACPI: report "Module Device" support via _OSI
Date: Wed, 19 Apr 2006 15:34:35 +0900
Message-ID: <4445D9FB.100@jp.fujitsu.com>
References: <200604181558.55296.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22981 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750799AbWDSGgm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 02:36:42 -0400
Received: from m7.gw.fujitsu.co.jp ([10.0.50.77])
        by fgwmail7.fujitsu.co.jp (Fujitsu Gateway)
        with ESMTP id k3J6ae33031532 for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2006 15:36:40 +0900
        (envelope-from kaneshige.kenji@jp.fujitsu.com)
Received: from s5.gw.fujitsu.co.jp by m7.gw.fujitsu.co.jp (8.12.10/Fujitsu Domain Master)
	id k3J6adoG024305 for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2006 15:36:40 +0900
	(envelope-from kaneshige.kenji@jp.fujitsu.com)
Received: from s5.gw.fujitsu.co.jp (s5 [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id DB42A1B805E
	for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2006 15:36:39 +0900 (JST)
Received: from fjm503.ms.jp.fujitsu.com (fjm503.ms.jp.fujitsu.com [10.56.99.77])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 75CAD1B805B
	for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2006 15:36:39 +0900 (JST)
Received: from fjmscan503.ms.jp.fujitsu.com (fjmscan503.ms.jp.fujitsu.com [10.56.99.143])by fjm503.ms.jp.fujitsu.com with ESMTP id k3J6aVgA001305
	for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2006 15:36:32 +0900
In-Reply-To: <200604181558.55296.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Moore, Robert" <robert.moore@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>, Motoyuki Ito <motoyuki@soft.fujitsu.com>

Hi,

I have a question. The ACPI container driver can be build as a
kernel module. Should _OSI("Module Device") returns TRUE even
when container driver module is not loaded? (Typically, _OSI is
evaluated at _INI time, I think. So container driver module is
not loaded at _OSI("Module Device") time anyway.)

Thanks,
Kenji Kaneshige


Bjorn Helgaas wrote:
> Update _OSI strings to report that "Module Device" is supported.
> 
> This is Linux-specific, so it should be one of the Linux divergences
> from the Intel ACPI CA.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work-mm5/drivers/acpi/utilities/uteval.c
> ===================================================================
> --- work-mm5.orig/drivers/acpi/utilities/uteval.c	2006-04-18 15:31:22.000000000 -0600
> +++ work-mm5/drivers/acpi/utilities/uteval.c	2006-04-18 15:32:38.000000000 -0600
> @@ -69,6 +69,9 @@
>  	/* Feature Group Strings */
>  
>  	"Extended Address Space Descriptor",
> +#ifdef CONFIG_ACPI_CONTAINER
> +	"Module Device",
> +#endif
>  };
>  
>  /* Local prototypes */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

