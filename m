From: Danny Baumann <dannybaumann@web.de>
Subject: Brightness buttons broken on Toshiba Satellite Proc A100 in kernel 2.6.23 (Fedora8)
Date: Tue, 16 Oct 2007 12:49:17 +0000 (UTC)
Message-ID: <loom.20071016T122903-517@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:59981 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932507AbXJPOQ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 10:16:29 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IhmeQ-0001Lj-Sa
	for linux-acpi@vger.kernel.org; Tue, 16 Oct 2007 13:40:02 +0000
Received: from 154.250.80.212.static.versanetonline.de ([212.80.250.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Oct 2007 13:40:02 +0000
Received: from dannybaumann by 154.250.80.212.static.versanetonline.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Oct 2007 13:40:02 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

after upgrading to Fedora 8 which brought kernel 2.6.23 with it I can no longer
use the brightness buttons (Fn+F6/F7) on my above mentioned laptop. Pressing
them generates F6 and F7 key events instead of ACPI events. This used to work
fine in Fedora 7's 2.6.22.9 kernel.

Is there anything I can do to debug this? Writing a value to
/proc/acpi/video/VGA/LCD/brightness still works fine, so it's just a matter of
the key mapping.
I would try to debug this myself, if I just knew where to look at; so any
pointers in this direction would be appreciated, too.

Thanks,

Danny

