From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [drivers/misc/thinkpad_acpi.c] duplicate test if (level & TP_EC_FAN_FULLSPEED)
Date: Mon, 04 Feb 2008 14:13:09 -0800
Message-ID: <ada8x20gykq.fsf@cisco.com>
References: <47A78CBB.2090401@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:54933 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbYBDWNN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2008 17:13:13 -0500
In-Reply-To: <47A78CBB.2090401@tiscali.nl> (Roel Kluin's message of "Mon, 04 Feb 2008 23:07:55 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: len.brown@intel.com, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

 >                 /* safety net should the EC not support AUTO
 >                  * or FULLSPEED mode bits and just ignore them */
 >                 if (level & TP_EC_FAN_FULLSPEED)
 >                         level |= 7;     /* safety min speed 7 */
 >                 else if (level & TP_EC_FAN_FULLSPEED)
 >                         level |= 4;     /* safety min speed 4 */
 > 
 > Note the duplicate test 'if (level & TP_EC_FAN_FULLSPEED)'. should
 > this be replaced by

Actually I suspect one of the two tests should be against TP_EC_FAN_AUTO
(based on the comment).
