From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH 0/2] acpi: document sysfs interfaces
Date: Wed, 7 Feb 2018 18:46:50 +0530
Message-ID: <cover.1518009225.git.aishpant@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42759 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeBGNQ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2018 08:16:58 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Patchset contains documentation for two acpi drivers- dock and dptf. Description
was collected from git history and reading through code. This might be useful
for tracking changes in the ABI.

Aishwarya Pant (2):
  acpi/dptf: document sysfs atttributes
  acpi/dock: document sysfs interface

 .../ABI/testing/sysfs-devices-platform-dock        | 38 ++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-platform-dptf      | 30 +++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

-- 
2.16.1

