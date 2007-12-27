From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 4/4] [RFC] ACPI: WMI: Add sysfs userspace interface
Date: Thu, 27 Dec 2007 01:05:42 +0000
Message-ID: <200712270105.42686.carlos@strangeworlds.co.uk>
References: <20071218235137.12838.75397.stgit@localhost> <20071226193821.GA30729@srcf.ucam.org> <200712270054.02029.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:45984 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbXL0BFr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 20:05:47 -0500
In-Reply-To: <200712270054.02029.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thursday 27 December 2007 00:54:01 Carlos Corbacho wrote:
> On Wednesday 26 December 2007 19:38:22 Matthew Garrett wrote:
> > +               memcpy(guid_dev->bus_id, guid_string, 36);
> >
> > bus_id is only 20 bytes long at the moment...
>
> That's what the last patch in the series is the hack for (shortens this to
> 20 so you can at least see what this would like look, and test the GUID
> based autoloading) - although I think I forgot to resend that one with the
> last WMI series.
>
> Until this gets fixed upstream, the sysfs interface patch remains an RFC
> only.

The reason I'm a bit concerned about folding in the 20 byte limit is that I 
don't want to hit the case where we get a system with a bunch of GUIDs that 
only differ by the last 16 bytes and then fail to register the WMI driver.

Although I suppose in the short term, we don't know of such systems, nor do we 
have any real WMI drivers for them anyway, so this might be an acceptable 
trade off. So if you think the risk is worth it, I'll fold in the bus_id 
limit.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
