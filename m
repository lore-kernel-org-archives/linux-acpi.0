Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A33A6B6D
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520704; cv=none; b=REtbQrWXAy6giGd4yvzEc+J1B7EFLY+BD/aUIICQKq/bKQcLsefRtUqaYOsNO3j+bk9AJcEpBA7YEEg5xuNS5YWgwZV8DVysKFgdgtat8bEGmITxY4uXf2CEW1oYOLUjCg1aKU5ajXecCMjVJOdzC1VYYXvc7NlLo8oKZ1zpS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520704; c=relaxed/simple;
	bh=GzGdhUqHabJdT56/0Vx+2i4I/VGZGqigv9kQT5jq97k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RewheWpZtY35KhgLANvPHsAi9iKKYG5FGIt+2Sx3WxoePVNdZ3hFGUrbErb0lEvsS8kO/S2GedISrn+6uD9hdQa+i4RKgJ4RfAAV9j7o3udrZ8aeGyhPnj6OpLiUE6ep/GogIwlwwLH+YysCXOIGZvY9bjRMpT6auuCne50oI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4QnXMhN; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4QnXMhN"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so831091a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520702; x=1789125502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ru9Oqw83JdPP5GZWzgBwRJbCsmncN29/3DvUioCkWHY=;
        b=B4QnXMhNOJdbfpoyYZXJ3WPqmQLENJM4somszgPZPwlSY47MegATXmqFAOkdfitNWb
         gWKf0twnMDQQExwLBrNfofjivNvM6KHtBKZqbNnd1nzP1V73YdfzWjTL4ae/fbSvb+ms
         Ch10BJnYFgkh1R0ktvKhaG05MuBgIutXbSs7MDWT60B+XFZPddNg4O82lrxJa+PeMTx4
         ajmGSqZ8iFS7s3xRxcOQ8bGwNova7RDVBnEyanwJ0aBa5CBUjlkGsuTDGqdm2YRZ5U0w
         IRBHXrdvUjKxN5x7ybio1nsTfD6yFJMY4DIX4cEufRxgTH7sGdWyOsqz1pJvEDbvyE/M
         XFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520702; x=1789125502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ru9Oqw83JdPP5GZWzgBwRJbCsmncN29/3DvUioCkWHY=;
        b=R6MUG54KN78oihqmZPY4t1P5XxS83ib9nJBAB4luxB6naADlqtLu082GidzlLQri0r
         75S9TKojicL4wzz1/VLSdJWNBkKBaPJZLLcY0T2bvhtm2nXbUr4vnqsbmru8xm/EBM6e
         RkLR9UUb/F/o257WWfq8a7h5xHddRTI1RmvLAXwjIXuWccnCwITZlQ4gpF5x7OR/cbB/
         0RNSQfPcmfhlQbK9XPZ3Eg66c5rzJBd129xZGKa82pGee1F6oGnyOQA5lDvqlSLsVmFR
         KrLDfF8DnXo4v0UOJWnwXkxcbmNKdgwcaVAVvKBKEQ//lRQALVd80rNRP444SX/QucSD
         2gTg==
X-Forwarded-Encrypted: i=1; AKwUvByNUzhwPn5rHLoBtPIfZMSiYyQTu5qHQ/HmvV6MzYUJQcMqIj9M6ex/QHNrODPOb8B9gdq9seo0gOY3@vger.kernel.org
X-Gm-Message-State: AFuF++lWsf6H2sgKTJLV5XbVujraJap4yEwZ9LHxmcD+7b9G7yoXVEGC
	w/s69ZXfs30ujuKcmcqtTfDeqiblOK1pbiFy6OrrGGa1WtvG4Ia5isRt
X-Gm-Gg: AYBFou17X0lBMyZ43zsTpB6p83nb45xeUFXsQ+HUp/Uz/Hh6bPR8c48tq41z2f++T1W
	nLmPgGsAROM9JETALPtcd19GvYroQ83kJ+kbjllBwSJW84fXNWLcP9ybHMU/HjJiyIkMyfgN16K
	Yn7KRVcPy75k7Lw4VfQXy38pQnTpgZ213QSCpVBYiYkQO/sucHJHAxg4N/s8L5P6C/Db4FO+dQr
	Smbn/drHeJeLrEhqfW1yN0MCfgU7pps/8C+wLYHowOGbz7v6YHgkDu65iqjmmdQ/0yaoFbViHpp
	fqRF837qtpy/WTfZ4J9R6X0vGaiYGXq53YHjI+mxdEPY3caK1Nh8lrH5xIF7sBeAcmBL7wo36S0
	4qQrsYMFCLKKXis+QB9dXZ19bvXpOxctTNyuSV8mco1dMLq6opDbBekOLenyCJeU8LbSpCxrhNe
	wyV5+3RXW4enRQu52fNkASz9bQYm28TMjKuVVSU3ST6vr/gg7vjaLXru2jEKgddx5h575Axt7rg
	8xYNXV3EkW47FE=
X-Received: by 2002:a17:90b:2b4e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39b261d0d8emr8546870a91.15.1788520702508;
        Fri, 04 Sep 2026 04:18:22 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm6304088eec.12.2026.09.04.04.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:18:22 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH] driver core: fix typos in comments
Date: Fri,  4 Sep 2026 16:48:14 +0530
Message-ID: <20260904111816.31254-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/base/property.c        | 2 +-
 drivers/base/transport_class.c | 2 +-
 include/linux/kernfs.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b136c339ddae..d8152fee72c3 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -705,7 +705,7 @@ bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
 EXPORT_SYMBOL_GPL(fwnode_name_eq);
 
 /**
- * fwnode_get_parent - Return parent firwmare node
+ * fwnode_get_parent - Return parent firmware node
  * @fwnode: Firmware whose parent is retrieved
  *
  * The caller is responsible for calling fwnode_handle_put() on the returned
diff --git a/drivers/base/transport_class.c b/drivers/base/transport_class.c
index 351c3d3ce6a0..2bee796601ed 100644
--- a/drivers/base/transport_class.c
+++ b/drivers/base/transport_class.c
@@ -7,7 +7,7 @@
  *
  * The basic idea here is to allow any "device controller" (which
  * would most often be a Host Bus Adapter to use the services of one
- * or more tranport classes for performing transport specific
+ * or more transport classes for performing transport specific
  * services.  Transport specific services are things that the generic
  * command layer doesn't want to know about (speed settings, line
  * condidtioning, etc), but which the user might be interested in.
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 351a5101c862..73786b567ccd 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -309,7 +309,7 @@ struct kernfs_ops {
 	 * write() is bounced through kernel buffer.  If atomic_write_len
 	 * is not set, a write larger than PAGE_SIZE results in partial
 	 * operations of PAGE_SIZE chunks.  If atomic_write_len is set,
-	 * writes upto the specified size are executed atomically but
+	 * writes up to the specified size are executed atomically but
 	 * larger ones are rejected with -E2BIG.
 	 */
 	size_t atomic_write_len;
-- 
2.48.1

