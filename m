From: Garry Williams <gtwilliams@gmail.com>
Subject: ACPI-0412: *** Error: Handler for [EmbeddedControl] returned
	AE_TIME
Date: Fri, 10 Feb 2006 18:05:42 -0500
Message-ID: <1139612742.3209.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:40395 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932234AbWBJXF7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Feb 2006 18:05:59 -0500
Received: by wproxy.gmail.com with SMTP id 69so36854wri
        for <linux-acpi@vger.kernel.org>; Fri, 10 Feb 2006 15:05:59 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have a Sony Vaio FS640/W running Fedora Core 4, kernel
2.6.15-1.1830_FC4.  Waking after suspend to memory produces these
messages:

        kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
        kernel:     ACPI-0508: *** Error: Method execution failed [\_WAK] (Node c18d66a0), AE_TIME
        kernel:     ACPI-0550: *** Error: Method _WAK failed, AE_TIME

The only other symptom I see is NetworkManager "loses" my Ethernet port
(eth0).  The interface comes back after /etc/init.d/network restart, but
the nm-applet cannot "see" eth0 any more.

Should I be doing something special before (and after) suspending?

-- 
Garry Williams -- +1 (678) 656-4579

