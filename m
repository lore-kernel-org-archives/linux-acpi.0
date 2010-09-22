From: Marc Ferland <marc.ferland@gmail.com>
Subject: sysfs interface not updating when inserting/removing new battery
Date: Wed, 22 Sep 2010 10:37:32 -0400
Message-ID: <AANLkTi=JyFAbwzb3jBqEJ9=WnTFDQqE8Ay1pfSNBd7c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33547 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0IVOhc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Sep 2010 10:37:32 -0400
Received: by pvg2 with SMTP id 2so139612pvg.19
        for <linux-acpi@vger.kernel.org>; Wed, 22 Sep 2010 07:37:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm currently running Linux 2.6.35.4 on a COMexpress module made by
Kontron. I am having problems getting events about newly
inserted/removed batteries on the sysfs interface. The module has 2
battery slots and one AC/DC adapter (which are correctly detected by
the kernel at boot time).

Everything is correctly detected at boot time, problems appear when
removing or inserting a battery in one of the two slots once the
system is up and running.

First, if I remove a battery that was present at boot time, it's sysfs
interface isn't removed (it stays there with the last info that was
read from the battery) and second, if I add a new battery it's sysfs
interface is not created.

I also noticed that reading the battery state from procfs
(/proc/acpi/battery/BAT[12]/state) seems to trigger the update of both
the procfs and sysfs interface. So previously undetected batteries now
appear in sysfs and absent batteries are removed.

So, is there a way to update the batteries sysfs interface without
having someone poking at procfs all the time?

Regards,

Marc
