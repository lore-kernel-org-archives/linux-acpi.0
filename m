Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC8312832;
	Sun, 19 Jul 2026 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784500604; cv=none; b=L55EKcr5EMpjXO80tNAnKdTO0AjRDGVhhUBSYQq4V1vAjxSz3Qpf+2fBmD88NtGq+oCV+JstbBq3C54XzWnWBFrK9clYgGUSuf8L12gXLfwHqYwUypQoQ5guzy9njM+NxTx1uiD1xU0vZIpjLfB826GDZagDf6YOJN07wckjZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784500604; c=relaxed/simple;
	bh=VHbE/VULGnnC27oMlT0uQ00sXlkAXX2rgn7w7mnbQ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEoDquB5EdaMuGDm3FEhGRO4sWXdgCKdRO2EZ9wqrM8UDPHpqoc+XPsEMGAXiS39xqs+Mju0/3IFo+wdvZNJPUcDj1higBgkmqwa9PEDVkeyeSWogTly68n/R6bXtoze5HEY3cQSUhnB7gDdOeHlwxQLG7Oe/RB62Os48uvFlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OH9P1E7y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OH9P1E7y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wSB52/WtP6HuuvG74+GyQCPYwOqQm+vAX5uv61MDy+s=; b=OH9P1E7y34TbuJvCuHd7jHk/jp
	XVv4N5DD0sqPg657UfVb9KOTEPQhkWvxrHoQ5WdNCZ31Hoi1raiocY1eG9ohCpu+JhEdQ0X341nUs
	Rp2Kt1p4j6iXTGEOR4DZ7GXTdfPFjvrc3trQGwh2ztZAUPaetsAIA3+Qf54/aXRzV4Q0hgl1dybfg
	mi4fJ+iKmSBE1ZhoaihucD/TTkF9DlcoFDofHcZqC24SArpcF+5qTnF5/XCDU62jJpAJyC2flGkB5
	/R9F4StuWCJKgoX8DhuVdzMMLvHASxQB3DQiWkyca/lvmbyTgqMYh7cM1t/VP/+6TAvsFIvcTF5jc
	pM4NrqMg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wla7l-00000005RRr-3XF8;
	Sun, 19 Jul 2026 22:36:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev
Subject: [PATCH] device property: add missing kernel-doc for property_entry
Date: Sun, 19 Jul 2026 15:36:40 -0700
Message-ID: <20260719223640.2864890-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc for the missing fields in union value:

Warning: include/linux/property.h:406 struct member 'u8_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'u16_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'u32_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'u64_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'str' not described
 in 'property_entry'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev

 include/linux/property.h |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20260717.orig/include/linux/property.h
+++ linux-next-20260717/include/linux/property.h
@@ -388,6 +388,11 @@ struct software_node_ref_args {
  * @type: Type of the data in unions.
  * @pointer: Pointer to the property when it is not stored inline.
  * @value: Value of the property when it is stored inline.
+ * @u8_data: @value as an array of u8 numbers
+ * @u16_data: @value as an array of u16 numbers
+ * @u32_data: @value as an array of u32 numbers
+ * @u64_data: @value as an array of u64 numbers
+ * @str: @value as an array of char pointers
  */
 struct property_entry {
 	const char *name;
