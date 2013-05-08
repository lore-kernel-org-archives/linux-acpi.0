From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: ACPI battery driver loading failed..
Date: Wed, 8 May 2013 15:39:08 +0800
Message-ID: <CAOLK0pwbCJFmmn1Uix9VSYGM_VEh3oVyZHNg8iDZ9ws14_KMew@mail.gmail.com>
References: <D854C92F57B1B347B57E531E78D05EAD2DB9A150@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:51945 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3EHHjI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 May 2013 03:39:08 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so1658670iae.34
        for <linux-acpi@vger.kernel.org>; Wed, 08 May 2013 00:39:08 -0700 (PDT)
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD2DB9A150@BGSMSX104.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "Westerberg, Mika" <mika.westerberg@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2013/5/8 Pallala, Ramakrishna <ramakrishna.pallala@intel.com>
>
> Hi All,
>
> Kernel acpi battery driver loading fails eventhouh I have FW entry for PNP0C0A. but I see acpi ac driver is getting loaded without any issue.
>
> One thing I observed is FW doesn't implement the _CSR method which is being implemented by most of PNP devices.
>
> I have enabled the following driver in kernel config.
>
> CONFIG_ACPI=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_PROCFS is not set
> CONFIG_ACPI_PROCFS_POWER=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_PROC_EVENT=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
>
> CONFIG_PNPACPI=y
>
> Also does acpi battery depends on BIOS for loading?
>
Hi Ram:
            Please provide the output of dmesg and acpidump.
>
> Thanks,
> Ram
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--
Best regards
Tianyu Lan
