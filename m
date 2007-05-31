From: John Floyd <jfloyd@bigpond.net.au>
Subject: smartbattery status on Laptop
Date: Thu, 31 May 2007 17:11:09 +1000
Message-ID: <200705311711.09397.jfloyd@bigpond.net.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from CPE-124-188-208-248.nsw.bigpond.net.au ([124.188.208.248]:11521
	"EHLO mozzy.sparman" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757326AbXEaILJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 04:11:09 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Have a specialised weatherproof laptop with a smartbattery running FC6
 latest kernel. I cannot get battey monitoring going. Have loaded
 modules i2c_ec and sbs with out any errors.

log/messages indicate that the EC driver loads with
ACPI: EC HC smbus [SMB1]

There is nothing from the sbs module though it is loaded and
the /proc/acpi/battery directory is empty.

The smartbattery can be recognized. If I run the following command ...

smartbattery 1             (1 is to specify the i2c dev,
                            needs i2c-dev module loaded)

then I get battery status, which behaves properly (changes if I unplug
 AC etc). It shows Battery name, status , charge or discharge current,
 time to full/left, temperature etc.  The smartbattery command came
 with the initial code exploring the ec-smbus interface a couple of
 years ago by Bruno Ducrot.

However nothing shows up in the proc/acpi/battery directory under the
 sbs module, and therefore the gui battery indicators do not work

Any suggestions?


Love to get this working in the gui.


John
--
John Floyd
Senior Natural Resource Officer
Department of Environment and Climate Change
Phone +61-2-9895-5956
Fax   +61-2-9895-7263
john.floyd@dnr.nsw.gov.au

-------------------------------------------------------
