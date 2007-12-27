From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/4] ACPI: WMI: Add ACPI-WMI mapping driver
Date: Thu, 27 Dec 2007 01:09:39 +0000
Message-ID: <200712270109.40121.carlos@strangeworlds.co.uk>
References: <20071218235137.12838.75397.stgit@localhost> <20071218235143.12838.33679.stgit@localhost> <20071226211718.GA31564@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:35808 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbXL0BJn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 20:09:43 -0500
In-Reply-To: <20071226211718.GA31564@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>

On Wednesday 26 December 2007 21:17:18 Matthew Garrett wrote:
> +       if (!wmi_external_handler)
> +               return AE_ALREADY_ACQUIRED;

I'm not sure (mostly because I don't like dealing with typedefs around 
pointers, and this bit is also untested).

> I'm also a bit 
> unhappy about only being able to register one notification handler, if
> we consider the case where vendors add and remove WMI interfaces over
> time - it might make sense to have individual small drivers rather than
> one big one, which would mean a notification handler per GUID. Any
> thoughts?

Yes, a notification handler per GUID does make sense, so I'll add that to WMI.

Also, many thanks for reviewing this.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
