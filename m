From: "Jedrzej Solecki" <jedrek.s@gmail.com>
Subject: Fujitsu notebook hotkeys
Date: Fri, 28 Sep 2007 19:32:56 +0200
Message-ID: <233f28a50709281032y37607d0byb4a9071ca0f28973@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:46937 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbXI1RdQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Sep 2007 13:33:16 -0400
Received: by el-out-1112.google.com with SMTP id v27so672714ele
        for <linux-acpi@vger.kernel.org>; Fri, 28 Sep 2007 10:33:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,
I have an E8110 Fujitsu-Siemens notebook. There are some hotkeys which
I'd like to use. You can see them on this picture
http://www.notebookreview.com/assets/8795.jpg .
When I press the first one I get the following debug info:
evmisc-0143 [00] ev_queue_notify_reques: Dispatching Notify(80) on node df60ed88
evmisc-0151 [00] ev_queue_notify_reques: Notify value: 0x80 **Device Specific**
evmisc-0222 [00] ev_queue_notify_reques: No notify handler for
Notify(FEXT, 80) node df60ed88
Please guide me how can I add the notify handler. If you  need more
debug info, ACPI tables or something else please let me know.
Cheers
J.S.
