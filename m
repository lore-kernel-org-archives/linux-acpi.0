From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [ACPICA] EmbeddedControl region handling bug in PNP0C14
Date: Sun, 16 Dec 2007 03:42:37 +0000
Message-ID: <200712160342.38771.carlos@strangeworlds.co.uk>
References: <200711280350.08539.carlos@strangeworlds.co.uk> <200712121726.53180.carlos@strangeworlds.co.uk> <476024CF.3000800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:43972 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558AbXLPDoR (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 15 Dec 2007 22:44:17 -0500
In-Reply-To: <476024CF.3000800@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Actually, a bit of further reading suggests that this is my fault :(

The original ACPI error was quite correct - there is no EC region handler 
installed - because the EC handler is only installed for the EC device 
(PNP0C09), not WMI (PNP0C14).

Had I read through the EC code earlier I would have spotted that one. So, my 
apologies for wasting your time with this.

So, what I need to do is update WMI to install a handler for the 
EmbeddedControl region in PNP0C14.

Alexey - I suspect the easiest way would be to make such a handler just call 
ec_read & ec_write, and let the EC driver do the real work, rather than 
trying to do anything more complicated in WMI?

-Carlos

(Hoping WMI doesn't keep throwing up more "surprises"...)
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
