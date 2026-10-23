Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741612;
	b=FdZMu9e+j/35rkhRHgsSsX87yB7iHKzrwUYP7FN+aLr8DFX4ouRyor/HOf5fOetpeDgc
	 GasutgFy1/MS4u+ACskk7lqeIuPtl/uOB7EvXssRu3iZJGYSEDgb2QNHuB3/fWdXMroLd
	 uy9TzK9hes06Eu+1SmZSIMZSq098s3L1nivf+XyRSCG5MleU6r7JONfkq/PeK8/Fzdr20
	 7T7Fd7mgignn7zSMVJS98z36O7blG7sxpK3+R/xYYGAnuKd+q77kuFFX2lgXsFNwaBT8P
	 QWY3jB/Syemoc6kQlcXV2njr6MkmcVUT8pLGssut+6cpNDGIhSfqpJfoiVdJbfkT1rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i1/WuK8dW5/pyvLMu4dA8Lh0jH9UtF3/CqDkw4QhSPY=;
	b=Wqu/gRE5tA7adro5mKr7jWd4bdlh8cJH1DYT5Ggl8x/LVk0A8G2Go7YKet8yk8wmkCfz
	 oa6B5LamE8Xlih7V8NSbvrUYWo3YlVA2zLVhggHRHEPR7oRzHjxU9c6f18lLjOebjM2u4
	 xa6p/qtfCEF9sTTkb6n0CtEG00S6a1HWQe/t1V+CM6fS72szCo6DQRk6sTIVzcA+K2FFE
	 isnYwx1DJmh1jf+P8r8HAFaDAqEwrtMyCh1g1c/WhF3nDEmzKMlEiG9Fl2069b4iFc/dn
	 zANucswioDh+lcH4R1ITXpc+zzcKKvLUOtZ70vSB1cYNXKTQHHyb4tVbkb05bs7+9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="gLUVI/dI";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885B606A31A
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 07:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B885B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gLUVI/dI
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so1412686eec.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741611; x=1793346411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i1/WuK8dW5/pyvLMu4dA8Lh0jH9UtF3/CqDkw4QhSPY=;
        b=gLUVI/dIEd9vBiMkDhXsj8+YVnMcrVQsxvJ5ik4bFIFFJ4z8mLo/KqLzkbhwS+/osh
         fI0QmxElIyjO4ODs4QICbt7cP4pQreas0g1/RDyGQ/VebbKcpMmfQZz7J/QaK8JgXcBX
         Gb+unwyAkDA8yfosvfGIk+ML/qeQACYS50a8EZxWFM8WJJ5M9hVD47CBEmltbbLxw/Dw
         TEaxWugn4zyoWNvDjfiVS9KplYxVi9AxV00p5SQ1yeBUa50HsUdeW4h8vTjYbkXMkjL1
         pOJNW935Ai8d7sQkqOfsSqDcgRKX+VIXGFFdcMiF88Cwgx3Cm8beKQ/mKorPCZuyfEd2
         CC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741611; x=1793346411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i1/WuK8dW5/pyvLMu4dA8Lh0jH9UtF3/CqDkw4QhSPY=;
        b=0XgEWEbNDZypSsx+XZipo2yLKL3kyhlZItxBZM/S+rRAkvsTMk7rCrlZ8mSofhPlKC
         ACSErgAvgUpAK63xDzPOcHCX9KpGzyqDGK1zVFTkWJ8EurhLkPvD82w7ixGLr4Dwhzlj
         4M/OAFkj747KcrneSv2eR/O2mpaI3yyvPWf1+Y5YE52DJYcckUoyhvx+i/2MAcimy0vZ
         nMqq0LV5oxsnvOS8ix/gwCueetKq5OA+1eFMsOEnMMgKR3uETIllC9jtg58YAZweHdda
         tJm5pu8LhKwLvcXIqjE2fRbQwjO9Atc8G9bhXJFmFsRsJIQVqWoodAg4DpU0eS/0HhLL
         webA==
X-Forwarded-Encrypted: i=1; AKwUvByuf8jcgRHg6dPK6uun54hJRKRxCuMzdrTeWhOxuE7/IXC5ghso2KMnhwZxyaZlERXqFp7uWvcAL/Cg@vger.kernel.org
X-Gm-Message-State: AFq9FYI6X0oAY2gN3vvkxr5IEffBLP0PE/m0KevEmzy3peABwivTSpLj
	H8I+ywlo9s/hWzhlc91EMH2Wel2qHaN1wjdbG4TE0EllQD6gJngBegN6
X-Gm-Gg: AYBFou0qvnOeF6EXPV3cD2LvplxhaMc7dppkr9JdV8ZokLzibm3CNG9YW7nlwRpITeL
	KxCqi6jdsGEkEBUwOG5ZZ4x0S7iXCJ1gSSEwfYKX3FXoium4nkhafhPFrf0LCPwsUNzkceKZAX7
	7vWzEcQH3ToUoQA4yhOPSPDzR8btdhR37GxgYfxD3TyYxawelXgX4XsXgky5BvCX26YQCfv64lO
	gibxbgXX1KqtyApVsdGASFNrbuAcISwbqP9FpYY44yvL/i3Jm1aovuuw6QyQSj8LHKc/kA6KmHY
	uBkW1ASNi0cfBg0mcmICm+tUunee2baVVWx357rY7+Lo2pUznNZVqpKMv3++DnOiW0fCFmkRAUq
	uqQAo3z5/7mcSkL8rgdkgKHoeYDuSW9XFFQg2xfupOG0G56ssdDhFWF1xAvN1WfdOBByc+0aeFF
	V/BROWQCjg3neBOfWPoyvZiHF3OsrfhLPruv88KC2CK0ZBD+exz3RGXgL8xHcIRVgiX1j1r+wre
	W0RKb15KX3ZM/OHyqg1nQK8DikN8VbJ8G90ivjC6NLxYRv62Jf03OC6uq7Ky+bxs7k=
X-Received: by 2002:a05:7301:619b:10b0:35d:7565:8577 with SMTP id 5a478bee46e88-369d980cabamr1885558eec.15.1792741610605;
        Fri, 23 Oct 2026 00:46:50 -0700 (PDT)
Received: from Hruday.lan ([2409:4091:903b:c404:6995:b26d:3edb:5202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9a72ff2sm4479935eec.0.2026.10.23.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:46:50 -0700 (PDT)
From: Rahul Rao <shreeramrahul94@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com,
	Rahul Rao <shreeramrahul94@gmail.com>
Subject: [PATCH] ACPI: ACPICA: Fall back to inline recursion if update state allocation fails
Date: Fri, 23 Oct 2026 13:15:02 +0530
Message-ID: <20261023074502.103681-1-shreeramrahul94@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When acpi_ut_update_object_reference() traverses nested package elements
or field elements to increment/decrement reference counts, it allocates a
temporary union acpi_generic_state via
acpi_ut_create_update_state_and_push()
to avoid deep C stack recursion.

If memory allocation fails (for instance, under slab fault injection),
the function aborts mid-traversal. This leaves sub-object reference counts
out of sync with parent containers. Callers cannot readily roll back the
partial updates, leading to reference count underflows and slab
use-after-free bugs (such as in acpi_ns_check_package()).

Fix this by introducing acpi_ut_push_or_update_object(). When allocating
a deferred update state fails, fall back to inline recursive traversal up
to a safe bounded recursion limit (ACPI_UT_MAX_UPDATE_DEPTH = 16). This
ensures reference counts remain consistent even during severe memory
pressure.

Reported-by: syzbot+e1268acad3c273b12120@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e1268acad3c273b12120
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Rahul Rao <shreeramrahul94@gmail.com>
---
 drivers/acpi/acpica/utdelete.c | 78 +++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index e8180099d01f..87ae66c7eee8 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -20,6 +20,14 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object);
 static void
 acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action);
 
+static acpi_status
+acpi_ut_update_object_reference_depth(union acpi_operand_object *object,
+				      u16 action, u32 depth);
+
+/* Max inline nesting used when a deferred update state cannot be allocated */
+
+#define ACPI_UT_MAX_UPDATE_DEPTH	16
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_delete_internal_obj
@@ -457,6 +465,28 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 	}
 }
 
+/*
+ * Queue an object for a later reference count update. If the update state
+ * cannot be allocated, update the object right away instead of failing: an
+ * update abandoned half way leaves the counts of the sub-objects out of
+ * step with the count of their parent, and callers (most of which cannot
+ * handle an error) would later drop references that were never added.
+ */
+static acpi_status
+acpi_ut_push_or_update_object(union acpi_operand_object *object, u16 action,
+			      union acpi_generic_state **state_list, u32 depth)
+{
+	acpi_status status;
+
+	status = acpi_ut_create_update_state_and_push(object, action,
+						      state_list);
+	if (ACPI_SUCCESS(status) || depth >= ACPI_UT_MAX_UPDATE_DEPTH)
+		return status;
+
+	return acpi_ut_update_object_reference_depth(object, action,
+						      depth + 1);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_update_object_reference
@@ -480,6 +510,13 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 
 acpi_status
 acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
+{
+	return acpi_ut_update_object_reference_depth(object, action, 0);
+}
+
+static acpi_status
+acpi_ut_update_object_reference_depth(union acpi_operand_object *object,
+				      u16 action, u32 depth)
 {
 	acpi_status status = AE_OK;
 	union acpi_generic_state *state_list = NULL;
@@ -560,8 +597,9 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 					 * for later processing (this eliminates recursion.)
 					 */
 					status =
-					    acpi_ut_create_update_state_and_push
-					    (next_object, action, &state_list);
+					    acpi_ut_push_or_update_object
+					    (next_object, action, &state_list,
+					     depth);
 					if (ACPI_FAILURE(status)) {
 						goto error_exit;
 					}
@@ -579,31 +617,23 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 
 		case ACPI_TYPE_LOCAL_BANK_FIELD:
 
-			next_object = object->bank_field.bank_obj;
-			status =
-			    acpi_ut_create_update_state_and_push(object->
-								 bank_field.
-								 region_obj,
-								 action,
-								 &state_list);
-			if (ACPI_FAILURE(status)) {
-				goto error_exit;
-			}
-			break;
+		next_object = object->bank_field.bank_obj;
+		status = acpi_ut_push_or_update_object(
+				object->bank_field.region_obj, action,
+				&state_list, depth);
+		if (ACPI_FAILURE(status))
+			goto error_exit;
+		break;
 
 		case ACPI_TYPE_LOCAL_INDEX_FIELD:
 
-			next_object = object->index_field.index_obj;
-			status =
-			    acpi_ut_create_update_state_and_push(object->
-								 index_field.
-								 data_obj,
-								 action,
-								 &state_list);
-			if (ACPI_FAILURE(status)) {
-				goto error_exit;
-			}
-			break;
+		next_object = object->index_field.index_obj;
+		status = acpi_ut_push_or_update_object(
+				object->index_field.data_obj, action,
+				&state_list, depth);
+		if (ACPI_FAILURE(status))
+			goto error_exit;
+		break;
 
 		case ACPI_TYPE_LOCAL_REFERENCE:
 			/*
-- 
2.43.0

