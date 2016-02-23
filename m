From: Andy Clayton <clayt055@umn.edu>
Subject: Dell XPS 15 9550 acpi deadlock
Date: Tue, 23 Feb 2016 16:43:52 -0600
Message-ID: <1456267433-9735-1-git-send-email-clayt055@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


Hello,

I'm seeing a blocked acpi_os_execute_deferred task on a Dell XPS 15 9550 upon thunderbolt hotplug. It seems to prevent thunderbolt from working and causes subsequent shutdown or suspend to hang. I've put together the following patch ("ACPICA: fix deadlock on recursion of entry method") that in my testing appears to fix the issue.

Thanks for looking and for any feedback. Sorry for any gaffes as this is my first kernel patch.

Andy
