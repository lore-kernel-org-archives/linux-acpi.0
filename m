From: Werner LEMBERG <wl@gnu.org>
Subject: ACPI and CDROM problems
Date: Tue, 27 Jun 2006 19:50:44 +0200 (CEST)
Message-ID: <20060627.195044.197345122.wl@gnu.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:8645 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932495AbWF0RwA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 13:52:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I have an inspiron 6400, using kernel 2.6.17 together with harddisk
suspend.  This laptop shows severe problems at resuming if a music CD
is in the drive.  In many cases it works fine, but sometimes[*] it
happens that the process stops after these lines have appeared on the
screen (approximately):

  sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
       Uniform CD-ROM driver Revision: 3.20
       sr 1:0:0:0: Attached scsi CD-ROM sr0

It takes about 20 seconds, then a normal reboot happens.

Either the cdrom drive has a problem with recovering, or the resume
process doesn't wait long enough before continuing.

Before sending various configuration and log data I wonder what I
shall specifically do to improve debugging so that you get meaningful
data in case it is a new problem (I searched the archive but doesn't
found something relevant).

Maybe it isn't a bug at all, and I just have to improve configuration
-- please advise.


    Werner


[*] At least 1 out of 10 tries.
