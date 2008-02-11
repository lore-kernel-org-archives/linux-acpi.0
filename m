From: Len Brown <lenb@kernel.org>
Subject: Re: If "acpi_osi=Linux" works better, pleas e notify linux-acpi@vger.kernel.org
Date: Sun, 10 Feb 2008 21:29:14 -0500
Message-ID: <200802102129.14622.lenb@kernel.org>
References: <e678b6ed0802100637s5d8037kcdc1e0580b11b0d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47202 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbYBKC3a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Feb 2008 21:29:30 -0500
In-Reply-To: <e678b6ed0802100637s5d8037kcdc1e0580b11b0d1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dennis Jansen <d.g.jansen@googlemail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 10 February 2008 09:37, Dennis Jansen wrote:
> Hi,
> 
> it works a lot better with acpi_osi=Linux in 2.6.24 x64. Wireless is
> much more stable and the power consumption decreases by about 2 W.

Are you sure the only difference is booting with "acpi_osi=Linux"?

In both BIOS V1.21 and V1.31 it appears to be a no-op.
The only way I could imagine it could have an effect is if
somethign in SMM is looking at the LINX variable.

Based on past lack of Linux awareness from this particular vendor,
the chances of that happening seem quite small.

thanks,
-Len
