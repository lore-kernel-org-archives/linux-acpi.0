From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi_os_queue_for_execution()
Date: Mon, 23 Dec 2002 19:17:48 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021223181747.GA10363@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Acpi seems to create short-lived kernel threads, and I don't quite
understand why. 

In thermal.c


                        tz->timer.data = (unsigned long) tz;
                        tz->timer.function = acpi_thermal_run;
                        tz->timer.expires = jiffies + (HZ * sleep_time) / 1000;
                        add_timer(&(tz->timer));

and acpi_thermal_run creates kernel therad that runs
acpi_thermal_check. Why is not acpi_thermal_check called directly? I
don't like idea of thread being created every time thermal zone needs
to be polled...
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
