From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: lenovo 3000 n100 thermal+hibernate
Date: Sun, 9 Mar 2008 13:10:22 +0200
Message-ID: <200803091310.22074.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:64182 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYCILK1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Mar 2008 07:10:27 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1137390fkz.5
        for <linux-acpi@vger.kernel.org>; Sun, 09 Mar 2008 04:10:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, I have problems with thermal module on lenovo 3000 n100,

Sometimes after resuming from suspend, 
cat /proc/acpi/thermal_zone/TZ00/temperature says that CPU temp is 70 C and 
fan blows cold air. But coretemp says that CPU temp is about 40 C. 

Also I get following message on dmesg:
ACPI Exception (thermal-0471): AE_NOT_FOUND, Invalid active threshold [0] 
[20070126]

Reloading of module doesn't help, and I have no such bug in windows. 
I've tried kernels 2.6.20-2.6.24, and bug is present in all of them.

I can provide any additional info required ;)

Regards
Vasily
