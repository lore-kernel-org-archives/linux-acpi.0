From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [RFC] EC registers - Adding sysfs interface?
Date: Tue, 13 Nov 2007 17:24:31 +0000
Message-ID: <200711131724.31868.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:56147 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbXKMRZD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 12:25:03 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org

Alexey,

I'm considering writing a sysfs interface for the EC registers, and was 
wondering if you would be ok with such a patch (before I start work on it)?

I'd like to expose the registers to userspace, as it is already possible to 
access the EC registers in userspace via /dev/ports (and quite a few of us 
would like to access them) - however, the problem with doing this is that 
ACPI throws quite a few warnings/ errors in dmesg whilst doing this; it would 
therefore be far preferable to expose the registers through sysfs, which 
would in turn be based on the ec_{read,write} calls, so we don't end up 
stepping on ACPI's toes.

So, basically, I'm proposing something like:

/sys/firmware/acpi/ec/ecX
|
|-> 0
|-> 1
|-> 2
|-> etc... (up to 255)

Where each file returns the contents of the EC register in question (via 
ec_read()), and writing to the file calls ec_write().

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
