From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 0/5] WMI patches for acpi-test (v2)
Date: Wed, 6 Feb 2008 02:03:23 +0000
Message-ID: <200802060203.24856.carlos@strangeworlds.co.uk>
References: <20080205021658.4422.83165.stgit@pacifica> <200802052118.02733.carlos@strangeworlds.co.uk> <200802051735.55106.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:38249 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1757888AbYBFCDa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 21:03:30 -0500
In-Reply-To: <200802051735.55106.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-ia64@vger.kernel.org

On Wednesday 06 February 2008 00:35:54 Bjorn Helgaas wrote:
> > Ok. The only other vendors I really have in mind are HP and Fujitsu,
> > since both those vendors use WMI on their laptops, so they would be my
> > most likely candidates to have WMI on an IA64 box (if anyone actually
> > does use WMI on IA64).
>
> How could I tell whether our HP systems use WMI?

Do you have any PNP0C14 or *pnp0c14 _HID objects defined in the DSDTs for your 
systems? If not, then your systems don't use WMI.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
