From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: FW: linux kernel ACPI thermal trip_points
Date: Tue, 21 Mar 2006 12:48:42 +0300
Message-ID: <E124AAE027DA384D8B919F93E4D8C7080175E40F@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59056 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932379AbWCUJs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Mar 2006 04:48:58 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: adsmith@math.duke.edu
Cc: linux-acpi@vger.kernel.org

Hello, Abraham.

It is possible, that the trip points are being reset by BIOS on thermal
events. To make sure, please, send the output of acpidump and dmesg
commands. 'acpidump' available in pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

You can use linux-acpi@vger.kernel.org mailing list or open a new entry
in bugzilla.kernel.org under ACPI/Power-Thermal component.


Regards.
Konstantin.

-----Original Message-----
From: adsmith@math.duke.edu [mailto:adsmith@math.duke.edu] 
Sent: Saturday, March 18, 2006 7:03 AM
To: Grover, Andrew; paul.s.diefenbaugh@intel.co
Cc: Abraham David Smith
Subject: linux kernel ACPI thermal trip_points

I have a question about the acpi thermal_zone driver as it appears in
the 2.6.15 kernel series.

Naturally, I've already search the web and various forums before
emailing the driver authors,

On my laptop (a Sharp Actius PC-UM32W), the following occurs:

The default trip_points are 

hedwig THRM # cat trip_points 
critical (S5):           95 C
passive:                 85 C: tc1=1 tc2=5 tsp=30 devices=0xcf6c2448 
active[0]:               70 C: devices=0xcf6c3708 
active[1]:               63 C: devices=0xcf6c3948 
active[2]:               55 C: devices=0xcf6c3b88 


Then, I reset them as follows

hedwig THRM # echo -n "75:0:30:45:40:35" > trip_points
hedwig THRM # cat trip_points 
critical (S5):           75 C
passive:                 30 C: tc1=1 tc2=5 tsp=30 devices=0xcf6c2448 
active[0]:               45 C: devices=0xcf6c3708 
active[1]:               40 C: devices=0xcf6c3948 
active[2]:               35 C: devices=0xcf6c3b88 

However, the new trip points are ignored, and once the temp rises or
falls across one of the *original* trip points, they are then shown as
at first:

hedwig THRM # cat trip_points 
critical (S5):           95 C
passive:                 85 C: tc1=1 tc2=5 tsp=30 devices=0xcf6c2448 
active[0]:               70 C: devices=0xcf6c3708 
active[1]:               63 C: devices=0xcf6c3948 
active[2]:               55 C: devices=0xcf6c3b88 


(The only relevant daemon running is acpid-1.0.4, and it is merely
printing behaviour to the system logs.)

Do you have any suggestions as to how to override this behavior or
otherwise force lower trip-points?

Thanks,
Abe Smith




-- 
# Abraham David Smith,  <adsmith@math.duke.edu> #
# http://fds.duke.edu/db/aas/math/grad/adsmith  #
# Please enable PGP or GnuPG for email privacy! #
# Mathematics Graduate Student, Duke University #
