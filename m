From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI: EC: evaluating _Q10
Date: Tue, 2 Jan 2007 12:05:07 -0500
Message-ID: <200701021205.07817.lenb@kernel.org>
References: <45992109.9050009@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54729 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384AbXABRF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jan 2007 12:05:56 -0500
In-Reply-To: <45992109.9050009@m3y3r.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday 01 January 2007 09:56, Thomas Meyer wrote:
> I know this topic was already on the list. But 2.6.20-rc3 still gives me 
> tons of these messages in the log buffer:
> 
> "ACPI: EC: evaluating _Q10
> ACPI: EC: evaluating _Q10
> ACPI: EC: evaluating _Q10
> ACPI: EC: evaluating _Q10
> ACPI: EC: evaluating _Q10
> [and so on]"
> 
>  Is this an error at all?

not an error, just a stray printk in an EC event handler.
fix already queued to linus.

The bigger question is why you get "tons of these" --
as EC  events are usually infrequent.
Do you have a big number next to "acpi" in /proc/interrupts?
If so, at what rate is it growing?

thanks,
-Len
