From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Fujitsu notebook hotkeys
Date: Sat, 29 Sep 2007 09:17:27 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DEC3D1A2@pdsmsx414.ccr.corp.intel.com>
References: <233f28a50709281032y37607d0byb4a9071ca0f28973@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3817 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756259AbXI2BRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Sep 2007 21:17:34 -0400
Content-class: urn:content-classes:message
In-Reply-To: <233f28a50709281032y37607d0byb4a9071ca0f28973@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jedrzej Solecki <jedrek.s@gmail.com>, linux-acpi@vger.kernel.org

Hi, Jedrzej,

Please attach the acpidump and dmesg output.:).
The latest acpidump tools can be found at:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Thanks,
Rui

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Jedrzej Solecki
Sent: Saturday, September 29, 2007 1:33 AM
To: linux-acpi@vger.kernel.org
Subject: Fujitsu notebook hotkeys

Hello,
I have an E8110 Fujitsu-Siemens notebook. There are some hotkeys which
I'd like to use. You can see them on this picture
http://www.notebookreview.com/assets/8795.jpg .
When I press the first one I get the following debug info:
evmisc-0143 [00] ev_queue_notify_reques: Dispatching Notify(80) on node
df60ed88
evmisc-0151 [00] ev_queue_notify_reques: Notify value: 0x80 **Device
Specific**
evmisc-0222 [00] ev_queue_notify_reques: No notify handler for
Notify(FEXT, 80) node df60ed88
Please guide me how can I add the notify handler. If you  need more
debug info, ACPI tables or something else please let me know.
Cheers
J.S.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
