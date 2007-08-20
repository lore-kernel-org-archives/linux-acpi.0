From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Getting ACPI data like CPU and FBDIMM temperature / fan speeds on ASUS DSBV-DX/SAS
Date: Mon, 20 Aug 2007 08:50:44 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE9CAEB5@pdsmsx414.ccr.corp.intel.com>
References: <6c18a4f0708191037g500342c7vec14ab2293ed9a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36941 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762AbXHTAur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Aug 2007 20:50:47 -0400
Content-class: urn:content-classes:message
In-Reply-To: <6c18a4f0708191037g500342c7vec14ab2293ed9a2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bernd Bartmann <bernd.bartmann@gmail.com>, linux-acpi@vger.kernel.org

Hi, Bernd,

First please set the ACPI version to 2.0 and see if there is any
difference.
And please attach the acpidump output when you are running ACPI 2.0.

Thanks,
Rui

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Bernd Bartmann
Sent: Monday, August 20, 2007 1:38 AM
To: linux-acpi@vger.kernel.org
Subject: Getting ACPI data like CPU and FBDIMM temperature / fan speeds
on ASUS DSBV-DX/SAS

I'm running Centos5 x86_64 on an ASUS DSBV-DX/SAS mainboard with a
Xeon E5345 quad core CPU. The mainboard BIOS shows me all the thermal
information about CPU and the FBDIMMs as well as the fan rotation
speeds. ACPI is set to version 3.0 in the BIOS. The mainboard chipset
is Intel i5000V.

Under Centos5 I can't see any of these information under
/proc/acpi/thermal_zone. This directory is just empty. Do I have to
load any special kernel modules to get the correct values?

Of course I'd like to have acpid give alerts or shut down the system
in case of overheating.

Best regards,
Bernd.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
