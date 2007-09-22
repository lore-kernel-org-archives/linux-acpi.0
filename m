From: Geoffrey Opland <go81816@yahoo.com>
Subject: dmidecode and bios bug
Date: Sat, 22 Sep 2007 06:48:29 -0700 (PDT)
Message-ID: <717147.68391.qm@web52404.mail.re2.yahoo.com>
Reply-To: go81816@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web52404.mail.re2.yahoo.com ([206.190.48.167]:44944 "HELO
	web52404.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751330AbXIVNsa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Sep 2007 09:48:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On boot of my Compaq Presario C571NR running LFS with kernel 2.6.22.1 I
receive the following messages:

Sep 22 08:38:07 localhost kernel: ACPI: BIOS bug: multiple APIC/MADT
found, using 0
Sep 22 08:38:07 localhost kernel: ACPI: If "acpi_apic_instance=2" works
better, notify linux-acpi@vger.kernel.org
  << and >>
Sep 22 08:38:07 localhost kernel: ACPI: System BIOS is requesting
_OSI(Linux)
Sep 22 08:38:07 localhost kernel: ACPI: Please test with "acpi_osi=!Linux"
Sep 22 08:38:07 localhost kernel: Please send dmidecode to
linux-acpi@vger.kernel.org

I see no obvious usability differences with acpi_apic_instance=2, is there
something specific I can check for?  I do have intermittent suspend
problems, but I'm not sure this flag has any effect on suspend code.

Also, attached is the dmidecode output as requested.




       
____________________________________________________________________________________
Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC
