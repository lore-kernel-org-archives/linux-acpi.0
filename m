Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976421ABBD
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271128; cv=none; b=QA2Mpg2Hxpw3VYQxhIEhPkxH1VdVi0wAyrlwQ5JZX7/hCWSspqnsnKKki5sdastbJTTeyyA4Lx7tJx9ZP4T8VCWsdFLSTcVko2fCgwMJo1UVqagaxZsBxOuFS48rOJIbQL21HNQQu3L6M05tMfSj8vh+8xOb18GWVCZ/CTtY+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271128; c=relaxed/simple;
	bh=PbFmYx7lFeToH8vTyearZMuM2MJuWiTa3xKjv6xFl3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm0ZqEBqMae+XQejQXqmQAnBjaUCPQwRw0Js01tktl8YgKs7LwF32/xWl0d0huVFOPOIuwsgK+vkqwMRC9ba/aHzBoDbLC0Cb53YG2Sq4sWWDmtlr/UzRBD7S+Dle4DqHjzTcPTFTklEDU6oChItl0Nnrqxyju2QVHyqqBdK7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jig4c8Qk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/IPQGbu9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jig4c8Qk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/IPQGbu9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jig4c8Qk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/IPQGbu9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jig4c8Qk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/IPQGbu9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84EEA3E46;
	Fri, 17 Jul 2026 06:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784271117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG/jZOVHXs6yDvAE+cH2YHKUy3jsJ7zcnbDEek97n2E=;
	b=jig4c8Qk579GyFJp61vLQX16ghu+YvEvPx57PE57NasUDscgYwW3p1aSOHnAO/YtmzKe4t
	oTTZpEpkJthBg+9CZBRXI3tkeJo05wkSBdwidFYGimUxIYepL6+Ujk43Ud9CS9X/aOnqD2
	kdUgFztBUC+bDQWpGXFDByb5W5oyn+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784271117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG/jZOVHXs6yDvAE+cH2YHKUy3jsJ7zcnbDEek97n2E=;
	b=/IPQGbu9FK5QQb0+cvXQUzkbqP1v8P4E/K/l6TOQWTR1iashqU+Ru8TDTkGv7yq6tudWpF
	M/5pbGJPyRfc0yAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jig4c8Qk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/IPQGbu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784271117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG/jZOVHXs6yDvAE+cH2YHKUy3jsJ7zcnbDEek97n2E=;
	b=jig4c8Qk579GyFJp61vLQX16ghu+YvEvPx57PE57NasUDscgYwW3p1aSOHnAO/YtmzKe4t
	oTTZpEpkJthBg+9CZBRXI3tkeJo05wkSBdwidFYGimUxIYepL6+Ujk43Ud9CS9X/aOnqD2
	kdUgFztBUC+bDQWpGXFDByb5W5oyn+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784271117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG/jZOVHXs6yDvAE+cH2YHKUy3jsJ7zcnbDEek97n2E=;
	b=/IPQGbu9FK5QQb0+cvXQUzkbqP1v8P4E/K/l6TOQWTR1iashqU+Ru8TDTkGv7yq6tudWpF
	M/5pbGJPyRfc0yAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D5CA779AD;
	Fri, 17 Jul 2026 06:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mCyoFQ3RWWoCYAAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 17 Jul 2026 06:51:57 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Michal Suchanek <msuchanek@suse.com>
Subject: [PATCH 2/2] ACPI: Properly map BERT and CCEL acpi tables to their data tables
Date: Fri, 17 Jul 2026 08:51:22 +0200
Message-ID: <20260717065129.72924-3-trenn@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717065129.72924-1-trenn@suse.de>
References: <20260717065129.72924-1-trenn@suse.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 84EEA3E46
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

In case of multiple BERT ACPI tables one gets:
sysfs: cannot create duplicate filename '/firmware/acpi/tables/data/BERT'

This is because both:
/firmware/acpi/tables/BERT1
/firmware/acpi/tables/BERT2
are tried to be mapped to the same data table:
/firmware/acpi/tables/data/BERT

This patch fixes this problem by passing and using the same filename
for data tables.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Reported-by: Michal Suchanek <msuchanek@suse.com>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1270211
---
 drivers/acpi/sysfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 8395efbe248b..dd4a99f09efe 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -316,6 +316,7 @@ struct acpi_table_attr {
 struct acpi_data_attr {
 	struct bin_attribute attr;
 	u64	addr;
+	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
 };
 
 static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
@@ -453,7 +454,6 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
 	}
 	data_attr->addr = bert->address;
 	data_attr->attr.size = bert->region_length;
-	data_attr->attr.attr.name = "BERT";
 
 	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
 }
@@ -469,7 +469,6 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
 	}
 	data_attr->addr = ccel->log_area_start_address;
 	data_attr->attr.size = ccel->log_area_minimum_length;
-	data_attr->attr.attr.name = "CCEL";
 
 	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
 }
@@ -484,7 +483,7 @@ static struct acpi_data_obj {
 
 #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
 
-static int acpi_table_data_init(struct acpi_table_header *th)
+static int acpi_table_data_init(struct acpi_table_header *th, struct acpi_table_attr *table_attr)
 {
 	struct acpi_data_attr *data_attr;
 	int i;
@@ -497,6 +496,8 @@ static int acpi_table_data_init(struct acpi_table_header *th)
 			sysfs_attr_init(&data_attr->attr.attr);
 			data_attr->attr.read = acpi_data_show;
 			data_attr->attr.attr.mode = 0400;
+			strscpy(data_attr->filename, table_attr->filename);
+			data_attr->attr.attr.name = data_attr->filename;
 			return acpi_data_objs[i].fn(th, data_attr);
 		}
 	}
@@ -543,7 +544,7 @@ static int acpi_tables_sysfs_init(void)
 			return ret;
 		}
 		list_add_tail(&table_attr->node, &acpi_table_attr_list);
-		acpi_table_data_init(table_header);
+		acpi_table_data_init(table_header, table_attr);
 	}
 
 	kobject_uevent(tables_kobj, KOBJ_ADD);
-- 
2.55.0

