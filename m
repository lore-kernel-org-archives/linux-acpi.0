From: Len Brown <lenb@kernel.org>
Subject: WMI vs Linux
Date: Wed, 28 Mar 2007 15:44:41 -0400
Message-ID: <200703281544.41842.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35337 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965709AbXC1TqC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 15:46:02 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jamey.hicks@hp.com, linux-acpi@vger.kernel.org

Jamey,
google stumbled across this patch:
http://www.th.ph.bham.ac.uk/staff/schofield/linux/tc1100/linux-2.6.9-tc1100-wmi.patch
with your name on it.

I was wondering if you could tell me about it.
I was just about to write a little driver that binds to PNP0C14 and tells the
user that they should not buy machines with WMI extensions and run Linux on them --
but maybe an exception to that rule already exists?

thanks,
-Len

ps. while you're at it, what is the WACF005 Wacom Digitizer device also in the patch --
I don't see that upstream either.
