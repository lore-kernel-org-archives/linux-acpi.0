From: Thomas Renninger <trenn@suse.de>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sun, 3 Aug 2008 15:31:53 +0200
Message-ID: <200808031531.54725.trenn@suse.de>
References: <1217632817.4610.6.camel@hidalgo> <200808021930.05643.trenn@suse.de> <20080802194843.GA1168@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58575 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbYHCOHT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Aug 2008 10:07:19 -0400
In-Reply-To: <20080802194843.GA1168@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Saturday 02 August 2008 09:48:43 pm Matthew Garrett wrote:
> http://www.microsoft.com/whdc/archive/_OSI-method.mspx :
>
> "Any follow-on operating system from Microsoft that can support the
> Windows XP feature set will also return TRUE for Windows 2001. For
> example, if Microsoft released a follow-on operating system in 2003, it
> will probably be assigned a string of Windows 2003. This operating
> system would then return TRUE for the strings Windows 2001 and Windows
> 2003, and it would return FALSE for all other strings."
>
> So, no, it is not a test for Linux. Windows reports all versions, not
> just the current one.

Yes that seems to be right.
Later versions explicitly check for linux/bsd:

                   If (\_OSI ("Windows 2006"))
                    {
                        Store (0x01, \WVIS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, \LNUX)
                    }

                    If (\_OSI ("FreeBSD"))
                    {
                        Store (0x01, \LNUX)
                    }

This is even worse, because that means that Lenovo and everyone
else who has to add Windows hotfixes to their BIOS and potentially
have to break their Linux supported OS by that cannot guarantee
their customers full Linux support (without providing a separate
Linux BIOS).

        Thomas

