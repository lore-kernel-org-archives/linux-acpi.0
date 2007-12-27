From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 4/4] [RFC] ACPI: WMI: Add sysfs userspace interface
Date: Thu, 27 Dec 2007 00:54:01 +0000
Message-ID: <200712270054.02029.carlos@strangeworlds.co.uk>
References: <20071218235137.12838.75397.stgit@localhost> <20071218235200.12838.13702.stgit@localhost> <20071226193821.GA30729@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:32770 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbXL0AyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 19:54:08 -0500
In-Reply-To: <20071226193821.GA30729@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday 26 December 2007 19:38:22 Matthew Garrett wrote:
> +               memcpy(guid_dev->bus_id, guid_string, 36);
>
> bus_id is only 20 bytes long at the moment...

That's what the last patch in the series is the hack for (shortens this to 20 
so you can at least see what this would like look, and test the GUID based 
autoloading) - although I think I forgot to resend that one with the last WMI 
series.

Until this gets fixed upstream, the sysfs interface patch remains an RFC only.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
