From: alexey.kodanev@oracle.com
Subject: ACPI test
Date: Fri, 13 Sep 2013 16:20:51 +0400
Message-ID: <52330323.6020702@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19780 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab3IMMVU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Sep 2013 08:21:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ltp-list@lists.sourceforge.net, Vasily Isaenko <vasily.isaenko@oracle.com>

Hi All!

I'm reviewing Linux Test Project's test concerning ACPI and a little bit 
lost with the following test: 
https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/device-drivers/acpi. 
It's quite outdated...

Pardon my technical knowledge on this subject but could you guide me to 
solve the following questions about the test and ACPI:

* Is it necessary to use block device to test ACPI functionality as test 
does?

* How can I verify data which I get from acpi_driver_data() using random 
acpi device handle? The test is using its own 'acpi_ec' structure and 
trying to cast return void pointer from that function to it, but in the 
kernel, this structure is slightly different and defined internally.

May be you have some thoughts how ACPI test should look like? Any help 
is appreciated.

Many thanks,
Alexey
