From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: Preventing ACPI from Damaging Your CPU
Date: Thu, 12 Oct 2006 07:26:00 -0700
Message-ID: <1160663160.13196.273175261@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:21950 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1422688AbWJLOZ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 10:25:59 -0400
Received: from db2.internal (db2.internal [10.202.2.12])
	by frontend1.messagingengine.com (Postfix) with ESMTP id ED3B8DB2E33
	for <linux-acpi@vger.kernel.org>; Thu, 12 Oct 2006 10:25:57 -0400 (EDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
  I've been reading an alarming article on getting Gentoo to work on the
  HP Compaq nx6325
  (http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325) and the
  serious ACPI problems that were encountered.  The author states after
  mentioning how to apply certain patches, "Without that, the CPU might
  overheat and get damaged during heavy load (such as compiling a Gentoo
  stage ...)!"

  What would be the safest way to ensure that ACPI doesn't do this to
  your machine / laptop without disabling ACPI?  Would recompiling the
  DSDT using the Intel compiler and re-inserting it be enough to ensure
  that ACPI doesn't cause your CPU to overheat or get damaged?  Thanks
  for your help.
-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service

