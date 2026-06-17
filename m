Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B0407CC8;
	Wed, 17 Jun 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703237; cv=none; b=P+9oGzjw75xyC/jdXbhFdA14f1LqAjze3AMFafk92FCpCMVcl9Hv8xBGiUrdAL7pjhdL3poPrDUB+MOVKlrb33itrVm/gEGz+hlpSsWcPwsJu88VyTg28uJBCxrQNlwZLdLWJ2jdqiRSsF41mmKg5BOBeHQh86LMH4w9vULlOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703237; c=relaxed/simple;
	bh=DCcwS/Af0/gCwvOSwGbr70DNuzjaSOMbXeG1pza3/9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8n4tt6mWF0oqwV/c7W3ZwADp1euzJV3MxMS/c9i03CikXJ5RtCbHwn9GjYODc1mJAaivp3p9q6yollGWItON1p4axypeGUYwaRKbXzbElz/IIG46i84InzX9v26DzRoEl6CpFZFi6mDUgOD3RMnqGLoi/mVYVNuLcamll1fg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kl+w8DmB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kl+w8DmB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=SlTP4v2bni27T+dN93Gnu5TExfReIwH1JsMfVrv7mfM=; b=kl+w8DmBKc4wQhjE7PZ3ca0tgu
	J/sxm4NzcJ8Bm6zSz2NFpOXIsaydQ32wMDMTDYbmgSASLUX40RMK0J/ZtXFQbv/NbAHiZr8o2ScnK
	3WJo5Hkl+ZqmShN1lQwI//Yfl9xgdV9mX8Ui7TJhg5kAJvganCx7yr0OHvbcIIpqexpJyyVXXGh1t
	/EjKsyMmiGuRaffcFC63apK4Eb7AxHGPrKKuGlX9L+wDmmcuMKgTfODyIXsDvMUEH7qB4TtICXgm0
	ooyhUuaCO869KfHnETOi0Xy6DfKnGoc8w5GuEc7EtXPyFff9kFk2uYR3KeJX3813am+7di5+ODDcu
	iN/olMMA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZqOk-00EeVE-1T;
	Wed, 17 Jun 2026 13:33:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Jun 2026 06:32:48 -0700
Subject: [PATCH 2/2] vmcore_info: track fatal hardware errors
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-hwerr-v1-2-ff131cd6203c@debian.org>
References: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
In-Reply-To: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 riel@surriel.com, caggio@meta.com, kexec@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=leitao@debian.org;
 h=from:subject:message-id; bh=DCcwS/Af0/gCwvOSwGbr70DNuzjaSOMbXeG1pza3/9A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMqIkHd3YyPVlkIneRAlRDF0MNSBVdeDObpXEj
 5pGdayCaROJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKiJAAKCRA1o5Of/Hh3
 bZQoD/474ejbOPMswWEZKvzjO5yiWKb7EtubDsMelEZDSF2C+kjeJQdIQhd1xwvjtuI3tPVVvSk
 jOKouxMf7XcYmbcXXLzmyP6lyYiOh9sQM7zSpwP/OLksDhsDZA4btJivk4yVqfbSf/2qCmR/wUz
 vfcp9kDDzYunhKjcdRF9lvV2BBWdeC0kHA5jtczl4fzE4ZFkQqq0t5Lkj+iCCxEpT+GyH4447zS
 4GLmqCmyJQS8EAqOuaUQe0ZXANh0QniWjuj/v8RBnwlCXKE7oFbC3+OAP3PfulU0Qo+VAcAXW5y
 vHOkicdeRGVFqhmZQS+i0x4P0yryhPe55IPzQ4542vPNNv+mpIynY/n+2pgFsMiWu/Y/sJWBpwr
 RnHFSISfFR7Go7jjfkODBFQEC7+eAjBl9r17drmAIQlUrmOD5E0U+uKuTSYd93XvonH+1pY8E6T
 oYzoQaiCJVU9O0xTN4GWhm7CBlfgITd9jBKWojCUlphPOwUIewnyLeTdcvHkPEpxks9L5GvzI/n
 td4Qn31FS+qC0QNmak9d6jOkVVyZcPtMKpfaYd20FW/Te/bIIcbsyQxNhsdi5jKrCX4+QiVEtwT
 T4dJJjTovGiEHQMfYwUWfWR4JHS8V+cKF3rYwu+gshXGk4wLIXnmx9m+cO17mUXF3bu6BQhOZDq
 ru8b7DMx1P8Gsfg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Fatal (panic-severity) hardware errors reported through APEI/GHES are
the ones most likely to have caused a crash, but hwerr_data did not
record them.  Add a HWERR_FATAL bucket and bump it from
ghes_log_hwerr() when a GHES_SEV_PANIC error is seen, so crash tooling
can tell from the vmcore that a fatal hardware error preceded the
crash.

Tools reading hwerr_data gain one entry (HWERR_FATAL).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c    | 5 +++++
 include/uapi/linux/vmcore.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0f9f1529e7aa..5a9e16bdca2b6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -877,6 +877,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
 
 static void ghes_log_hwerr(int sev, guid_t *sec_type)
 {
+	if (sev == GHES_SEV_PANIC) {
+		hwerr_log_error_type(HWERR_FATAL);
+		return;
+	}
+
 	if (sev != GHES_SEV_RECOVERABLE)
 		return;
 
diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
index 2ba89fafa518a..c774b037603e2 100644
--- a/include/uapi/linux/vmcore.h
+++ b/include/uapi/linux/vmcore.h
@@ -21,6 +21,7 @@ enum hwerr_error_type {
 	HWERR_RECOV_PCI,
 	HWERR_RECOV_CXL,
 	HWERR_RECOV_OTHERS,
+	HWERR_FATAL,		/* fatal hardware errors */
 	HWERR_RECOV_MAX,
 };
 

-- 
2.53.0-Meta

