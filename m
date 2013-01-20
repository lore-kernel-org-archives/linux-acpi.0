From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] ACPI / PM: Export power resources information to user space
Date: Sun, 20 Jan 2013 15:51:40 +0100
Message-ID: <3307415.pdOY6ovZLa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Greg,

The following patch series is about exporting ACPI power resources to user
space that will be necessary for PM diagnostics on new platforms (powertop is
the target).  Still, existing systems can also benefit from that, like my
oldish HP nx6325 on which the patches have been tested.

Patch [1/3] shouldn't be really controverisal, as it only makes it possible
to read power resources' reference counters from user space in a quite
straightforward way.

Patch [3/3], however, exposes lists of power resources associated with
different power states of devices using ACPI PM as sysfs subdirectories
containing symbolic links and that requires some sysfs changes made by
patch [2/3].

Admittedly, my sysfs skills are limited so please let me know if those
changes make sense and are acceptable from your perspective.  If not, then
please kindly advise what I can do instead of them.

The patches apply on top of the current linux-next branch of the linux-pm.git
tree.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
