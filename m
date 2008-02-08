From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Fri, 8 Feb 2008 09:37:33 +0000
Message-ID: <200802080937.35225.carlos@strangeworlds.co.uk>
References: <20080207214715.GA15211@elf.ucw.cz> <200802080027.54576.carlos@strangeworlds.co.uk> <20080208065312.GA4341@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:50478 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759397AbYBHJi2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 04:38:28 -0500
In-Reply-To: <20080208065312.GA4341@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ray Lee <ray-lk@madrabbit.org>, Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org

On Friday 08 February 2008 06:53:13 Pavel Machek wrote:
> I believe selct is the way to go here. What do acer-wmi handle?
> Additional buttons? Leds? Temperatures? Fan states?

Enabling wireless, bluetooth and 3G; and exposing the mail LED and backlight.

tc1100-wmi handles wireless and the jog dial, IIRC.

> The laptops will boot fine without it, right?

Yes.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
