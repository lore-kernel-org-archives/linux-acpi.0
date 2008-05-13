From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch] pci-acpi: handle multiple _OSC
Date: Tue, 13 May 2008 09:14:32 -0700
Message-ID: <200805130914.32657.jbarnes@virtuousgeek.org>
References: <1210238510.23649.2.camel@sli10-desk.sh.intel.com> <200805120907.35106.jbarnes@virtuousgeek.org> <482947E2.5070101@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-36.bluehost.com ([69.89.20.190]:38418 "HELO
	outbound-mail-36.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757172AbYEMQVS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 12:21:18 -0400
In-Reply-To: <482947E2.5070101@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tuesday, May 13, 2008 12:48 am Kenji Kaneshige wrote:
> The acpi_query_osc() function can be called for the ACPI object that
> doesn't have _OSC method. In this case, acpi_get_osc_data() would
> allocate a useless memory region. To avoid this, we need to check the
> existence of _OSC before calling acpi_get_osc_data().
>
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Thanks Kenji, applied.

Jesse
