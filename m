From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/3] The basics of DSDT from initramfs
Date: Tue, 5 Feb 2008 14:56:14 +0000
Message-ID: <200802051456.15710.carlos@strangeworlds.co.uk>
References: <4798E2A5.6020804@users.sf.net> <47A5F9C7.70402@tremplin-utc.net> <1202222629.14573.257.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:58563 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYBEO4T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 09:56:19 -0500
In-Reply-To: <1202222629.14573.257.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Tuesday 05 February 2008 14:43:48 Thomas Renninger wrote:
> >  Download the Intel ASL
> > +compiler/decompiler at 
http://www.intel.com/technology/IAPC/acpi/downloads.htm .
> AFAIK Intel wants to move away from this address.
> There should have been an opensource project for the ACPICA code
> started, we should reference this one instead. Len?

http://www.acpica.org/downloads/

(Although at the moment, it's a bit of a trek through the new site to figure 
out that Linux needs the tools under 'UNIX source code' - a big fat link on 
the Linux page to the UNIX tools would be better, and all the compiling 
instructions from the Linux page can then just be moved to the 'UNIX source 
code' page, since they're clearly not Linux specific).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
