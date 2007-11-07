From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH v5] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Wed, 7 Nov 2007 11:51:00 +0000
Message-ID: <200711071151.00852.carlos@strangeworlds.co.uk>
References: <200711030217.40814.carlos@strangeworlds.co.uk> <20071107045421.GA8294@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:42392 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbXKGLvL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Nov 2007 06:51:11 -0500
In-Reply-To: <20071107045421.GA8294@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Nashif, Anas" <anas.nashif@intel.com>

On Wednesday 07 November 2007 04:54:22 Matthew Garrett wrote:
> On Sat, Nov 03, 2007 at 02:17:39AM +0000, Carlos Corbacho wrote:
> > Handle a MOF[1] - the WMI mapper just exports methods, data and events to
> > userspace. MOF handling is down to userspace.
>
> How does userspace obtain the MOF from the ACPI tables?

Normally, userspace does not obtain the MOF from the ACPI tables.

Basically, there are four possible ways to otain a MOF:

1) A method in the WMI-ACPI implementation - _some_ (very few) implementations 
have a method in WMI-ACPI that will return a binary MOF (since the MS spec 
suggests this is just one _possible_ way to provide the MOF, but that it is 
not required).

2) Ask the hardware manufacturer or BIOS writer to provide it

3) Reverse engineer Windows software - try and extract the MOF from Windows 
software (we managed to do this on some newer Acer laptops just 
using 'strings', where the MOF was not converted to the binary MOF format).

4) Write your own MOF via experimentation, reverse engineering and guesswork

If you want, you can of course just bypass the whole MOF nonsense and start 
talking to WMI-ACPI, if you know what you're doing; a MOF file is really only 
required for a 'true' WBEM implementation - if you don't care about WBEM, 
then a MOF is really just a specification which tells you (roughly) what the 
interface does.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
