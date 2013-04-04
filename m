From: Aaron Lu <aaron.lu@intel.com>
Subject: [RFD] Let acpi video driver handle its dmi table
Date: Thu, 04 Apr 2013 19:37:37 +0800
Message-ID: <515D6601.4070509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@novell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, Seth Forshee <seth.forshee@canonical.com>, Zhang Rui <rui.zhang@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Recently I saw two bugs about acer system:
https://bugzilla.kernel.org/show_bug.cgi?id=35622
https://bugzilla.kernel.org/show_bug.cgi?id=51051
The backlight is handled by gpu driver's backlight interface, and hotkey
is handled by acpi video driver. The problem is, hotkey notification
does not function on these systems now.

The reason is, acer-wmi driver will unload acpi video driver when it
found these systems are in its video_vendor_dmi_table, which is used to
keep all the systems that are known having buggy acpi video interface
implementations.

So we have a problem here, though acpi video driver can't handle
backlight level change, it is still required to handle hotkey
notificaions, and thus unload the driver is not desired.

One way to solve this problem is, to have acpi video driver deal with
these broken systems that it can not handle by itself: not create
backlight interface while still keeping the notification handler there.
To achieve this, we need to move those systems listed in
video_vendor_dmi_table to video_detect_dmi_table, and we are done. And
any code to touch acpi video driver in acer-wmi driver can be removed,
also no need to add SELECT ACPI_VIDEO to CONFIG_ACER_WMI. The downside
is, if other platform vendor drivers all follow this rule, we will end
up with a big video_detect_dmi_table.

Another way is to add a new interface, something like
acpi_video_unregister_backlight, to let platform drivers call. And this
new interface will only unregister the backlight device acpi video
driver has already created and nothing more. So the notification handler
of acpi video driver will stay, solving the problem. The downside is,
it's kind of odd to let another module solve a problem for acpi video
module. In this case, the vendor driver's whole point is to unregister
acpi video driver's backlight interface, while it does't handle backlight
nor hotkey. So it doesn't seem to be required in this game.

Please feel free to share your opinion, which one you prefer or some new
idea perhaps.

Thanks,
Aaron
