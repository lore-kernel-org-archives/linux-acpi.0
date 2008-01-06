From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: DSDT problems with Asus K8V-X SE
Date: Sun, 6 Jan 2008 00:37:24 +0000
Message-ID: <200801060037.24499.carlos@strangeworlds.co.uk>
References: <477FB74A.7080908@tele2.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:49495 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757353AbYAFAh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 19:37:28 -0500
In-Reply-To: <477FB74A.7080908@tele2.se>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: AnMaster <anmaster@tele2.se>
Cc: linux-acpi@vger.kernel.org

On Saturday 05 January 2008 16:58:50 AnMaster wrote:
> My problem is a broken DSDT, I have tried to fix it, but I don't know if I
> did it the right way, nor how to solve the warning that remains when the
> errors are gone.

What exactly is broken about your DSDT that requires you to 'fix' it? 

Yes, lots of vendor DSDTs won't compile with the Intel compiler - this is 
because the Microsoft compiler is far more 'generous' than Intel's, and will 
allow a lot of spec breaking rubbish in.

However, the ACPI interpreter in Linux can handle most of these just fine; and 
if it can't, then that's a bug that needs to be fixed in Linux (since Linux 
should be able to handle unmodified MS compiled DSDTs out of the box).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
