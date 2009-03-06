From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: CPI message on bootup for kernel .. CPU AMD Phenom II X3 (ACPI
	_PSS objects)
Date: Fri, 06 Mar 2009 09:04:38 +0800
Message-ID: <1236301478.3678.77.camel@localhost.localdomain>
References: <49AFC658.2010002@lordvan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:55215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbZCFBDj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Mar 2009 20:03:39 -0500
In-Reply-To: <49AFC658.2010002@lordvan.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Raschbacher <lordvan@lordvan.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-03-05 at 20:32 +0800, Thomas Raschbacher wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi.
> 
> I got a message about ACPI _PSS objects on bootup and that I should =
> contact
> the ACPI Maintainers.. So I'm doing this now.
> dmesg as attachment ..
> I got an ASUS M4A78T-E mainboard and an AMD Phenom II X3 cpu (AM3 socket)
> 
> If u need more info please let me know.
thanks for the info.
    On some boxes based on AMD chipset there is no _PSS object, which
causes that power-k8 cpufreq driver can't be loaded correctly.
    
    This issue had better be fixed by BIOS upgrading.

Thanks.
    
> 
> Regards
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.9 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkmvxcIACgkQv20tKfoYgelJzQCdHLTQhH72ECvANp7+eaU2A9xF
> dFoAnRTDoyO//juDlOpVFRt3QdoqHB6B
> =38I0
> -----END PGP SIGNATURE-----

