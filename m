From: Andreas Juch <andreas.juch@aon.at>
Subject: Acer Travelmate 4002 WLMi ACPI Issues
Date: Wed, 15 Feb 2006 19:08:59 +0100
Message-ID: <43F36E3B.5030702@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from WARSL402PIP6.highway.telekom.at ([195.3.96.93]:50083 "EHLO
	email.aon.at") by vger.kernel.org with ESMTP id S1750889AbWBOSIC
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Feb 2006 13:08:02 -0500
Received: from m1950p024.adsl.highway.telekom.at (HELO server.netzwerk) ([80.121.115.184])
          (envelope-sender <andreas.juch@aon.at>)
          by smarthub77.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 15 Feb 2006 18:07:57 -0000
Received: from [192.168.0.6] (helo=[192.168.0.6])
	by server.netzwerk with esmtp (Exim 4.50)
	id 1F9R4K-0005dr-JH
	for linux-acpi@vger.kernel.org; Wed, 15 Feb 2006 19:08:00 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello Linux Hackers!

I have a Acer TM 4002 (WLMI) Notebook running kernel 2.6.15 here and 
some ACPI issues with it:

* No battery ist detected (Problem is known and has been discussed [1]). 
I hope that the EC driver will be included soon. I agree to Len Brown 
[2] that patching of the DSDT is not a good solution. By the way: the 
real problem is in my opinion that linux' (probably) correct 
implementation of the ACPI standard has to be weakened because of 
Microsoft's bad implementation of that standard, but correcting the DSDT 
is nothing a end-user should have to do.

* The only sleep state supported is mem (/sys/power/state), which would 
be sufficient for me if it would work. The problem is, that the system 
freezes doing 'cat "mem" > /sys/power/state'. The system has to be 
switched off (5 sec press of power button) and on to be useable again. I 
have currently no idea on how to log the messages shortly before the 
system goes to sleep.

I published the (hopefully) most important data at:
dmesg [3]
dmidecode [4]
acpidump [5]
lspci -v [6]

Of course i will provide more information if required.

Is there any hope in getting acpi on this notebook to work?

TIA for any hints!

Andreas


[1] http://marc.theaimsgroup.com/?l=linux-acpi&m=113838876302575&w=2
[2] http://marc.theaimsgroup.com/?l=linux-acpi&m=113830751005957&w=2
[3] http://andreasjuch.mywol.org/files/acpi/dmesg
[4] http://andreasjuch.mywol.org/files/acpi/dmidecode
[5] http://andreasjuch.mywol.org/files/acpi/acpidump
[6] http://andreasjuch.mywol.org/files/acpi/lspci
