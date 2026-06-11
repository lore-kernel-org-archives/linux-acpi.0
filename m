Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272847CC9B;
	Thu, 11 Jun 2026 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210150; cv=none; b=SoWPHgpkRlcHktBkZ2LfpLjHtup/cgAe2Q5pGAiPzu/cT30mAaxJwD7y3+/1WBxAhCMTWAyhuxBSgpHo/JGlIOcB0GM4dG5spDYgwQV7uvyIlESBanFxm4KcvHNKWZzKc+H/1r2TpSSRs/B9j1I0F3+NlJ1SS4OS3RjNySb5NWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210150; c=relaxed/simple;
	bh=f4dfwOVe/IPX9UmzalevLBZHEmKjqRmHsZGnkjby5TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHoB50XYEDpoqOViqmZ6+pW/7Q58KeLK2GquyehvfT1GNR9Hgtpdw+786krlDkoVkY4sPmyvH+P0L1B95ERnVDYQ6jSLus8jafLHnUGiEOFbgTGkLDgZI8CIKm/vLHmxmjE+iwMHRakFd7So9BtTx1xZdqfSOeMNjc3mX6pUjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EybznAiN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EybznAiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781210148; x=1812746148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f4dfwOVe/IPX9UmzalevLBZHEmKjqRmHsZGnkjby5TY=;
  b=EybznAiNs9LWFUoSLM73b01vhowoWtjiizVyXv34mA8jpgMy8Jsun8ZI
   /QmP6+HTvrpvDuXMMxHkx9utqOcl4iKVpWKqkgoQqaGD49Y2BwObok7Vb
   karQNVGWNiJKNM5KOrsYFxpGQu5E5yv4HfAK2LgLxixRpAXThivNeLfps
   ekgi6lkTrqWClksydBtOIwSBfnz60neVNhGDV5q3ECJhJnZL2Ik/3xuse
   kOp4QyrJ8sm7OqS0gW3kobicFr9N5NzIr8itzmJRJG7CG+bnJH0Jhe61f
   eLFDG10YHmQosBAXn98FscydWfvTMjdAd45D40CkR/9aL5DsSVzOfd3L+
   Q==;
X-CSE-ConnectionGUID: eipcjib2TjmRGpMowv9VPA==
X-CSE-MsgGUID: F6g9aZdPSV2UNRiY8IJScQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99456611"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99456611"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:35:46 -0700
X-CSE-ConnectionGUID: oa5sI2tAQuGXyuvgqF8s+g==
X-CSE-MsgGUID: yXEpydJaSwmJcJbWrfBvyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="270631218"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jun 2026 13:35:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D19749B; Thu, 11 Jun 2026 22:35:42 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 3/3] device property: add test cases for fwnode_for_each_child_node()
Date: Thu, 11 Jun 2026 22:31:08 +0200
Message-ID: <20260611203537.1786399-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

Add test cases for fwnode_for_each_child_node() API.

Test command:
$ ./tools/testing/kunit/kunit.py run property-entry

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/test/Kconfig               |   1 +
 drivers/base/test/property-entry-test.c | 136 ++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 2756870615cc..95fc42e91564 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -17,4 +17,5 @@ config DM_KUNIT_TEST
 config DRIVER_PE_KUNIT_TEST
 	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	select OF
 	default KUNIT_ALL_TESTS
diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index a8657eb06f94..a3d1caf28cc7 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -4,6 +4,8 @@
 // Copyright 2019 Google LLC.
 
 #include <kunit/test.h>
+
+#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/types.h>
 
@@ -489,6 +491,139 @@ static void pe_test_reference(struct kunit *test)
 	software_node_unregister_node_group(group);
 }
 
+static struct fwnode_handle *create_device_node(struct kunit *test,
+						const char *name,
+						const char *full_name,
+						struct device_node *parent)
+{
+	struct device_node *node;
+
+	node = kunit_kzalloc(test, sizeof(*node), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	node->name = kunit_kstrdup(test, name, GFP_KERNEL);
+	node->full_name = kunit_kstrdup(test, full_name, GFP_KERNEL);
+
+	if (parent) {
+		node->sibling = parent->child;
+		/* set the node as the first child of the parent */
+		parent->child = node;
+		node->parent = parent;
+	}
+
+	of_node_init(node);
+	return of_fwnode_handle(node);
+}
+
+/* Verifies that fwnode_for_each_child_node() can output correct children */
+static void pe_test_child_iteration(struct kunit *test)
+{
+	struct fwnode_handle *of_node, *of_node1;
+	struct fwnode_handle *sw_node, *sw_node1;
+	struct fwnode_handle *child;
+	int error, i, num;
+
+	static const struct software_node node = { .name = "sw" };
+	static const struct software_node node1 = { .name = "sw-1", .parent = &node};
+	static const struct software_node node2 = { .name = "sw-2", .parent = &node};
+	static const struct software_node node3 = { .name = "sw-3", .parent = &node};
+	static const struct software_node *group[] = { &node, &node1, &node2, &node3, NULL };
+
+	static const char * const of_child_array[] = { "of-1", "of-2", "of-3" };
+	static const char * const sw_child_array[] = { "sw-1", "sw-2", "sw-3" };
+	static const char * const of_sw_child_array[] = { "of-1", "of-2", "of-3",
+							  "sw-1", "sw-2", "sw-3" };
+	static const char * const sw_of_child_array[] = { "sw-1", "sw-2", "sw-3",
+							  "of-1", "of-2", "of-3" };
+
+	/* 1. Test OF node child iteration */
+
+	of_node = create_device_node(test, "of", "of", NULL);
+	create_device_node(test, "of", "of-3", to_of_node(of_node));
+	create_device_node(test, "of", "of-2", to_of_node(of_node));
+	of_node1 = create_device_node(test, "of", "of-1", to_of_node(of_node));
+
+	i = 0;
+	num = ARRAY_SIZE(of_child_array);
+	fwnode_for_each_child_node(of_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, of_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	/* 2. Test SW node child iteration */
+
+	error = software_node_register_node_group(group);
+	KUNIT_ASSERT_EQ(test, error, 0);
+
+	sw_node = software_node_fwnode(&node);
+
+	i = 0;
+	num = ARRAY_SIZE(sw_child_array);
+	fwnode_for_each_child_node(sw_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, sw_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	/* 3. Test OF (primary) + SW (secondary) node child iteration */
+
+	of_node->secondary = sw_node;
+	sw_node->secondary = ERR_PTR(-ENODEV);
+
+	i = 0;
+	num = ARRAY_SIZE(of_sw_child_array);
+	fwnode_for_each_child_node(of_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, of_sw_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	/* 4. Test SW (primary) + OF (secondary) node child iteration */
+
+	sw_node->secondary = of_node;
+	of_node->secondary = ERR_PTR(-ENODEV);
+
+	i = 0;
+	num = ARRAY_SIZE(sw_of_child_array);
+	fwnode_for_each_child_node(sw_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, sw_of_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	/* 5. Test OF (primary) + SW (secondary, but no children) node child iteration */
+
+	sw_node1 = software_node_fwnode(&node1);
+	of_node->secondary = sw_node1;
+	sw_node->secondary = ERR_PTR(-ENODEV);
+
+	i = 0;
+	num = ARRAY_SIZE(of_child_array);
+	fwnode_for_each_child_node(of_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, of_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	/* 6. Test SW (primary) + OF (secondary, but no children) node child iteration */
+
+	sw_node->secondary = of_node1;
+	of_node->secondary = ERR_PTR(-ENODEV);
+
+	i = 0;
+	num = ARRAY_SIZE(sw_child_array);
+	fwnode_for_each_child_node(sw_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, sw_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	of_node->secondary = NULL;
+	sw_node->secondary = NULL;
+	software_node_unregister_node_group(group);
+}
+
 static struct kunit_case property_entry_test_cases[] = {
 	KUNIT_CASE(pe_test_uints),
 	KUNIT_CASE(pe_test_uint_arrays),
@@ -497,6 +632,7 @@ static struct kunit_case property_entry_test_cases[] = {
 	KUNIT_CASE(pe_test_move_inline_u8),
 	KUNIT_CASE(pe_test_move_inline_str),
 	KUNIT_CASE(pe_test_reference),
+	KUNIT_CASE(pe_test_child_iteration),
 	{ }
 };
 
-- 
2.50.1

