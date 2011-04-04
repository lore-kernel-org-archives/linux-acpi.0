From: Mattia Dongili <malattia@linux.it>
Subject: sony-laptop: fix early NULL pointer dereference
Date: Tue, 5 Apr 2011 08:44:49 +0900
Message-ID: <20110404234448.GA24957@kamineko.org>
References: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com>
 <20110401172241.GA26851@srcf.ucam.org>
 <BANLkTikPjwowBge82viT+Ma5UnP0fA-pew@mail.gmail.com>
 <20110402100043.GA5890@kamineko.org>
 <BANLkTikVGWM3T1y2XvwkHB+Yub5EhG1RPA@mail.gmail.com>
 <20110402155549.GA6724@kamineko.org>
 <BANLkTimJa3CSWouTMJD5V0ZuMa67YXy88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37659 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab1DDXo6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2011 19:44:58 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimJa3CSWouTMJD5V0ZuMa67YXy88Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, anssi.hannula@iki.fi, linux-acpi@vger.kernel.org, axel.lin@gmail.com, trenn@suse.de, len.brown@intel.com, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>

Author: Mattia Dongili <malattia@linux.it>
Date:   Fri Apr 1 10:01:41 2011 +0900

    sony-laptop: fix early NULL pointer dereference
    
    The SNC acpi driver could get early notifications before it fully
    initializes and that could lead to dereferencing the sony_nc_handles
    structure pointer that is still NULL at that stage.
    Make sure we return early from the handle lookup function in these
    cases.
    
    Signed-off-by: Mattia Dongili <malattia@linux.it>
---

Hi Matthew,
if it's not too late, can you pick this one up instead of the previous
one (89ec2feafaedd759e53346d641f60863a14cfb9e)?
If it's too late I'll try and do a round of return value fixes later.

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index b2ce172..de79c18 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -810,6 +810,11 @@ static int sony_nc_handles_cleanup(struct platform_device *pd)
 static int sony_find_snc_handle(int handle)
 {
 	int i;
+
+	/* not initialized yet, return early */
+	if (!handles)
+		return -EINVAL;
+
 	for (i = 0; i < 0x10; i++) {
 		if (handles->cap[i] == handle) {
 			dprintk("found handle 0x%.4x (offset: 0x%.2x)\n",
-- 
mattia
:wq!
