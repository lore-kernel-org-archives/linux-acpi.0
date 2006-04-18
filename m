From: "Yu, Ling L" <ling.l.yu@intel.com>
Subject: acpi function test suite 0.1 and test results
Date: Tue, 18 Apr 2006 10:18:41 +0800
Message-ID: <D352FD896397D04482B87731BD4DBE7F4111E9@bjsmsx401nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18695 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932143AbWDRCTE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2006 22:19:04 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Zhang, Kexin" <kexin.zhang@intel.com>, "Luo, Zhenlin" <zhenlin.luo@intel.com>

All
I and Kexin Zhang wrote some ACPI function test suite, please download
it from
http://acpi.sourceforge.net/validation/testcases/acpi-test-0.1.tar.gz 
(which also includes the ABAT0.2 I published before)

The main function tested by these cases includes:
C-state
	Validate the C-state under AC-adpater or battery
T-state
	validate whether the CPU will become cooler while increasing the
CPU	throttling
	under the specific workload. Every processor needs to be tested.
Thermal Zone
	Adjust the system cooling mode to different mode: passive,
active, hot or critical, 
	In each supported thermal zone, set a trip points	and give
the CPUs in the thermal
	zone a workload to make the temperature passes the trip points,
verify if the
	corresponding actions will be taken by the system.
Battery
	Validate the battery event, alarm and actions when arriving
critical battery capacity
Button
	Validate the function of power button, sleep botton and lid
button
Generic Hotkey
	Test hotkey function.

About the detail test case assertion, please look at the
function/TestSpec.txt in the test suite
About how to run, please look at the function/README in the test suite.

Followings are test results got by these test cases:
Hardware Platform: Sony VGN-FE18C 
Kernel: 2.6.16
Test Results:
http://acpi.sourceforge.net/validation/testresults/acpitest0.1_sony_ia32
_2.6.16_testresults 
Hardware Platform: IBM T43P 
Kernel: 2.6.16-RC6
Test Results:
http://acpi.sourceforge.net/validation/testresults/acpitest0.1_t43p_ia32
_2.6.16-rc6_testresults 

Welcome to download and test, I will appreciate any comments or test
results sharing

Thanks
- Ling
