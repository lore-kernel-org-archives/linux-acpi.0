From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [patch 0/3] ibm-acpi: extend thermal sensor support for new ThinkPads with 9+ sensors
Date: Wed, 27 Sep 2006 20:53:35 -0300
Message-ID: <20060927235335.483578718@khazad-dum.debian.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:2477 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1031293AbWI1Aiq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 20:38:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, stefan@datenfreihafen.org

Hello Borislav,

This patch series extends ibm-acpi thermal support for ThinkPads that
support up to 16 sensors in firmware.  It also refactors some of the
ibm-acpi thermal sensor code to make it easier to extend and read.

The functionality in this patch has been tested by subscribers of the
linux-thinkpad mailinglist in different forms for quite a while, now.
Many users were using ecdump directly to work around the lack of 16 sensor
support in stock ibm-acpi, which is highly suboptimal and not nearly as
safe.

One of the patches in the series is already merged in -mm.  It is a patch
which has been accepted by Pavel Machek (http://lkml.org/lkml/2006/8/2/89)
and Andrew Morton, and it is in 2.6.18-mm1.  This patch is used to safely
detect a new enough EC firmware through a DMI match.  I have included it
in the series for ease of testing and merging in linux-acpi.

Please apply.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
