From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC] [Patch 1/2]  ACPI :Compare EC device in DSDT table with
 that	in ECDT table
Date: Mon, 17 Nov 2008 17:53:47 +0300
Message-ID: <4921857B.7000303@suse.de>
References: <1226904541.4062.23.camel@yakui_zhao.sh.intel.com>	 <49212B22.5030202@suse.de> <1226914935.4062.67.camel@yakui_zhao.sh.intel.com> <49214B9C.6030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:58005 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752359AbYKQOxr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Nov 2008 09:53:47 -0500
In-Reply-To: <49214B9C.6030204@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

> Zhao Yakui wrote:
>>     b. On the laptops of bug 11880 all the info in ECDT table is 
>> incorrect. The EC GPE number and EC namepath are incorrect besides the 
>> EC Cmd/Status/Data I/O port.
Actually, 11880 does not require any magic or comparison of DSDT and ECDT,
you may just compare command and data addresses, and if they are the same,
skip ECDT.
> Regards,
> Alex.

