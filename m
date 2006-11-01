From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: dynamic SSDT address
Date: Wed, 01 Nov 2006 12:38:05 +0300
Message-ID: <45486AFD.4090901@linux.intel.com>
References: <200611010358.22743.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:53104 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1946728AbWKAJiN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Nov 2006 04:38:13 -0500
In-Reply-To: <200611010358.22743.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Yes, the patch is waiting Bob's approval for a month. If you want to take it as is I will prepare it...

Regards,
	Alex.
Len Brown wrote:
> Alexey,
> The new table code prints out the line for a dynamically loaded SSDT,
> but the address is 0.  Is it possible to find and print the address so that
> we can use it for acpidump of a dynamic table?
> 
> thanks,
> -Len
> 
> static: ACPI: SSDT @ 0x7f6d3a05/0x04DC (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624)
> 
> dynamic: ACPI: SSDT @ 0x00000000/0x0244 (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20050624)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
