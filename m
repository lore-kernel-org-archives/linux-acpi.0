Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825533;
	b=4J8SI4c13Gyj55PDMtV0tyft0ZM62B8nZeuVm9YGNM4CXkVL2TcZmrMEhzxXLh02ra9s
	 ANmCf2aYicXbTwnnvwVpICa/CFVt2ciJEB+Toh+maR+0Ie65F9MZrihJhXIk0LfUwKKNn
	 gKusbBYk3o6xddlbYp3G48cfT1SfgWvB6XtgRgKiejdCtWsDp7DJZy+OAmcYooXLPOBRX
	 vs0F/lcqC5r8cFO8jtBgXS0EiwKk8ue91sXHN8VnaIdQR9gQcElkKDQTwBmfeM/fOrO3n
	 /wOO46Xp4+hb8kn6FPaxmj3UBtIx5kjBlWlmi+v+yO8sZJ2cdjRpAOGZ4694RT1IGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825533;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QRGsy4+/SMCADWAf/zPFn8gYvB9q7AQj208EjNSpYys=;
	b=rjgRvuQ4jsdZz8Oq5fGaWoMqQ2Rs1djO87DMCEx+r4k8wpAAL6hXLKC7lx+LERkwh/9U
	 DE9Zht5y82q3MPvgifFc81gZGjvsdV4TZrZ4VAKdOHsrEortB6HxNeWdMVdpyfS2sdmI3
	 hwn5qQkqIKpjEuoUeTVtyiBc9EVTQy0Wc2kK2sXENCp3WHvvDjMW0IS6lqIm/pj5oLOF6
	 zyKaPrlT1wkZghN2st12RXEnyp9p7bSCIC4EFzwkPs0CWWfspZIZPrRMUYDmO1mbPqV0k
	 DLdHo0e51f7RM8iEIJKUJCU4vuCG8TE4jJ7u9C79JH4VImRfMk83t9o/tDW7NdEs53g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQfUrpf7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C372606A31C;
	Mon, 16 Nov 2026 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQfUrpf7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064011F000C4;
	Mon, 16 Nov 2026 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825533;
	bh=QRGsy4+/SMCADWAf/zPFn8gYvB9q7AQj208EjNSpYys=;
	h=From:To:Cc:Subject:Date;
	b=QQfUrpf7KW2E/D92ipRWpozh9+fpTADkzTrphMMvDryWKir8BBYX7qCBcSTW+rVWp
	 kaiMYy+yIpMR9mIbgR8DRCVv4IfxgIpY1Y+DDiVQ4sUnbDSCz6tjaA1d+Onhwir9qo
	 /Q+tqcUHmpQoSq+XiUjHclTSAe1wuvLKjNZH8JA1Dyr/Ixg6f7uZrEX2Y1DJLpc8hj
	 acwpcyoYay/1LK2K4lE2p101sXkHiQcMF45jS/QCBCCBdK8I0xFJ28viJILxyd1PG1
	 GTFR4ZJWHV71y/VTkngjWpzNoBl17cM2KdxBLWHBUvlKy/x8qoJlnKMNt0yMP+6wEy
	 oYjrB4LIMrrWA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xSu6s-000000035gU-2JU3;
	Mon, 16 Nov 2026 11:38:50 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] software node: fix node group deregistration kernel-doc
Date: Mon, 16 Nov 2026 11:38:07 +0100
Message-ID: <20261116103807.736778-1-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Child software nodes hold a reference to their parent via kobj->parent
so there was never any need to deregister them in any particular order.

Drop the misleading kernel-doc comments which suggest that deregistering
a parent node before a child could cause trouble.

Note that parent nodes still need to be registered before their children
or registration will fail.

Fixes: fc002f0f23e2 ("media: software_node: unregister software_nodes in reverse order")
Fixes: 0b8bf06f6719 ("device property: Sync descriptions of swnode array and group APIs")
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/swnode.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 8e12f518e13f..78e224539b02 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -954,14 +954,7 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
  * software_node_unregister_node_group - Unregister a group of software nodes
  * @node_group: NULL terminated array of software node pointers to be unregistered
  *
- * Unregister multiple software nodes at once. If parent pointers are set up
- * in any of the software nodes then the array **must** be ordered such that
- * parents come before their children.
- *
- * NOTE: If you are uncertain whether the array is ordered such that
- * parents will be unregistered before their children, it is wiser to
- * remove the nodes individually, in the correct order (child before
- * parent).
+ * Unregister multiple software nodes at once.
  */
 void software_node_unregister_node_group(const struct software_node * const *node_group)
 {
-- 
2.56.1

