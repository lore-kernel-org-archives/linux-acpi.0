From: Markus Feldmann <feldmann_markus@gmx.de>
Subject: kacpid and acpid
Date: Wed, 30 Apr 2008 15:59:28 +0200
Message-ID: <48187B40.4090003@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42805 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754173AbYD3N7d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 09:59:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi All,

my Problem is that i can not install "acpid" and "acpi-support"
correctly, because another Process "kacpid" have got Access to
/proc/acpi/event

My System:
  Debian Lenny 32bit with Kernel 2.6.25 from kernel.org
  AMD Turion64 X2 Mobile

acpid is used for my Laptop to get my Buttons for Wireless and Sound
Volume to work, as i think.

I do not know anything about "kacpid", but i think this is a Kernel
Process.

Any Idea ?

Regards Markus


