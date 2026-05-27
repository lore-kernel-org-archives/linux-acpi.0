Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF747F2F8;
	Wed, 27 May 2026 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905564; cv=none; b=siO4N2fW/70Tflv2lpiShRaXiCpD0yngg/b4B49aEFmuxqxlKf8JVhzqxtqykTZuNIMTFtiBrSx4kcYwX94w7sIRRJ7GRBpMYUxktGMnX44f99vULik8A9ZPMkPcOuXbJq1xaUb+I26sq9nPKoKJ7C7FFouryKlgDiMErG1SSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905564; c=relaxed/simple;
	bh=Og1ZqirlXxVELRCqun1Cf0xULzvfgR+5x5JHMR+Vqo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRRjf8X664Y2vNwkgcEd2FHsV1njaSKy5OB48bOeDdzRMe3bthqjEkeGIQ99wEc8o5nOiDS7VxcIw78Vmw+3mEjIQ6pOhgsLbCl6NwDtwY5lsDigzewZC0116k3r117qvI8dIonMJeJlMOsmm0cnvLMmUl6XUZ+kfykL1gytFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqTVu7hD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqTVu7hD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321561F000E9;
	Wed, 27 May 2026 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905563;
	bh=CdRdsKOPeXO/Cn2ODqXNDpJEkpIZnbkdwi8ZV7MiURc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqTVu7hDfW/oZKvHlvsUzsASMZj4V7v8T6XdWyyZNB8Es6D1opWRMe8NhuNcQC5UV
	 ZFGWWSO03mCWebO/jbcCVvIjjSUdNuEuR09aAQAEVOSNRP0p5fvCqaSOvaU3RlIbFb
	 Yk5TNlcv5kUfXGMoQVhlzaZibOfqUSJ0jtbw+W/dx+7m13rOf7YJXK7LYjFcWrgFHe
	 0qP1Xg4/QHkQM1YNx7fBVNxT6DFh/PZKq5a0DvUn6Qk/PcxEXE1Z7tV73QoJOGvHtv
	 iKoSQtZmIv3UnG/KZzaol2f9vkQ80z9lnB7efAygybX4KVqcrihoNK9R7+Fk100ms0
	 O5aYoM6VLZRdQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 04/27] ACPICA: Add alias node support in namespace handling
Date: Wed, 27 May 2026 19:53:58 +0200
Message-ID: <14020896.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: ikaros <void0red@gmail.com>

 - Mark nodes as alias in ld_namespace2_begin() function.
 - Skip teardown for alias nodes in acpi_ns_detach_object() function.
 - Define ANOBJ_IS_ALIAS flag in aclocal.h.

Link: https://github.com/acpica/acpica/commit/cfcc46c4f717
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/aclocal.h  | 1 +
 drivers/acpi/acpica/nsobject.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index f98640086f4e..cbf09fb08d35 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -169,6 +169,7 @@ struct acpi_namespace_node {
 #define ANOBJ_IS_EXTERNAL               0x08	/* iASL only: This object created via External() */
 #define ANOBJ_METHOD_NO_RETVAL          0x10	/* iASL only: Method has no return value */
 #define ANOBJ_METHOD_SOME_NO_RETVAL     0x20	/* iASL only: Method has at least one return value */
+#define ANOBJ_IS_ALIAS                  0x40	/* iASL only: Node is an alias to another node */
 #define ANOBJ_IS_REFERENCED             0x80	/* iASL only: Object was referenced */
 
 /* Internal ACPI table management - master table list */
diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 79d86da1c892..a4ccacecca53 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -173,6 +173,12 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 
 	obj_desc = node->object;
 
+	/* Alias nodes point directly to other namespace nodes; skip teardown */
+	if (node->flags & ANOBJ_IS_ALIAS) {
+		node->object = NULL;
+		return_VOID;
+	}
+
 	if (!obj_desc || (obj_desc->common.type == ACPI_TYPE_LOCAL_DATA)) {
 		return_VOID;
 	}
-- 
2.51.0




