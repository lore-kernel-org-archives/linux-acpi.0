Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64851377EBF;
	Tue, 12 May 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599017; cv=none; b=AWK0eeCsJ105+kVoAnR4Gg1hfdGW8TysxyQip7s7hizbDbv7ThSL+IWUwtNbXGpDXO63W3lLEVKaWwhdAybFAmJSTEI8TNhv1mKE4HYt4sVKeL+rmAsRv/XkiqliKYwnKRH87hdDI5aNj6r/oUZRwMWYM1D3127Y8MfwM/ejZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599017; c=relaxed/simple;
	bh=AVbeg3iUa0Gm4jlRL7QQag/0sAm6axOdGDxMnJdjwAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZI5yW/FhpjtJeVreZCoSwP14CUD4CwNBwjsOwlFJOkQTNMW0RH4Ij1e3XUycqPaXA5M/pKhjnMl9n/I6EK62/fn9L5Y8H6U5TuDZJieTzucewb8LQjFjuRNl/kcLvvnuYRtX7pov4ahNJrw37OAlSiFsiboa1qhnXw2fg2hBw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bthFZYU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bthFZYU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2558BC2BCB0;
	Tue, 12 May 2026 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599017;
	bh=AVbeg3iUa0Gm4jlRL7QQag/0sAm6axOdGDxMnJdjwAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bthFZYU9QJoHMHQRUx8ZV5CeG1+phQ5I1OVNV3eAjbBhHGmMoG/v8VqHjLddVnQA1
	 jFTPOuvfyfSqdJ6WFKk/+b0kRv36H/HUwhaBP1gz09BDCTHav1XqQnXu/QztEalNEz
	 ZOzCYkAbZ7TzGTvol3VBYKqHASgbjcdYeccYQ6z9Ok9TLj3wFVIVXf9D+s65M0Byq7
	 /rws7u9F49Oo96G/R9Spi4JqLQKCnAvdCwgPsVWV81vCzRec6eK/IFaOJpQmk9icDK
	 PBzvUvGc/lYKtfalT9fs7shzXF2bWnzPKC5HFGhHzT44Bg0qT3z+sdlL4g8/+wLKW2
	 uJZeoKb3yXqzg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>,
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>,
 Shravan Sudhakar <s.shravan@intel.com>, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v2 3/5] platform/x86: intel-hid: Check ACPI_HANDLE() against NULL
Date: Tue, 12 May 2026 17:13:28 +0200
Message-ID: <1971512.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6007701.DvuYhMxLoT@rafael.j.wysocki>
References: <6007701.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 intel-hid driver.

Fixes: ecc83e52b28c ("intel-hid: new hid event driver for hotkeys")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/hid.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -688,12 +688,16 @@ static bool button_array_present(struct
 
 static int intel_hid_probe(struct platform_device *device)
 {
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	unsigned long long mode, dummy;
 	struct intel_hid_priv *priv;
+	acpi_handle handle;
 	acpi_status status;
 	int err;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	intel_hid_init_dsm(handle);
 
 	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_HDMM_FN, &mode)) {



