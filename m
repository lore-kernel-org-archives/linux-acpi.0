Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1541B8F6;
	Wed, 14 Oct 2026 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004762; cv=none; b=T66qCe7Oxqk9cdoMC1UqVgxSyjoBunbAMswojSPSfnD4SShEyM8V1OtDmmwwzbptu7Vseviy0peiY+ijJ+zlixs2/llr8oNvr4akiHY04lNwcPV37BL3xyjDgnzjUxQ5qk/MKt6vZtlKs6s9iFWBrElt7j2LgFpisu2i/yWfm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004762; c=relaxed/simple;
	bh=cFFwZgxIAz797KN9F08BtOyHGb4+W9+w5rCoIbeC920=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPHnoX4Z/SUISGZ9bnKeRMVKNmYjJLxZeBmcX82isH8qdaFXruEvM+XMfbqYDdJy4i6IPwIHJlRTZ5jonMB3sJBjYY2pZM5pzRJnKVQX+PEN0zbe1U9HXX3onw25UurFpf8Ob/kOCoUEw18eBHxjtWmJDUXT+F0+gjVEruN+zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kAteC5Qt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kAteC5Qt"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E6A3C808E7;
	Wed, 14 Oct 2026 21:05:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZC3vkLDG1jv; Wed, 14 Oct 2026 21:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792004758; bh=cFFwZgxIAz797KN9F08BtOyHGb4+W9+w5rCoIbeC920=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kAteC5QtrGz/GVo1zrZ1jt4775cQVl5d1ftvY+T0NoDSV4zOscnh8BTl0wC+rvQgX
	 qsbK367oRJ/MiK6rCJN5IwgQ3gbqlhfT3RweFbntZgsAVSMyPqdU8KbqtsQ+0nX8Ra
	 b0HjgKGH82JkuDcjrqcx2BA591TNmeaZFEPGn/nAxApij2QUFD9QsZ+qff5hbk8Q1J
	 suLPk5sT/9eRNrghcYBzkJKuUNDFkrywyc9h+wMGTPg6rqBFmqQ63DrKOpzWznb7Zl
	 waPH/qt20oFHVN29mKraz7ijuBGQ/amVJRZHSqNlaGFHtWJxdq3xWhrtFWZS7RZtDX
	 76jrYcoh97ohw==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Len Brown <lenb@kernel.org>,
	Ike Panhc <ikepanhc@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Rong Zhang <i@rong.moe>,
	Armin Wolf <W_Armin@gmx.de>,
	Avraham Hollander <anhollander516@gmail.com>,
	=?UTF-8?q?Jeffrey=20W=C3=A4lti?= <jeffrey@waelti.dev>,
	Rick <rickk1166@gmail.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ACPI: utils: Add acpi_evaluate_dsm_exclusive()
Date: Wed, 14 Oct 2026 22:04:53 +0300
Message-ID: <20261014190544.150093-2-aliamemis@disroot.org>
In-Reply-To: <20261014190544.150093-1-aliamemis@disroot.org>
References: <20261014190544.150093-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an exclusive variant of acpi_evaluate_dsm() for _DSM methods that
are known to break when interleaved with other AML.

Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/acpi/utils.c    | 54 +++++++++++++++++++++++++++--------------
 include/acpi/acpi_bus.h |  3 +++
 include/linux/acpi.h    |  8 ++++++
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f28680424f14..32689c901564 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -799,23 +799,9 @@ acpi_status acpi_evaluate_reg(acpi_handle handle, u8 space_id, u32 function)
 }
 EXPORT_SYMBOL(acpi_evaluate_reg);
 
-/**
- * acpi_evaluate_dsm - evaluate device's _DSM method
- * @handle: ACPI device handle
- * @guid: GUID of requested functions, should be 16 bytes
- * @rev: revision number of requested function
- * @func: requested function number
- * @argv4: the function specific parameter
- *
- * Evaluate device's _DSM method with specified GUID, revision id and
- * function number. Caller needs to free the returned object.
- *
- * Though ACPI defines the fourth parameter for _DSM should be a package,
- * some old BIOSes do expect a buffer or an integer etc.
- */
-union acpi_object *
-acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
-		  union acpi_object *argv4)
+static union acpi_object *
+__acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
+		    union acpi_object *argv4, bool exclusive)
 {
 	acpi_status ret;
 	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -840,7 +826,10 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
 		params[3].package.elements = NULL;
 	}
 
-	ret = acpi_evaluate_object(handle, "_DSM", &input, &buf);
+	if (exclusive)
+		ret = acpi_evaluate_object_exclusive(handle, "_DSM", &input, &buf);
+	else
+		ret = acpi_evaluate_object(handle, "_DSM", &input, &buf);
 	if (ACPI_SUCCESS(ret))
 		return (union acpi_object *)buf.pointer;
 
@@ -851,8 +840,37 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
 
 	return NULL;
 }
+
+/**
+ * acpi_evaluate_dsm - evaluate device's _DSM method
+ * @handle: ACPI device handle
+ * @guid: GUID of requested functions, should be 16 bytes
+ * @rev: revision number of requested function
+ * @func: requested function number
+ * @argv4: the function specific parameter
+ *
+ * Evaluate device's _DSM method with specified GUID, revision id and
+ * function number. Caller needs to free the returned object.
+ *
+ * Though ACPI defines the fourth parameter for _DSM should be a package,
+ * some old BIOSes do expect a buffer or an integer etc.
+ */
+union acpi_object *
+acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func,
+		  union acpi_object *argv4)
+{
+	return __acpi_evaluate_dsm(handle, guid, rev, func, argv4, false);
+}
 EXPORT_SYMBOL(acpi_evaluate_dsm);
 
+union acpi_object *
+acpi_evaluate_dsm_exclusive(acpi_handle handle, const guid_t *guid, u64 rev,
+			    u64 func, union acpi_object *argv4)
+{
+	return __acpi_evaluate_dsm(handle, guid, rev, func, argv4, true);
+}
+EXPORT_SYMBOL_GPL(acpi_evaluate_dsm_exclusive);
+
 /**
  * acpi_check_dsm - check if _DSM method supports requested functions.
  * @handle: ACPI device handle
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e7a671dba624..e9859fdf76e8 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -66,6 +66,9 @@ bool acpi_dock_match(acpi_handle handle);
 bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
+union acpi_object *acpi_evaluate_dsm_exclusive(acpi_handle handle,
+			const guid_t *guid, u64 rev, u64 func,
+			union acpi_object *argv4);
 #ifdef CONFIG_ACPI
 bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812094..6a798d5bde5c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1042,6 +1042,14 @@ static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,
 	return NULL;
 }
 
+static inline union acpi_object *acpi_evaluate_dsm_exclusive(acpi_handle handle,
+							     const guid_t *guid,
+							     u64 rev, u64 func,
+							     union acpi_object *argv4)
+{
+	return NULL;
+}
+
 static inline union acpi_object *acpi_evaluate_dsm_typed(acpi_handle handle,
 							 const guid_t *guid,
 							 u64 rev, u64 func,
-- 
2.55.0

