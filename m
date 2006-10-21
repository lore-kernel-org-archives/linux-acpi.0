From: Werner LEMBERG <wl@gnu.org>
Subject: ACPI and CDROM problems
Date: Sat, 21 Oct 2006 06:58:27 +0200 (CEST)
Message-ID: <20061021.065827.78720699.wl@gnu.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:47556 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751711AbWJUE6b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Oct 2006 00:58:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I have an inspiron 6400 (running SuSE 10.0), using kernel 2.6.18
(unmodified) together with harddisk suspend.  This laptop showed
severe problems at resuming with 2.6.17 (about 1 out of 5 resumes
failed).  Now, with 2.6.18, about 1 out of 30 doesn't work.

It takes about 20 seconds, then a normal reboot happens.

Before sending various configuration and log data I wonder what I
shall specifically do to improve debugging so that you get meaningful
data in case it is a new problem (I searched the archive but doesn't
found something relevant).  In particular, which debugging flags shall
I activate -- if I enable all of them, my `/var/log/messages' file
increases by about 100k per second...  And the default settings
doesn't show anything suspicious.


    Werner
