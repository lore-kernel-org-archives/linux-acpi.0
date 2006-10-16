From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: powernow-k8 and thermal / voltage data
Date: Mon, 16 Oct 2006 06:50:02 -0700
Message-ID: <1161006602.17644.273439231@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36238 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750766AbWJPNuE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Oct 2006 09:50:04 -0400
Received: from db2.internal (db2.internal [10.202.2.12])
	by frontend1.messagingengine.com (Postfix) with ESMTP id E778ADB3038
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2006 09:50:02 -0400 (EDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
    I have several servers with Opteron processors running RHEL v4. 
    I've successfully gotten CPU frequency scaling working (which I
    tested by looking at the cpu frequency before and during running a
    CPU intensive task).  However, there are currently 2 issues:

    1) cat /proc/acpi/thermal_zone/* is empty (there's nothing under the
    thermal_zone directory)

    2) I get the impression that the voltage doesn't change even though
    the CPU frequency changes.  Is there any way to check for this? 
    Thanks.

Thanks for your help.
-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - One of many happy users:
  http://www.fastmail.fm/docs/quotes.html

