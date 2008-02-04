From: Roel kluin <rjckluin@hotmail.com>
Subject: [PATCH][drivers/misc/thinkpad_acpi.c] duplicate test 'if (level &
 TP_EC_FAN_FULLSPEED)'
Date: Mon, 04 Feb 2008 22:59:21 +0100
Message-ID: <47A78AB9.5020901@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:58567 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbYBDW0I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2008 17:26:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ibm-acpi@hmh.eng.br, len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

in drivers/misc/thinkpad_acpi.c, lines 4137-4142 it reads:

                /* safety net should the EC not support AUTO
                 * or FULLSPEED mode bits and just ignore them */
                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 7;     /* safety min speed 7 */
                else if (level & TP_EC_FAN_FULLSPEED)
                        level |= 4;     /* safety min speed 4 */

note the nonsense duplicate test 'if (level & TP_EC_FAN_FULLSPEED)'.
should this be changed to:

                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 7;     /* safety min speed 7 */
                else
                        level |= 4;     /* safety min speed 4 */

or maybe

                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 7;     /* safety min speed 7 */
                if (level & TP_EC_FAN_FULLSPEED)
                        level |= 4;     /* safety min speed 4 */

?
