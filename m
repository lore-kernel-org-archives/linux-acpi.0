From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to support shared
 GPEs
Date: Thu, 18 Feb 2010 16:05:07 +0900
Message-ID: <4B7CE6A3.7020103@np.css.fujitsu.com>
References: <201002172335.47703.rjw@sisk.pl> <201002172341.07353.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36746 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0BRHDr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2010 02:03:47 -0500
In-Reply-To: <201002172341.07353.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Oliver Neukum <oliver@neukum.org>, Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Gary Hade <garyhade@us.ibm.com>

Hi, Rafael J. Wysocki
> -	/* Update enable mask, but don't enable the HW GPE as of yet */
> -
> -	status = acpi_ev_enable_gpe(gpe_event_info, FALSE);
I think the above line code should be remained. If it is deleted, the exception 
event will be raised on some machine.

Best Regards,
Jin Dongming
> -
>  	ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
>  			  "Registered GPE method %s as GPE number 0x%.2X\n",
>  			  name, gpe_number));
> -	return_ACPI_STATUS(status);
> +	return_ACPI_STATUS(AE_OK);
>  }
>  


