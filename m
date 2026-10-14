Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9B439F98;
	Wed, 14 Oct 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004768; cv=none; b=s1Im3yqKoeJ30+o2Cod/fHm2wxkIlOLg1x6uQoYRAa0QFkps3fyPXA0lCNjnFjYfh+TXPYl6r9j129lxPf9QuIqypT5ApqHA1Zevoz+o5zg39hLKNMyrlSEEw7QIo3h2CWAdGC4K5ue4r7SFz1WJ5vYXuxiPNrGMQvPFNCdi4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004768; c=relaxed/simple;
	bh=iOMqq/Aql5HQYwy8RDlMxfLS6GIra/wB+BM0yO3d7vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8cpRzHeGOoaY+A1rv8eweoq8tgzRXtvywBLrLTFSYP0iknHO9JJIM7IypRE9kBVo1Mx3SAhjsCCjkfeugXMW17h+PqXfNB53nUGEL/J1QJRqtAjWb6PhDCCLSqCdTwTBDsGIgVJApLfajYyC+0HkEk8OuM4T4MLtFica4WW+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=K75KS2X3; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="K75KS2X3"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F02C182BB0;
	Wed, 14 Oct 2026 21:06:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oneN6XmYC5wJ; Wed, 14 Oct 2026 21:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792004762; bh=iOMqq/Aql5HQYwy8RDlMxfLS6GIra/wB+BM0yO3d7vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K75KS2X3r6b+ZpJogUU2BFHMOcLORNJpR7RHjPvVDOxybqcSxnUWluNpPL02Xc09V
	 /z/zd/SYs5pYjeB1tfkJb0qt3G8c92mkQ9ktsSRazsf4V06SmukD4RoAkQMYnMfJLq
	 eiJGj41NKYhrbS+ptZexxEyMD9SchrXVHLqSLCO6Ur/xiWrHpZxfu+5tnKCxdEj4rp
	 jwbFHITaOofHMZeP0zeU+lPodfqtK/cwIFLibbiaxXtyUHs/tvgPoHzXwYfDiYcPqB
	 4wP9y2mCpcMS57fk0fwCyUYOpXXr1XDowihra8bIAnf4Arho9jhtImN5a05WkYl7qO
	 uW1zcKCqqyNSQ==
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
Subject: [PATCH 4/4] platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
Date: Wed, 14 Oct 2026 22:04:56 +0300
Message-ID: <20261014190544.150093-5-aliamemis@disroot.org>
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

On some Lenovo IdeaPad and Yoga models, GBMD, SBMC, SALS and DYTC hold a
shared AML mutex while waiting for the EC to finish a command, long
enough for the UCSI and _Qxx methods waiting on it to time out.

Evaluate all methods with the exclusive helpers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 21 ++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 8213524504ee..9fb842e6383d 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -297,12 +297,18 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
 #define IDEAPAD_EC_POLL_MIN_US 150
 #define IDEAPAD_EC_POLL_MAX_US 300
 
+/*
+ * Some of these methods hold an AML mutex shared with the UCSI and EC
+ * query methods for long enough for those to time out, so evaluate all
+ * of them exclusively.
+ */
 static int eval_int(acpi_handle handle, const char *name, unsigned long *res)
 {
 	unsigned long long result;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(handle, (char *)name, NULL, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, NULL,
+						 &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -324,7 +330,8 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = arg;
 
-	status = acpi_evaluate_integer(handle, (char *)name, &params, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, &params,
+						 &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -336,7 +343,13 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 
 static int exec_simple_method(acpi_handle handle, const char *name, unsigned long arg)
 {
-	acpi_status status = acpi_execute_simple_method(handle, (char *)name, arg);
+	union acpi_object in_obj = { .type = ACPI_TYPE_INTEGER };
+	struct acpi_object_list params = { .count = 1, .pointer = &in_obj };
+	acpi_status status;
+
+	in_obj.integer.value = arg;
+	status = acpi_evaluate_object_exclusive(handle, (char *)name, &params,
+						NULL);
 
 	return ACPI_FAILURE(status) ? -EIO : 0;
 }
@@ -394,7 +407,7 @@ static int eval_vpcw(acpi_handle handle, unsigned long cmd, unsigned long data)
 	in_obj[1].type = ACPI_TYPE_INTEGER;
 	in_obj[1].integer.value = data;
 
-	status = acpi_evaluate_object(handle, "VPCW", &params, NULL);
+	status = acpi_evaluate_object_exclusive(handle, "VPCW", &params, NULL);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-- 
2.55.0

