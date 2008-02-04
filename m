From: Roel Kluin <12o3l@tiscali.nl>
Subject: [drivers/misc/thinkpad_acpi.c] duplicate test if (level & TP_EC_FAN_FULLSPEED)
Date: Mon, 04 Feb 2008 23:07:55 +0100
Message-ID: <47A78CBB.2090401@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:59201 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYBDWIB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2008 17:08:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, ibm-acpi@hmh.eng.br
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

in drivers/misc/thinkpad_acpi.c: 4137-4142 it reads:

                /* safety net should the EC not support AUTO
                 * or FULLSPEED mode bits and just ignore them */
                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 7;     /* safety min speed 7 */
                else if (level & TP_EC_FAN_FULLSPEED)
                        level |= 4;     /* safety min speed 4 */

Note the duplicate test 'if (level & TP_EC_FAN_FULLSPEED)'. should
this be replaced by

                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 7;     /* safety min speed 7 */
                else
                        level |= 4;     /* safety min speed 4 */

or 

                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 7;     /* safety min speed 7 */
                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 4;     /* safety min speed 4 */

?
