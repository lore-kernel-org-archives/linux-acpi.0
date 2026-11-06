Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.241
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955449;
	b=cqa9QFZmLL6HGmZtBmVtgqqc5j3Vv4+mAIwba/RcJgbBSJTbcpdY/xw1A8k5lpP3j049
	 slDfzKmCvk4PUnlZwgOGLi3kyC8dpWleIOI8gDFs1VXKxFGizEyKue256d16Umj5I7K05
	 7uD6QKWk+GPrwjor98DsoTB5Mnp1dIPhAc+U86EdFR+rBK7jO/La+xiu5kXZx7ss5Ktw2
	 kC2EqGHEeR9Fc8SnrmTVWeVYYZH6tzv3mxc0OBQK1DJcYsyW9p3D9XInTNK37KQzijJhV
	 4w2LxL2jscIvvw7UO9h8s+J7tuNLLmIj5drmU2Gn471wGwJW9aUTgy0DxMQKEVkPGig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955449;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7tnDwOUyL+9+3EBd25a2jQS8D7TqqGxOJ/LMYNK67W8=;
	b=Viw/HDdPs3vyJP4ofEwwyONR6gliDyGOd0bjFL4TtpMvrMDgKh1g1ngzEvRiYbpwkW38
	 /7zsE8sXX3DUqtw14b0Dg9MISJSPOL44/7CtCvT8qfocKPMvO02Z1k/niE9moqeSOuJw7
	 ZxAmRBG5Z/3T2O1PCa/or8+LJXr63Me6cQTykxr7n61mk3Sj7ZwtKjW09xwBaCjZ/PiOK
	 moYYXQe9xGfx1oFxFDDb9I+B6D2BRNJabwt24kEbXC4nvXldmNoD7Z4NDE0NMmUX+6tQl
	 WfGSMXJpcv+UNMQznr5h/imqoqCidw+GHHVCPyzx4ahrysBoC4nHqgCMvZv1Ucj4Ddg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HTJjrmFL;
	arc=none smtp.remote-ip=91.218.175.241
Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0085606A331
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 08:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0085606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HTJjrmFL
X-Envelope-To: linux-acpi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d8226L5zRatr4QjzGAsxcF8uWP/1uGCbid94j82xW6U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793955447; v=1; x=1794560247;
 b=HTJjrmFLQVrV7kAs8EPK/OhwBG9oU0FEZ56DSo5LizGks/N4Tm2o7FRZ2BTqv7EL7HasxgUp
 YDXL98vSgciL+0idIGV35kKUY8rX+bz0od0hhd/UuueCkz504dajqUN5PwgUU9gHCa7OdKJtHTP
 lRy72Qc1D2NfHgSmvR276Q+c=
X-Envelope-To: linux-acpi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c5586882dd48232f;
	Fri, 06 Nov 2026 08:57:26 +0000
X-Mizu-Trace-ID: c5586882dd48232f
X-Migadu-Flow: FLOW_OUT
Date: Fri, 6 Nov 2026 16:57:14 +0800
From: Peng Fan <peng.fan@linux.dev>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/4] software node: do not resurrect swnode being
 released
Message-ID: <au2WakZdbqc6asKF@fedora>
References: <20261106-swnode-race-v1-v2-0-f8bc7b14d578@nxp.com>
 <20261106-swnode-race-v1-v2-1-f8bc7b14d578@nxp.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-swnode-race-v1-v2-1-f8bc7b14d578@nxp.com>

Hi All,
On Fri, Nov 06, 2026 at 12:38:35PM +0800, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>software_node_to_swnode() walks the kset list under list_lock, but the
>last kobject_put() drops the reference count to zero before
>kobject_cleanup() removes the object from the list. A lookup can
>therefore find a zero-ref swnode and call kobject_get() on it, which
>triggers refcount warnings and a use-after-free.

sashiko reported issue here:
https://lore.kernel.org/all/sashiko-outbox-200773@kernel.org/

But this is not a new issue introduced by this series. The series only fixes
the zero-reference lookup on swnode_kset->list for unnamed static nodes such
as dwc3_imx_swnode. Named-node and parent/child-group re-registration after
delayed release is a pre-existing limitation and is out of scope of this patchset.
The parent->children list also lacks synchronization between list_add_tail()
in swnode_register(), list_del() in software_node_release(), and child
traversal; that is why the child-traversal patch was dropped from this series.
We plan to address both in a separate patchset that adds proper locking/lifetime
handling for parent->children and parent/child-group reuse.

I tend to not introduce uneccessary churn to this patchset, but if you perfer
to have all the fixes ready, I could give a look to fix in v3.

Thanks
Peng

>
>One way to hit this is the dwc3-imx driver on i.MX95: when
>dwc3_core_probe() returns -EPROBE_DEFER, dwc3_imx_probe() removes the
>static software node from the device, and the deferred probe retry
>immediately adds the same node again. The previous swnode is still
>waiting for its release callback, and CONFIG_DEBUG_KOBJECT_RELEASE makes
>the window large and deterministic.
>
>Fix the lookup by acquiring references with kobject_get_unless_zero()
>and skipping objects that are already in their release path. Use a
>reference-returning variant for callers that keep the node (register and
>device_add_software_node()) and keep a borrowed-pointer variant for
>software_node_fwnode() and software_node_unregister().
>
>To avoid looking the node up again after registration,
>software_node_register() now uses an internal helper that returns the
>newly created swnode reference, and device_add_software_node() consumes
>that reference directly.
>
>Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
> drivers/base/swnode.c | 122 +++++++++++++++++++++++++++++++++++---------------
> 1 file changed, 86 insertions(+), 36 deletions(-)
>
>diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>index 84a77ffa3dc4b..965e960156876 100644
>--- a/drivers/base/swnode.c
>+++ b/drivers/base/swnode.c
>@@ -75,8 +75,36 @@ static inline struct swnode *dev_to_swnode(struct device *dev)
> 	return to_swnode(fwnode);
> }
> 
>+static struct swnode *swnode_get(struct swnode *swnode)
>+{
>+	kobject_get(&swnode->kobj);
>+
>+	return swnode;
>+}
>+
>+static void swnode_put(struct swnode *swnode)
>+{
>+	kobject_put(&swnode->kobj);
>+}
>+
>+static struct swnode *swnode_get_unless_zero(struct swnode *swnode)
>+{
>+	if (!kobject_get_unless_zero(&swnode->kobj))
>+		return NULL;
>+
>+	return swnode;
>+}
>+
>+/*
>+ * Find the swnode registered for @node and return it with a new reference.
>+ *
>+ * A kobject remains on the kset list until its release callback runs, so an
>+ * entry whose last reference has already been dropped can still be found
>+ * here.  Use kobject_get_unless_zero() to skip such objects instead of
>+ * resurrecting them.
>+ */
> static struct swnode *
>-software_node_to_swnode(const struct software_node *node)
>+software_node_to_swnode_get(const struct software_node *node)
> {
> 	struct swnode *swnode = NULL;
> 	struct kobject *k;
>@@ -87,10 +115,16 @@ software_node_to_swnode(const struct software_node *node)
> 	spin_lock(&swnode_kset->list_lock);
> 
> 	list_for_each_entry(k, &swnode_kset->list, entry) {
>-		swnode = kobj_to_swnode(k);
>-		if (swnode->node == node)
>-			break;
>-		swnode = NULL;
>+		struct swnode *candidate = kobj_to_swnode(k);
>+
>+		if (candidate->node != node)
>+			continue;
>+
>+		if (!swnode_get_unless_zero(candidate))
>+			continue;
>+
>+		swnode = candidate;
>+		break;
> 	}
> 
> 	spin_unlock(&swnode_kset->list_lock);
>@@ -98,6 +132,21 @@ software_node_to_swnode(const struct software_node *node)
> 	return swnode;
> }
> 
>+/*
>+ * Borrowed-pointer variant of software_node_to_swnode_get().  The caller must
>+ * guarantee the lifetime of @node by other means.
>+ */
>+static struct swnode *
>+software_node_to_swnode(const struct software_node *node)
>+{
>+	struct swnode *swnode = software_node_to_swnode_get(node);
>+
>+	if (swnode)
>+		swnode_put(swnode);
>+
>+	return swnode;
>+}
>+
> const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
> {
> 	const struct swnode *swnode = to_swnode(fwnode);
>@@ -374,18 +423,6 @@ EXPORT_SYMBOL_GPL(property_entries_free);
> /* -------------------------------------------------------------------------- */
> /* fwnode operations */
> 
>-static struct swnode *swnode_get(struct swnode *swnode)
>-{
>-	kobject_get(&swnode->kobj);
>-
>-	return swnode;
>-}
>-
>-static void swnode_put(struct swnode *swnode)
>-{
>-	kobject_put(&swnode->kobj);
>-}
>-
> static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
> {
> 	struct swnode *swnode = swnode_get(to_swnode(fwnode));
>@@ -977,21 +1014,39 @@ void software_node_unregister_node_group(const struct software_node * const *nod
> }
> EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
> 
>+static struct swnode *
>+software_node_register_node(const struct software_node *node)
>+{
>+	struct swnode *parent, *swnode;
>+	struct fwnode_handle *fwnode;
>+
>+	swnode = software_node_to_swnode_get(node);
>+	if (swnode) {
>+		swnode_put(swnode);
>+		return ERR_PTR(-EEXIST);
>+	}
>+
>+	parent = software_node_to_swnode_get(node->parent);
>+	if (node->parent && !parent)
>+		return ERR_PTR(-EINVAL);
>+
>+	fwnode = swnode_register(node, parent, 0);
>+	if (parent)
>+		swnode_put(parent);
>+
>+	if (IS_ERR(fwnode))
>+		return ERR_CAST(fwnode);
>+
>+	return to_swnode(fwnode);
>+}
>+
> /**
>  * software_node_register - Register static software node
>  * @node: The software node to be registered
>  */
> int software_node_register(const struct software_node *node)
> {
>-	struct swnode *parent = software_node_to_swnode(node->parent);
>-
>-	if (software_node_to_swnode(node))
>-		return -EEXIST;
>-
>-	if (node->parent && !parent)
>-		return -EINVAL;
>-
>-	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
>+	return PTR_ERR_OR_ZERO(software_node_register_node(node));
> }
> EXPORT_SYMBOL_GPL(software_node_register);
> 
>@@ -1061,21 +1116,16 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
> int device_add_software_node(struct device *dev, const struct software_node *node)
> {
> 	struct swnode *swnode;
>-	int ret;
> 
> 	/* Only one software node per device. */
> 	if (dev_to_swnode(dev))
> 		return -EBUSY;
> 
>-	swnode = software_node_to_swnode(node);
>-	if (swnode) {
>-		swnode_get(swnode);
>-	} else {
>-		ret = software_node_register(node);
>-		if (ret)
>-			return ret;
>-
>-		swnode = software_node_to_swnode(node);
>+	swnode = software_node_to_swnode_get(node);
>+	if (!swnode) {
>+		swnode = software_node_register_node(node);
>+		if (IS_ERR(swnode))
>+			return PTR_ERR(swnode);
> 	}
> 
> 	set_secondary_fwnode(dev, &swnode->fwnode);
>
>-- 
>2.34.1
>
>
