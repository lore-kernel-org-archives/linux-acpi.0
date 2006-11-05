From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: SMP C-states on x86_64 Status
Date: Sun, 05 Nov 2006 03:37:52 -0800
Message-ID: <1162726672.25981.275035845@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:65198 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932664AbWKELhw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Nov 2006 06:37:52 -0500
Received: from db2.internal (db2.internal [10.202.2.12])
	by frontend1.messagingengine.com (Postfix) with ESMTP id EE109DC1370
	for <linux-acpi@vger.kernel.org>; Sun,  5 Nov 2006 06:37:50 -0500 (EST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
  I just saw Adrian's post on a patch to add SMP C-states on x86_64 to
  kernel 2.6.16.  Is there anywhere I can find the current status of
  C-states on SMP machines?  I have a 16-core machine running RHEL with
  kernel 2.6.9-34 and it shows only C0, nothing else.  I checked the
  DSDT and it compiled without error.  Any ideas?  Thanks for your help.
-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - I mean, what is it about a decent email service?

