From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] ACPI / dock: Rework the handling of dock notifications
Date: Tue, 11 Feb 2014 01:09:32 +0100
Message-ID: <3728252.WpMGKRKmqq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

Hi All,

This is on top of the current linux-next branch of linux-pm.git.

The handling of ACPI dock notifications doesn't require a notify handler to
be installed for every dock device object.  Moreover, the namespace doesn't
have to be scanned upfront to discover those objects and the ACPI container
code should be made avoid trying to handle dock notifications (in case dock
stations have container device IDs).

The series makes the changes following from the above observations and a
couple of improvements on top of them.

[1/3] Dispatch ACPI dock notifications from the global notify handler.
[2/3] Pass ACPI device pointer to acpi_device_is_battery() (which is a new
      helper function added by [1/3]).
[3/3] Associate dock platform devices with ACPI device objects

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
