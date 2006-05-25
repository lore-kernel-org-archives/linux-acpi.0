From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
Date: Thu, 25 May 2006 13:34:26 -0700
Message-ID: <1148589267.3070.45.camel@whizzy>
References: <44760E0E.90408@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63078 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030395AbWEYUXL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 May 2006 16:23:11 -0400
In-Reply-To: <44760E0E.90408@acmelabs.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acme <saur@acmelabs.de>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com

On Thu, 2006-05-25 at 20:05 +0000, acme wrote:
> Hello Kristen,
> 
> does it make sense for me to patch? I meen, if you want me to dmesg, I 
> need a clean boot. But the panic occurs on boot. Since your patch makes 
> nothing but logging, this makes less sense for me.

The patch should prevent the oops if the problem is that the
dock_station structure is not initialized.  It does this by checking for
a NULL dock_station pointer and returning rather than dereferencing it.
So, if this is the cause of the oops, we will know because your system
will boot, and you will be able to get the dmesg.  So, if you could try
using the patch and reporting back either way, I would really appreciate
it.

Thanks,
Kristen


> And what is that dock thing, could my WOL on S3 and NIC problem also 
> have something to do with that?
> 
> Btw.: Len, I've compiled the 2.6.16.18 kernel last night, with and 
> without your latest acpi-release. The result was, with patch the system 
> woke up one time and the second time it died, without your patch the 
> system died the very first time sending a magic packet. Funny, but 
> keyboard and powerbutton are always working.
> 
> Regards,
> 
> Andreas
