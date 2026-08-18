Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDC374198
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036350; cv=none; b=gPxA46baRFzhHZTxT6WYaNxxLlykGtpZUGlnhsh9oCQ4Ig8qjRcLy5HlNbsSXuOEdoFGBLN1o0L+Fqchk1n9RTGwPq6UKsuXhUB2ynYE2IPUuUUAjrbejHFtEUyP/E5EFimYuS3wFw7JfgfUEw9bSOSE2NxrKACYrLUnf3SDPpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036350; c=relaxed/simple;
	bh=9Ej8oCWE/SEz2kwV+lumcbgilsrgrfEVoihV506X6K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7VI3L2rhFducI+iVoqgZfoHiCI/1Fkmf59jV6lSIqICbO3erPFUi4CFZ/V+oNHpuRhqw16SLDrNllspfF9f6nQDWWHl1ImbRgUOyfCsIM7CffmFF2rE0CnLCt/+qX0NaMV3kBPWzQMANtZqPmokYot0+NDAKCv76acl5WHCAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P04wK8bm; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P04wK8bm"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec58fa3e01so2205283a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2026 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036343; x=1787641143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMMgthRopw07ZlQT3zAbed2zC3TzeWq8aCthIdCEwok=;
        b=P04wK8bmKZsLcL/A2bImlg4Y9BpjRXeshGUx+xn0kdF538PSachILFeWsdZHkuaxR4
         IWsiPtaIRlrGLXOMYh6LiQTrfC6FsDw5yI5kcuEnqDgsh9RwWEKkuN8m84rKE7QK7278
         P8+ivvlkqoofHvQ6HxzSvNV9jATh8qzE9KswbkMbvZDA2wjvx86NoqNdnwFJlbWACfNV
         tNjFTmhCIe8XrczKGtEogULMfqyMLhx/4cJXV015kuDuHtLrdTEpku/VqDGO52uAjkg9
         yxS1aqvaQWi5/GnpDK8PJ11KptYKEphBNN4cx9rHcyaIrUtkODC4bOX6fYrsDrK+3fDI
         RRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036343; x=1787641143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMMgthRopw07ZlQT3zAbed2zC3TzeWq8aCthIdCEwok=;
        b=tUnvWcjXBfa9xiomA5OD7ZlEu2z4u+HsBDHzqe9uWf6CZ4V+O/DTUa/+6jYQ+rtrNL
         IuFxm2eRBZ9utv/uNwtmRxuJsHZVuwxKzc0AfIVUP4n+fGkQzGCYq+PKDe55whcA7WVy
         +kknvcJw+l1COcXr1WxKgCIAA/xtVF1xSOWzj0tv7qCSxxoZjTYjd9hGesl2Y5pEETFA
         sydmenIbtie9RyWBEtauozJS9ZDhzPcGMPbWkXJpLhBndLW+1FTX7xm3griEuISFV9tz
         fpTG3Lx7b8c8Nb/7gLmU4k+GXQcT7fanfIH62FOvhL46B+Kl2eiCBrYCS9iGc6r5EFaD
         +3YA==
X-Forwarded-Encrypted: i=1; AHgh+Rql/gV9CTMJYvDnGK8oCWEdc/29W6u9hFdwHZF9nH2w9+6g7vvtz4PK4FPgf0L3RrjK1dEb/Pd5qgsK@vger.kernel.org
X-Gm-Message-State: AOJu0YwzV1UVL9YOzpXfk3S1+W089+t9MJMw9k5WE7uXZ2DU6/VsnXuR
	Vu/xw+iIkc5SPNpPOA97zi55nWzGhEbo5ueFduGOqsp9vLlWV9EqsUuf
X-Gm-Gg: AR+sD13KxLgkaC+dlhEE8fc1aHPWFdZvxs2/7yy1RiDMUEpv7wh+WWHhHE224pctg3G
	XWK3FeXfPcGB4e6oevD2OUd2hIU/gMLj6Mzhs2FIgDXpmvA7/BBIXpUQh95b9jIdkZDFuWNwn2f
	UId7CB9H55H5Exrf81GMPzbDdqiNVZ+2oVSpUHMw0WVPOHPer/erBnqfsinJJVdUE7mM1onQle6
	o6lQbABCJo/yS7u+jkBMAXMjNtGl/jQKZfsgBMR1a4GKL0OLaWZaBiyOapeHZrArw2ZhmybOZbo
	pnuZ+rTNtfg020G6QFSoC5AC/OGK7UmGBAej22VEi3Ysia9ers9VJ4JOgH/OYw0iz+smnujnnwL
	sLhrdOQux5cwAqcOTIpgMYVbQSiHdvH6KosVoliAT7RTzqsSCaOxmnJiKxTehgtDhT+dzvRYZjG
	7BW0tS/LbgFeqfEnu4hMHcMIet3icXYNcoxf8WpA+XGLdz+EzE+mp7xmPrYSv6l4yU3taWZx6th
	9XljBuF5p9lQ9D0jvDnNnHH7HX5zvhbANnX/vhkjjgSexF6e/+sPR1+s/0rhhBzBMD8/V4BF+Ke
	USsZ047l7Au/88YYMNtQ72Qdp0geL26Ip5HRrEgqIwjfWfsL36cTFlMuRzq1dy7Ne00GDzqjYzI
	l8+gH8JNVSXHmLJR5
X-Received: by 2002:a05:6830:6ab1:b0:7ec:6749:f38d with SMTP id 46e09a7af769-7f3ddfd0405mr29268449a34.0.1787036342856;
        Mon, 17 Aug 2026 23:59:02 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41beef430sm3599463a34.5.2026.08.17.23.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:59:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 18 Aug 2026 00:58:57 -0600
Subject: [PATCH net-next v3 1/4] driver core: add fw_devlink supplier-copy
 helper
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-submit-phy-package-fwdevlink-v1-v3-1-40a905ea16b6@gmail.com>
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Some firmware nodes describe resources shared by devices instantiated for
their children, but the container node itself is never converted to a
struct device. The firmware parser should retain the topology as
described, while the framework which creates the children can identify
the actual consumers.

Add fw_devlink_copy_suppliers() so such a framework can copy the direct
supplier links from a container to a real consumer firmware node before
the consumer is registered. The normal device_add() path then converts
the copied dependencies into device links at the correct point in device
registration.

Leave the source links in place for other children, suppress duplicate
links and roll back newly allocated links if a copy fails. Skip ignored
links and clear cycle flags on newly copied links, since cycle
classification must be recomputed for the new consumer topology. Reject
calls after the target firmware node has been associated with a device.
Check that association while holding the fwnode-link lock so a
concurrent device_add() either observes the copied links or makes the
helper reject the request.

Add KUnit coverage for filtering, cycle-flag handling, idempotency, the
pre-registration contract and conversion into an active device link.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v2 -> v3:
  - Keep generic firmware parsing faithful to the described topology and
    add a helper for frameworks to project container suppliers onto real
    child consumers, as suggested by Saravana Kannan
  - Require copying before device_add() and let the normal fw_devlink path
    create device links after consumer sysfs and PM initialization
  - Serialize the target-association check with fwnode link copying
  - Skip ignored links, recalculate cycle state for copied links and add
    KUnit coverage
---
 drivers/base/core.c                  |  60 ++++++++++
 drivers/base/test/Makefile           |   1 +
 drivers/base/test/fwnode-link-test.c | 207 +++++++++++++++++++++++++++++++++++
 include/linux/fwnode.h               |   2 +
 4 files changed, 270 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d026682944f..cf3f4133391d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2394,6 +2394,66 @@ static void fw_devlink_link_device(struct device *dev)
 	__fw_devlink_link_to_suppliers(dev, fwnode);
 }
 
+/**
+ * fw_devlink_copy_suppliers - Copy supplier links between firmware nodes
+ * @to: Firmware node which consumes the copied suppliers
+ * @from: Firmware node whose supplier links should be copied
+ *
+ * Frameworks can use this when a container firmware node describes resources
+ * shared by devices created for its children. The source links remain in
+ * place, while links are added for the real consumer firmware node. Call this
+ * before device_add() associates @to with a registered device, so the normal
+ * fw_devlink path can convert the copied dependencies into device links.
+ *
+ * Ignored source links are skipped. Cycle flags are topology-specific and are
+ * recalculated for the new consumer when its links are converted.
+ *
+ * Return: 0 on success, -EINVAL for invalid firmware nodes, -EBUSY if @to is
+ * already associated with a device, or -ENOMEM if a link could not be
+ * allocated.
+ */
+int fw_devlink_copy_suppliers(struct fwnode_handle *to,
+			      struct fwnode_handle *from)
+{
+	struct list_head *first;
+	struct fwnode_link *link;
+	int ret;
+
+	if (!to || !from)
+		return -EINVAL;
+	if (!fw_devlink_flags || to == from)
+		return 0;
+	fw_devlink_parse_fwnode(from);
+
+	guard(mutex)(&fwnode_link_lock);
+	if (READ_ONCE(to->dev))
+		return -EBUSY;
+
+	first = to->suppliers.next;
+	list_for_each_entry(link, &from->suppliers, c_hook) {
+		u8 flags = link->flags & ~FWLINK_FLAG_CYCLE;
+
+		if (flags & FWLINK_FLAG_IGNORE)
+			continue;
+
+		ret = __fwnode_link_add(to, link->supplier, flags);
+		if (ret)
+			goto rollback;
+	}
+
+	return 0;
+
+rollback:
+	while (to->suppliers.next != first) {
+		link = list_first_entry(&to->suppliers, struct fwnode_link,
+					c_hook);
+		__fwnode_link_del(link);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fw_devlink_copy_suppliers);
+
 /* Device links support end. */
 
 static struct kobject *dev_kobj;
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index e321dfc7e922..d871a71dbbaa 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
 obj-$(CONFIG_DM_KUNIT_TEST)	+= platform-device-test.o
+obj-$(CONFIG_DM_KUNIT_TEST)	+= fwnode-link-test.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
 CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/fwnode-link-test.c b/drivers/base/test/fwnode-link-test.c
new file mode 100644
index 000000000000..fee18613d230
--- /dev/null
+++ b/drivers/base/test/fwnode-link-test.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/platform_device.h>
+#include <kunit/test.h>
+
+#include <linux/device.h>
+#include <linux/fwnode.h>
+#include <linux/platform_device.h>
+
+#define FWNODE_LINK_TEST_DRIVER_NAME	"fwnode-link-test"
+
+struct fwnode_link_test_context {
+	struct fwnode_handle consumer;
+	struct fwnode_handle container;
+	struct fwnode_handle supplier_a;
+	struct fwnode_handle supplier_b;
+};
+
+static int fwnode_link_test_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver fwnode_link_test_driver = {
+	.probe = fwnode_link_test_probe,
+	.driver = {
+		.name = FWNODE_LINK_TEST_DRIVER_NAME,
+	},
+};
+
+static void fwnode_link_test_cleanup(void *data)
+{
+	struct fwnode_link_test_context *context = data;
+
+	fwnode_links_purge(&context->consumer);
+	fwnode_links_purge(&context->container);
+	fwnode_links_purge(&context->supplier_a);
+	fwnode_links_purge(&context->supplier_b);
+}
+
+static struct fwnode_link_test_context *
+fwnode_link_test_init(struct kunit *test)
+{
+	struct fwnode_link_test_context *context;
+	int ret;
+
+	context = kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, context);
+
+	fwnode_init(&context->consumer, NULL);
+	fwnode_init(&context->container, NULL);
+	fwnode_init(&context->supplier_a, NULL);
+	fwnode_init(&context->supplier_b, NULL);
+	ret = kunit_add_action_or_reset(test, fwnode_link_test_cleanup,
+					context);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return context;
+}
+
+static struct platform_device *
+fwnode_link_test_register_pdev(struct kunit *test,
+			       struct fwnode_handle *fwnode)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = kunit_platform_device_alloc(test, FWNODE_LINK_TEST_DRIVER_NAME,
+					   PLATFORM_DEVID_AUTO);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	device_set_node(&pdev->dev, fwnode);
+	ret = kunit_platform_device_add(test, pdev);
+	if (ret) {
+		KUNIT_FAIL(test, "failed to register platform device: %d", ret);
+		return NULL;
+	}
+
+	return pdev;
+}
+
+static unsigned int fwnode_supplier_count(struct fwnode_handle *fwnode)
+{
+	struct fwnode_link *link;
+	unsigned int count = 0;
+
+	list_for_each_entry(link, &fwnode->suppliers, c_hook)
+		count++;
+
+	return count;
+}
+
+static struct fwnode_link *
+fwnode_find_supplier(struct fwnode_handle *consumer,
+		     struct fwnode_handle *supplier)
+{
+	struct fwnode_link *link;
+
+	list_for_each_entry(link, &consumer->suppliers, c_hook) {
+		if (link->supplier == supplier)
+			return link;
+	}
+
+	return NULL;
+}
+
+static void fwnode_link_copy_suppliers_test(struct kunit *test)
+{
+	struct fwnode_link_test_context *context;
+	struct fwnode_link *link;
+	int ret;
+
+	context = fwnode_link_test_init(test);
+	KUNIT_ASSERT_NOT_NULL(test, context);
+
+	ret = fwnode_link_add(&context->container, &context->supplier_a,
+			      FWLINK_FLAG_CYCLE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = fwnode_link_add(&context->container, &context->supplier_b,
+			      FWLINK_FLAG_IGNORE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fw_devlink_copy_suppliers(&context->consumer,
+					&context->container);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, fwnode_supplier_count(&context->container), 2U);
+	KUNIT_EXPECT_EQ(test, fwnode_supplier_count(&context->consumer), 1U);
+
+	link = fwnode_find_supplier(&context->consumer, &context->supplier_a);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_EXPECT_EQ(test, link->flags, (u8)0);
+	link = fwnode_find_supplier(&context->consumer, &context->supplier_b);
+	KUNIT_EXPECT_NULL(test, link);
+
+	ret = fw_devlink_copy_suppliers(&context->consumer,
+					&context->container);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, fwnode_supplier_count(&context->consumer), 1U);
+}
+
+static void fwnode_link_copy_before_device_add_test(struct kunit *test)
+{
+	struct fwnode_link_test_context *context;
+	struct platform_device *consumer;
+	struct platform_device *supplier;
+	struct device_link *link;
+	int ret;
+
+	context = fwnode_link_test_init(test);
+	KUNIT_ASSERT_NOT_NULL(test, context);
+
+	ret = fwnode_link_add(&context->container, &context->supplier_a, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	supplier = fwnode_link_test_register_pdev(test, &context->supplier_a);
+	KUNIT_ASSERT_NOT_NULL(test, supplier);
+
+	ret = fw_devlink_copy_suppliers(&context->consumer,
+					&context->container);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	consumer = fwnode_link_test_register_pdev(test, &context->consumer);
+	KUNIT_ASSERT_NOT_NULL(test, consumer);
+
+	KUNIT_EXPECT_EQ(test, fwnode_supplier_count(&context->container), 1U);
+	KUNIT_EXPECT_EQ(test, fwnode_supplier_count(&context->consumer), 0U);
+
+	if (list_empty(&consumer->dev.links.suppliers)) {
+		KUNIT_FAIL(test, "consumer device link was not created");
+		return;
+	}
+	link = list_first_entry(&consumer->dev.links.suppliers,
+				struct device_link, c_node);
+	KUNIT_EXPECT_PTR_EQ(test, link->supplier, &supplier->dev);
+	KUNIT_EXPECT_EQ(test, READ_ONCE(link->status), DL_STATE_ACTIVE);
+
+	ret = fw_devlink_copy_suppliers(&context->consumer,
+					&context->container);
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+}
+
+static struct kunit_case fwnode_link_test_cases[] = {
+	KUNIT_CASE(fwnode_link_copy_suppliers_test),
+	KUNIT_CASE(fwnode_link_copy_before_device_add_test),
+	{}
+};
+
+static int fwnode_link_test_suite_init(struct kunit_suite *suite)
+{
+	return platform_driver_register(&fwnode_link_test_driver);
+}
+
+static void fwnode_link_test_suite_exit(struct kunit_suite *suite)
+{
+	platform_driver_unregister(&fwnode_link_test_driver);
+	device_link_wait_removal();
+}
+
+static struct kunit_suite fwnode_link_test_suite = {
+	.name = "fwnode-link",
+	.suite_init = fwnode_link_test_suite_init,
+	.suite_exit = fwnode_link_test_suite_exit,
+	.test_cases = fwnode_link_test_cases,
+};
+
+kunit_test_suite(fwnode_link_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for firmware-node links");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 4e86e6990d28..ad4250fc7afb 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -254,6 +254,8 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode);
+int fw_devlink_copy_suppliers(struct fwnode_handle *to,
+			      struct fwnode_handle *from);
 bool fw_devlink_is_strict(void);
 
 #endif

-- 
2.53.0

