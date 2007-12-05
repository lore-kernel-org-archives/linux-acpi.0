From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Updating ACPI_OS_NAME ?
Date: Wed, 5 Dec 2007 13:57:03 +0000
Message-ID: <200712051357.03955.carlos@strangeworlds.co.uk>
References: <b43bf5490712050534r1eba2034s494c96dd90f22cf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:54399 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbXLEN61 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Dec 2007 08:58:27 -0500
In-Reply-To: <b43bf5490712050534r1eba2034s494c96dd90f22cf7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 05 December 2007 13:34:19 Erwan Velu wrote:
> If (\_OSI("Linux"))  {}
>
> So on recent hardware could it be interesting to use Windows 2006 or
> Linux as default ACPI_OS_NAME ?

You're mixing up _OS and _OSI - they are different things.

With _OS - Linux specifies it is compatible with one _OS string, and tries to 
match and run that (and you won't see 'Windows 2006' for this, since _OS is 
deprecated in favour of _OSI).

For _OSI - Linux advertises what _OSI strings it's compatible with 
(e.g. 'Windows 2001', 'Windows 2006', etc), and will run through _all_ those 
matching _OSI entries.

However, advertising _OSI("Linux") compatibility, on a lot of hardware, breaks 
things (since the _OSI("Linux") stuff ends up not properly initialising 
hardware, as the manufacturer probably never tested that code path).

Of course, there are a handful that really do need _OSI("Linux"), but these 
are the exception, not the rule.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
