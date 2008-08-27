From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [ANNOUNCE] ACPI BIOS Guideline for Linux
Date: Wed, 27 Aug 2008 21:29:15 +0100
Message-ID: <200808272129.16131.carlos@strangeworlds.co.uk>
References: <200807241732.23412.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:36518 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYH0U30 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 16:29:26 -0400
In-Reply-To: <200807241732.23412.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday 24 July 2008 16:32:22 Thomas Renninger wrote:
> \section{WMI - Windows Management Instrumentation}
>
> WMI is a Microsoft specific service. A small part of it
> describes possible ACPI WMI implementations provided by the BIOS.
> This is not part of the official ACPI specification and BIOS developers
> should avoid using it. The Linux kernel driver supports basic WMI ACPI
> functionality (since 2.6.25), but it is marked experimental.
> ACPI functionality should not depend on the WMI interface.

Perhaps it would be more useful to suggest to vendors/ BIOS writers what they 
should use here instead?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
