Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A43947A2;
	Fri, 20 Mar 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003002; cv=none; b=bCHZ1VoI/TEYe08z4sHbO2ZttFHT829iA1Nu1dDGg+Clg/VoEU+/SvEaVfkiAedD+AQEYSubEJBCOdwlk+v5HDL5R7Q8kuTB2lnyW9b4eTLUp1XEzg8Z6mFo6XnYRsvMNNdI5F4y61+RggQ/c9GxnBsYcrTvoSwo/5Hx/BwKFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003002; c=relaxed/simple;
	bh=rw/vZoSDV/0oCnGps+KD/PKRiA3QszJqxFdv4qMBW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNqdLy/t1+ak92jteDyIYdhNIOXW2UlMFKb/49Kg9Wcnf/hAzSVlTkyMUuY/c9rpa1bcfTfkaZ33VdBNVGDpaJ7tHk4XBX6GZceKHHqybzQRC8dVyqy8gocJd+TUpr9Pa1+vJxT+IlmwBbbxElFK73pFXPQc8g5ofCnejfhYztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOSbyfMI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOSbyfMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEE6C4CEF7;
	Fri, 20 Mar 2026 10:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003002;
	bh=rw/vZoSDV/0oCnGps+KD/PKRiA3QszJqxFdv4qMBW9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOSbyfMIfgJrsh80PyjjY9iSXA2lqoTzQiaBqK1PfDoiVjP9gQe5O5OcrhLFmYJCq
	 0zfZBho6+VeNvdsCqef5RDBMQdKQkv/dRVTqtuJSKSW9jSF28mh2N/258kfxb4872L
	 D02Mhw6OedYVe+KM7upzR5Q7bOA66b6z+0d3nqar56Q9KqI8Nv1gV3Jf9fbF25N2YJ
	 tsrL01kz6uWG/Xhe4HZl31J8uId3Zw3G5mlf+XkEZmIhzt8Bfs2WQPLbd9mMdl+7zi
	 CrzBbTdvKCyl7NwAh0KVmzABqx7eEnnvwkPWxvBnOg7uVxLemSz9rrFp9Ob68mfYR1
	 fmdgzF1p9nlhw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v4 3/5] platform/x86: panasonic-laptop: Remove redundant checks from 3
 functions
Date: Fri, 20 Mar 2026 11:33:03 +0100
Message-ID: <1957824.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983583.DvuYhMxLoT@rafael.j.wysocki>
References: <5983583.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The device pointer cannot be NULL in acpi_pcc_hotkey_add() and
acpi_pcc_hotkey_remove() because these functions are ACPI driver
callbacks and NULL is never passed to any of them as an argument.

Likewise, acpi_pcc_hotkey_resume() is a resume callback of a
device driver and NULL is never passed to it as an argument, so
the dev pointer in it cannot be NULL.

Moreover, since acpi_pcc_hotkey_remove() and acpi_pcc_hotkey_resume()
can only run after acpi_pcc_hotkey_add() has completed successfully,
the acpi_driver_data() of the device object used by them cannot be
NULL when they run.

Drop all of the redundant NULL checks of the pointers mentioned above.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v4: No changes

---
 drivers/platform/x86/panasonic-laptop.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 56b4e61d7e5c..188ec597a14e 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -965,14 +965,7 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_pcc_hotkey_resume(struct device *dev)
 {
-	struct pcc_acpi *pcc;
-
-	if (!dev)
-		return -EINVAL;
-
-	pcc = acpi_driver_data(to_acpi_device(dev));
-	if (!pcc)
-		return -EINVAL;
+	struct pcc_acpi *pcc = acpi_driver_data(to_acpi_device(dev));
 
 	if (pcc->num_sifr > SINF_MUTE)
 		acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
@@ -994,9 +987,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
-	if (!device)
-		return -EINVAL;
-
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	/*
@@ -1121,9 +1111,6 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 {
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
-	if (!device || !pcc)
-		return;
-
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
-- 
2.51.0




