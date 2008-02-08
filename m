From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 8/8] acer-wmi, tc1100-wmi: select ACPI_WMI
Date: Fri, 8 Feb 2008 09:37:45 +0000
Message-ID: <200802080937.46153.carlos@strangeworlds.co.uk>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org> <4a507d93fac78ecd37d18343c57c564f6a126f01.1202452053.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:50475 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759237AbYBHJiB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 04:38:01 -0500
In-Reply-To: <4a507d93fac78ecd37d18343c57c564f6a126f01.1202452053.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Friday 08 February 2008 06:29:24 Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> It is safe for these Kconfig entries to use select because
> they select ACPI_WMI, which already has its dependencies
> satisfied.  This makes Kconfig more user friendly, since
> the user selects the driver they want and the dependency
> is met for them.  Otherwise, the user would have to find
> and enable ACPI_WMI to make enabling these drivers possible.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
