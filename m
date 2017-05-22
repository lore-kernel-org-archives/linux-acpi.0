From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5 0/3] Preparation for further fwnode property cleanup
Date: Mon, 22 May 2017 11:11:35 +0300
Message-ID: <1495440698-22260-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Rob, Frank, others,

Here's the 4th version of what used to be a single patch to prepare for
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
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
