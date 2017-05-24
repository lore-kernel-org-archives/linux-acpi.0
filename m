From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 0/3] Preparation for further fwnode property cleanup
Date: Wed, 24 May 2017 17:53:52 +0300
Message-ID: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16943 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967030AbdEXO4A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 May 2017 10:56:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, kieran.bingham@ideasonboard.com

Hi Rob, Frank, others,

Here's the 6th version of what used to be a single patch to prepare for
fwnode property cleanup.

Beyond this, I have a couple of other patchsets I'll post in the near
future:

- fwnode property cleanup (for linux-pm) which moves the property API 
implementation to FW specific locations; depends on these patches,

- V4L2 fwnode patches (for media_tree, no unmerged dependencies, pull
  request sent) and

- fwnode const patchset which allows making the fwnode argument for the 
  property API functions const. It depends on both of the previous sets.
  Might be for linux-pm.

since v5:

- Add "pr_fmt" macro missed when splitting base.c (1st patch).

- Add a missing newline (1st patch).

- Use parentheses around macro aguments (2nd and 3rd patch).

since v4:

- Add patch "of: Support const and non-const use for to_of_node()" to the
  set.

- Make nop is_of_node() and to_of_node() const-correct if OF is disabled.
  (since v4.1)

since v3: 

- Rebase the first patch (no conflicts),

- Add another patch for to make of_fwnode_handle() handle NULL argument 
gracefully. 

Sakari Ailus (3):
  of: Move OF property and graph API from base.c to property.c
  of: Make of_fwnode_handle() safer
  of: Support const and non-const use for to_of_node()

 drivers/of/Makefile   |   2 +-
 drivers/of/base.c     | 733 ------------------------------------------------
 drivers/of/property.c | 763 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h    |  30 +-
 4 files changed, 784 insertions(+), 744 deletions(-)
 create mode 100644 drivers/of/property.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


*** BLURB HERE ***

Sakari Ailus (3):
  of: Move OF property and graph API from base.c to property.c
  of: Make of_fwnode_handle() safer
  of: Support const and non-const use for to_of_node()

 drivers/of/Makefile   |   2 +-
 drivers/of/base.c     | 733 -----------------------------------------------
 drivers/of/property.c | 766 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h    |  30 +-
 4 files changed, 787 insertions(+), 744 deletions(-)
 create mode 100644 drivers/of/property.c

-- 
2.7.4

