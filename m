From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Regression on ibm-acpi bay support on the sf.net releases
Date: Wed, 7 Feb 2007 12:10:41 -0200
Message-ID: <20070207141041.GA19140@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56696 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161323AbXBGOK5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 09:10:57 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ibm-acpi-devel@lists.sourceforge.net, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

I have just noticed that the T60p bay suport patch uncovered a bad design
bug in the ibm-acpi bay handling, that causes a regression (ibm-acpi bay
support will not work on the T43 and many others).  It will work on the
t60p, though :-p

The workaround is to revert that patch.  I am working on a proper fix, but
it may take a few days as I need to change the way bay_init() works
completely.  As a bonus, the bay_init rework will probably fix the
long-standing bug of bay support not finding the bay when the machine boots
with a battery in the bay.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
