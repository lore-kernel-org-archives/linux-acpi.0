From: "Bernd Bartmann" <bernd.bartmann@gmail.com>
Subject: Getting ACPI data like CPU and FBDIMM temperature / fan speeds on ASUS DSBV-DX/SAS
Date: Sun, 19 Aug 2007 19:37:31 +0200
Message-ID: <6c18a4f0708191037g500342c7vec14ab2293ed9a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:21855 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbXHSRhd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Aug 2007 13:37:33 -0400
Received: by py-out-1112.google.com with SMTP id u77so1612402pyb
        for <linux-acpi@vger.kernel.org>; Sun, 19 Aug 2007 10:37:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

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
