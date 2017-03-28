From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 0/3] Fwnode property API fixes for OF, pset and ACPI
Date: Tue, 28 Mar 2017 15:22:16 +0300
Message-ID: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19711 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbdC1MWu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 08:22:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Hi folks,

Here are three patches that fix a few issues in the fwnode property API
implementation. They were formerly a part of a larger patchset "Move
firmware specific code to firmware specific locations" here:

<URL:http://www.spinics.net/lists/linux-acpi/msg72174.html>

The v1 (previous version) of the set is also available here:

<URL:http://www.spinics.net/lists/linux-acpi/msg72327.html>

These patches apply cleanly on v4.11-rc1 and linux-next with or without
the ACPI graph support patchset I've sent a moment ago.

changes since v1.1:

- Move fixes to fwnode_property_read_string_array() return value fixes to
  respective implementations of those functions, rather than working
  around them in the fwnode property interface functions.

- fwnode_property_read_string_array() now may return fewer strings than
  requested also on ACPI in order to make behaviour of
  fwnode_property_read_string_array() fully consistent.

changes since v1:

- Make prop const. pset_prop_get() returns const struct property_entry *
  now in __fwnode_property_read_string_array().

- Make fwnode_property_read_string_array() behave as
  of_property_read_string_array() does in terms of the return value.

Sakari Ailus (3):
  device property: fwnode_property_read_string_array() may return
    -EILSEQ
  device property: Fix reading pset strings using array access functions
  device property: fwnode_property_read_string_array() returns nr of
    strings

 drivers/acpi/property.c | 22 +++++++++++++++++-----
 drivers/base/property.c | 46 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 49 insertions(+), 19 deletions(-)

-- 
Kind regards,
Sakari
