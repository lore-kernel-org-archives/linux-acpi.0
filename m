From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Caching the results of acpi_get_handle() in a driver: is it valid?
Date: Wed, 7 Feb 2007 17:43:52 -0200
Message-ID: <20070207194352.GB4515@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:55815 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422715AbXBGTn5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 14:43:57 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net

The code I inherited in ibm-acpi does heavy caching of acpi_get_handle()
results.  It stores the results of acpi_get_handle() for a number of nodes
at module init, and uses the stored results during its lifetime.

Is that a valid use of the handles returned by acpi_get_handle()?  In
particular, what happens to handlers when a SSDT gets loaded or unloaded at
runtime?  Do handles that came from the DSDT change?  What if the handler
was to a node in the SSDT being unloaded?  What if the handler is overriden
by a new loaded SSDT?

While the vast majority of the handlers ibm-acpi caches are in the DSDT and
very unlikely to change through a SSDT load, I'd still like to make sure the
driver is doing the right thing...

PS: not caching the results is always possible, but that will mean various
calls to acpi_get_handle() per second.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
