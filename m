From: Julian Wollrath <jwollrath@web.de>
Subject: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Sat, 12 Jul 2014 18:06:36 +0200
Message-ID: <20140712180636.698e2e4c@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:64571 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbaGLQGk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jul 2014 12:06:40 -0400
Received: from saldaea ([84.134.38.250]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M4ZVE-1WMwFN22SS-00yfxg for
 <linux-acpi@vger.kernel.org>; Sat, 12 Jul 2014 18:06:37 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

changing the brightness on my Thinkpad X230 with Intel HD4000 graphics,
stopped working after commit 886129a8eebe (ACPI / video: change
acpi-video brightness_switch_enabled default to 0). Changing it back to
1, fixes the problem, if "acpi_osi=!Windows 2012" is also set. Before
that commit just setting "acpi_osi=!Windows 2012" was enough to get
changing the brightness working.


With best regards,
Julian Wollrath
