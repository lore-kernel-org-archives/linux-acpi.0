From: Zhao Yakui <yakui.zhao@intel.com>
Subject: a problem about the EC driver
Date: Mon, 21 Jan 2008 23:17:24 +0800
Message-ID: <1200928644.17879.49.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22395 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756920AbYAUHKh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 02:10:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org

Hi, Alexey
    I know that you are very familiar with the EC driver and you submit
a lot patches for EC. Now I have a problem about the EC and want to get
help from you.
   a. In the March of 2007 the patch of
33c7a0738c5f753a7d94fd3b2ec7d84e79a141a8 was submitted by you. In this
patch the Fake ECDT workaround is no longer used, which means that OSPM
won't parse EC in DSDT when there is no ECDT table. 
   b. In the August of 2007 the patch of
cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b was submitted. In this patch
OSPM will parse EC in DSDT when there is no ECDT table. It seems that
many laptops without ECDT table will be affected. Is there a potential
problem for the laptops without ECDT table? 
   c. In the November of 2007 the patch of
5870a8cd23181703cc76f88f630372f8602c7648 was submitted. In this patch
_INI check is added for EC device in DSDT table, which means that in the
function of acpi_ec_ecdt_probe OSPM won't install EC handler when no
_INI  method is found under the scope of EC in DSDT. It seems that a
regression is caused by this patch. Please refer to the bug 9730. In the
bug of 9730 there is no _INI method for EC device in DSDT table and OSPM
won't install EC handler. But the _CRS method of EC device will set the
EC flag. So some devices can't access the Operation Region defined in EC
device in the course of Linux ACPI device scan and the error messages
are reported. 
    According to the description of this patch it seems that the _EC
device is related to the _INI method.  But according to ACPI spec
whether the operation region can be accessed is related to the _REG
method. 
   d. In the Jan of 2008 the patch of
c04209a7948b95e8c52084e8595e74e9428653d3 was submitted. In this patch
the function of boot_ec_enable is added , which means that OSPM will
install EC handler for boot_ec device before acpi_bus_scan. 
   
   I don't understand why the flowchart of boot EC is changed very
frequently. Will you please give me detailed info about the four
patches? Maybe it is helpful for us to understand the EC driver.
   

Thanks.

   
     

    

