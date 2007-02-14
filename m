From: Lorincz Andras <lorandsm@yahoo.com>
Subject: Help with fan on fujitsu-siemens
Date: Wed, 14 Feb 2007 10:47:18 +0100 (CET)
Message-ID: <364867.80154.qm@web90511.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web90511.mail.mud.yahoo.com ([216.252.100.178]:41361 "HELO
	web90511.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750818AbXBNJrT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Feb 2007 04:47:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I have a fujitsu-siemens amilo l1310g laptop. The
problem is that the cpu fan doesn't start if the cpu
heats up, but I can start it manualy by these 2
commands:

echo 3 > /proc/acpi/fan/FAN0/state
echo 0 > /proc/acpi/fan/FAN0/state

in this case the fan starts but it won't ever stop
even if I launch:

echo 3 > /proc/acpi/fan/FAN0/state

I'm using kernel 2.6.18, but tried with 2.6.19 and
2.6.20-rc7 also. Any hint on how can be this fixed? Thanks.


		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
