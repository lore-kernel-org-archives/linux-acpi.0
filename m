Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1620348C7C;
	Mon, 27 Jul 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184080; cv=none; b=jg1kYjQSma+yjjNLW7NReGudOivlsQyZ4NBpYr8LvXWmapiIjppBjmB+kSlhRiqTFH2FFqPUlfdgJE0NLG7sD/BCUMQPjMSATllzU9+iPwEsazJBqqLruqPC305VjEPfz8xkHXJENER8+eq3T+5psLLKGxQIYMdgzOauOwzGHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184080; c=relaxed/simple;
	bh=r3Bys7foCy0mQ2scOjz9rgltziaoDkyyCFCVWUa344Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1OEhEQVJnIaunfpjMIkSbbKozxEIZ0Ft71N2+ZsfXb24je4UK1AaB0tOUB7jDt0nyvBjemszNSLw3vhUISRqss5rwwMw3hdUJR4Z+sOGGPBGPBxt9fWD6V87AugBNGrFztvsWKoQ5Q92V/tcCn/1+YfW/XYClyhFCXMaf94KnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQGYqoCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQGYqoCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BB61F000E9;
	Mon, 27 Jul 2026 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785184079;
	bh=Za2Ol0cEc3tfHtXfcT2nw7XSmezZkgdKXNLet7EAUwA=;
	h=From:To:Cc:Subject:Date;
	b=HQGYqoCZarYCoZMyIEq9G1+WwALyeSv2/+atEYUfNHZAE1peL0xtHC5YKs5+B73yF
	 cNBLMMTG+dCKPKuXljipA5Mwgu/ukSZkyDaJkmOFharL8OQlur7A2L3gBhdMRofPoX
	 U7FEkHcvr8Ac84LVvZ/gKse1aEckOgQvzJ/K2aPR+b2paCu3mOaNh5TLIGvqdq5Yzk
	 35FfQYY4AAXEQTJ7wZp28fqZMzz//HF/KRfUwEERWf6gbTb5m6fKa4vq6kM2o6teit
	 AV+aMMY4o0aWXsrjwKD2Lvx7b26au9dMDPeAQEoDHDA07w9qzPmqOsi//P8qhgAJ3Y
	 XvrWuu+/1XSjw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andriy.shevchenko@linux.intel.com,
	djrscally@gmail.com,
	heikki.krogerus@linux.intel.com,
	sakari.ailus@linux.intel.com,
	brgl@kernel.org,
	rdunlap@infradead.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH] fwnode: add missing kernel-doc for struct fwnode_operations members
Date: Mon, 27 Jul 2026 22:27:40 +0200
Message-ID: <20260727202748.2232253-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the four undocumented struct members in
struct fwnode_operations: device_dma_supported, device_get_dma_attr,
iomap, and irq_get.

This avoids kernel-doc warnings once include/linux/fwnode.h is included
in the driver-api infrastructure documentation.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 include/linux/fwnode.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 4e86e6990d28..a9dcaf7e7076 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -117,6 +117,8 @@ struct fwnode_reference_args {
  * @put: Put a reference to an fwnode.
  * @device_is_available: Return true if the device is available.
  * @device_get_match_data: Return the device driver match data.
+ * @device_dma_supported: Return true if DMA is supported.
+ * @device_get_dma_attr: Return the device DMA attribute.
  * @property_present: Return true if a property is present.
  * @property_read_bool: Return a boolean property value.
  * @property_read_int_array: Read an array of integer properties. Return zero on
@@ -134,6 +136,8 @@ struct fwnode_reference_args {
  *			       endpoint node.
  * @graph_get_port_parent: Return the parent node of a port node.
  * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
+ * @iomap: Map the I/O memory of a given index for a fwnode.
+ * @irq_get: Get the IRQ of a given index for a fwnode.
  * @add_links:	Create fwnode links to all the suppliers of the fwnode. Return
  *		zero on success, a negative error code otherwise.
  */
-- 
2.55.0

