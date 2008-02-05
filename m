From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 0/5] WMI patches for acpi-test (v2)
Date: Tue, 5 Feb 2008 21:18:01 +0000
Message-ID: <200802052118.02733.carlos@strangeworlds.co.uk>
References: <20080205021658.4422.83165.stgit@pacifica> <200802051603.30466.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:43006 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbYBEVSH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 16:18:07 -0500
In-Reply-To: <200802051603.30466.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-ia64@vger.kernel.org

On Tuesday 05 February 2008 21:03:30 Len Brown wrote:
> On Monday 04 February 2008 21:16, Carlos Corbacho wrote:
> > 2) Do you know of any IA64 systems using ACPI-WMI? At the moment, WMI
> > will work on x86 and hopefully IA64, but if it turns out that no vendor
> > has or ever will implement ACPI-WMI on IA64, then we could safely drop it
> > there.
>
> I recommend skipping WMI on IA64 unless/until a real need to support it
> emerges. There are no WMI extensions on the Intel Tiger or Hitachi Fusion
> IA64 boxes I have access to.

Ok. The only other vendors I really have in mind are HP and Fujitsu, since 
both those vendors use WMI on their laptops, so they would be my most likely 
candidates to have WMI on an IA64 box (if anyone actually does use WMI on 
IA64).

Len:

You can either add a 'depends on X86' to WMI when you apply patch #1 from the 
second WMI series; or I can send another patch out later on top of this 
series to do this, once you replace the old patches in acpi-test - whichever 
is easiest for you)

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
