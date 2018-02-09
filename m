From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / EC: Restore polling during noirq suspend/resume phases
Date: Fri, 09 Feb 2018 22:55:28 +0100
Message-ID: <253041544.iXyCOY0zib@aspire.rjw.lan>
References: <bug-197863-190391@https.bugzilla.kernel.org/> <874lmw33fe.fsf@miraculix.mork.no> <fe58e542-81c6-9c44-8930-7d91120e80cb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:43488 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbeBIV5O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2018 16:57:14 -0500
In-Reply-To: <fe58e542-81c6-9c44-8930-7d91120e80cb@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Markus Demleitner <m@tfiu.de>, Andreas Lindhe <andreas@lindhe.io>, Gjorgji Jankovski <j.gjorgji@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>, Fernando Chaves <nanochaves@gmail.com>, Tomislav Ivek <tomislav.ivek@gmail.com>, "Denis P." <theoriginal.skullburner@gmail.com>, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 662591461c4b (ACPI / EC: Drop EC noirq hooks to fix a
regression) modified the ACPI EC driver so that it doesn't switch
over to busy polling mode during noirq stages of system suspend and
resume in an attempt to fix an issue resulting from that behavior.

However, that modification introduced a system resume regression on
Thinkpad X240, so make the EC driver switch over to the polling mode
during noirq stages of system suspend and resume again, which
effectively reverts the problematic commit.

Fixes: 662591461c4b (ACPI / EC: Drop EC noirq hooks to fix a regression)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=197863
Reported-by: Markus Demleitner <m@tfiu.de>
Tested-by: Markus Demleitner <m@tfiu.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1927,6 +1927,9 @@ static int acpi_ec_suspend_noirq(struct
 	    ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
 
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_enter_noirq(ec);
+
 	return 0;
 }
 
@@ -1934,6 +1937,9 @@ static int acpi_ec_resume_noirq(struct d
 {
 	struct acpi_ec *ec = acpi_driver_data(to_acpi_device(dev));
 
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_leave_noirq(ec);
+
 	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 	    ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);


