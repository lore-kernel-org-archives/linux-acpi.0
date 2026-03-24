Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2F20C00C
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774327618; cv=none; b=R3VhSPZV/YwvkRCNli/pPn8AEEMVGlr8Nw77qGClevKGIrMJEFlyHpXTLXn5N6WZ86z7kav2+g8VIbQvrBT0HOCNQ/Jo8kHNWT3HL0wiQh3g9Gvpy6OFkzQzGrEbEOKIwC7QcTOWOVSzuGdh88dQt3czkkHJ+Gao76MPbVrEzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774327618; c=relaxed/simple;
	bh=S4LmDD5N7YorWQUk0CYhBh+UXavWKeyPWNH2i6t9Gjk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gigTCLDAT3FcGf3YBckXei510MdkrgKWSn92UmZ2I1H8zKW30dMDdxhJbaowQ1Bwv6yaOzWNJIOAqB3u0qyENd54WPRJ3U9EpFhn7k8u5sva1t00ia/f1vB1yLCoPDD2ue3g5+UTm6s0ra2V8gFfZNTaa7IBwe/G13ue9nl6h+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1tZ1rmq; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1tZ1rmq"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c1092cc08cso1870719eec.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774327616; x=1774932416; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4n4yln5k8cNFTolCtaKAVbNlkFjgerksTIKyF55kf7g=;
        b=h1tZ1rmqJKQ1VqLsvMFUqdCbD0VV7FlCr89jI/mM10cbSzXtGeAhkUpCtZ50PBNsl3
         VRD8uRYKjcA1Uo3IZxDVoNawip4HgZt6vOEQwkaupbUbVXaYnRkPGgM1jXggwuJ3Icfy
         cEfBQ6XulzmuKn6CwgK98AFbD6/6UPL45HbcQV+LtztigeaRcoXHinhuTWqwloavXW8h
         Bfll1y2dSiY2iv8uhzUb+oSnzCxPumyXf6QKtJtFq83MUf+Bcmy1KNGsw/tovZT1pU60
         Rg/cckOId7sHmT+igsPT8Hc4ZJSDvXZ28zOk+gxlXTFtJ0s2cfuTx1lbpfyAQkb9uHdc
         slKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774327616; x=1774932416;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n4yln5k8cNFTolCtaKAVbNlkFjgerksTIKyF55kf7g=;
        b=HYVUmYsd1jyeZl3RPiUbb+baz7qlQ9AZ3peY90MlozLykHSV+SPuqaYMFKExAmZUsL
         mnnn+UVvJ9Pu2Y+e+ILQhBp+S8YwSnLKOZImKqSBp9RfoBwzXOeL2fWnIclJ7LdusTve
         /8ENKNIjMh+M4pqmJw7/Xhvz5jAuC8HSG7HfuRZtwcCFa2E6+nkGOYF1vIOn/6sxqZVS
         GlGg0iowa9BuAaKyt3GeH0Yg0Vp9MrbUlqMRR4bKYKz7hw/qtigINqLsOAjdUJNYTXYP
         IWl2LHk/DJFZoiPRdrEdIOM9VTxwZ5l5UZyD3xKZLjGZvOGqi0Skrr1wWygOKyvRR4hi
         dOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCULjAJPXh8wvZLz13TWA+mq2kH4Nqb3k7Gs6oMdzSnjYQYZIp7zcRP8gy1r1SNZ5rCtO2AvNrALjK56@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmRn0iGr+IluZhpFEVCoPFfcRBJkcEiTp9cLnrkJLtZg+BIRF
	3eqtAc/NFt6+nud6aJutw/zXKEHxq2x1F0wtiHri4noS+w90/pUBXlE6
X-Gm-Gg: ATEYQzyfzU79T8MKo8VqOjXXrnRx4ZvVgUOodyqhzbRIOi4Bw1Ck0ekH0XVVkoDJItQ
	VDQWLPEABw8gdJckwSSnQXgcmw11jjnEctdpWYldOd8+eyTdLD4E0LV72+PaBXxLRgnn5MH6w/F
	sVL8m4sn4csr1vDjPqM1ifo0v/03mjpjXt75+6XOxD81Z307L3o0J5ZrHjDieDMyoBrV+UDRYaB
	RVI4UKU71j+zYfMqh4f50ua3BO/LthN/cZN6RhaXSeShRAKMZtrFbYrJeCe1VX9a2S3/wUB1reQ
	c9kuVjcIKhu7sUfjaHt6gPLJOXO6uQZiA8iDsj5q1Wo8rX0J/3+n2NoXhQJMKNlpl3JBcdmcSd0
	o/qRlasBK/DofsyDhvFMrllsSCPhhM98MnZ498o3kEMtDuywpIxsaMGNkjD+anVAcqaXsBF+i5d
	JvY+fB+HX0Ivp+NOuEScVR/slXCMuoLh2iKN0xtm6AlX9VWm69ABpivS/5HTnQPfG+QXbRy6oSH
	iA=
X-Received: by 2002:a05:7301:3f07:b0:2b8:30b8:58cf with SMTP id 5a478bee46e88-2c1095f867cmr6583342eec.8.1774327616075;
        Mon, 23 Mar 2026 21:46:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c1536aa870sm244833eec.2.2026.03.23.21.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 21:46:54 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:46:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] software node: allow referencing software nodes by name
Message-ID: <acIV6xF8mY-8wd5e@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently static device properties references require either an
instance of software node or an instance of fwnode_handle to be
available when defining a reference property. This may not be very
convenient when device node is instantiated from a different module
(which is usually the case).

The original implementation for describing GPIOs using software nodes
worked around this by creating a detached from gpiochip instances
software nodes, and performing matching using gpiochip label and node
name. The gpiolib maintainers rightfully questioned this approach, and
currently recommend to attach secondary software node to gpiochip
instance, export the symbol, and use it in board file when instantiating
static properties. This unfortunately results in tight coupling between
gpiochip drivers and board code, necessitates creation of header files,
requires adding Kconfig dependencies, limits options for choosing module
vs built-in compilation, and alters device initialization/probing order.

Solve the issue by providing an option to use software node name in
place of the node instance when describing reference properties. When
evaluating reference driver core will attempt to resolve the name to
concrete node instance and, in case of GPIO references, will use
identity match on firmware node to locate corresponding gpiochip device.

This approach has a drawback of needing to know name of the node that
gpiochip device will be using, however benefits (minimal coupling, no
need for adding dependencies) outweigh this drawback.

To deal cases with software nodes not being created or registered at
time of look up, assume that the node with matching name will get
registered eventually and return -EPROBE_DEFER in the meantime.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 25 +++++++++++++++++++------
 include/linux/property.h |  4 ++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9..9903f252d1d6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -510,7 +510,6 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	const struct software_node_ref_args *ref_array;
 	const struct software_node_ref_args *ref;
 	const struct property_entry *prop;
-	struct fwnode_handle *refnode;
 	u32 nargs_prop_val;
 	int error;
 	int i;
@@ -546,12 +545,26 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	 * relevant properties and bump the reference count.
 	 */
 
-	if (ref->swnode)
-		refnode = software_node_fwnode(ref->swnode);
-	else if (ref->fwnode)
-		refnode = ref->fwnode;
-	else
+	struct fwnode_handle *refnode __free(fwnode_handle) = NULL;
+	if (ref->swnode) {
+		refnode = fwnode_handle_get(software_node_fwnode(ref->swnode));
+	} else if (ref->fwnode) {
+		refnode = fwnode_handle_get(ref->fwnode);
+	} else if (ref->swnode_name) {
+		const struct software_node *ref_swnode =
+			software_node_find_by_name(NULL, ref->swnode_name);
+		/*
+		 * When using a name instead of a software node structure
+		 * assume the node will appear at some point.
+		 */
+		if (!ref_swnode)
+			return -EPROBE_DEFER;
+
+		/* Reference is already taken by software_node_find_by_name() */
+		refnode = software_node_fwnode(ref_swnode);
+	} else {
 		return -EINVAL;
+	}
 
 	if (!refnode)
 		return -ENOENT;
diff --git a/include/linux/property.h b/include/linux/property.h
index e30ef23a9af3..44e96ee47272 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -363,6 +363,7 @@ struct software_node;
 struct software_node_ref_args {
 	const struct software_node *swnode;
 	struct fwnode_handle *fwnode;
+	const char *swnode_name;
 	unsigned int nargs;
 	u64 args[NR_FWNODE_REFERENCE_ARGS];
 };
@@ -373,6 +374,9 @@ struct software_node_ref_args {
 			   const struct software_node *: _ref_,	\
 			   struct software_node *: _ref_,	\
 			   default: NULL),			\
+	.swnode_name = _Generic(_ref_,				\
+				const char *: _ref_,		\
+				default: NULL),			\
 	.fwnode = _Generic(_ref_,				\
 			   struct fwnode_handle *: _ref_,	\
 			   default: NULL),			\
-- 
2.53.0.1018.g2bb0e51243-goog


-- 
Dmitry
