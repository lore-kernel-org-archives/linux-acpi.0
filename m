From: Markus Feldmann <feldmann_markus@gmx.de>
Subject: kacpid and acpid
Date: Wed, 30 Apr 2008 15:54:05 +0200
Message-ID: <fv9tlv$2v0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43676 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbYD3OFF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 10:05:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JrCve-00032H-Ip
	for linux-acpi@vger.kernel.org; Wed, 30 Apr 2008 14:05:02 +0000
Received: from dslb-082-083-022-069.pools.arcor-ip.net ([82.83.22.69])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 30 Apr 2008 14:05:02 +0000
Received: from feldmann_markus by dslb-082-083-022-069.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 30 Apr 2008 14:05:02 +0000
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

