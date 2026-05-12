Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1DD37C900;
	Tue, 12 May 2026 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599021; cv=none; b=ZqTKdP6/cwCI2449cGCbvxlQfK0P+yRGumv4UYHA6FJBX0e3WAKO7Kgy7hOB08A/sfROvsw6qWV1Hr+9iJV5eE97Jb+oMjnV6Sk+GrzcNuQL5esdgpLA+JEx+nOFB+K5rtKNQyWhE+KJ65jbEEZvAHHjQGvxBkfMBGPpF/LMDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599021; c=relaxed/simple;
	bh=K/PZGiT9f4c1za0Q759WhHTFxy6kIaMj2pvKno4REWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yeu18ElxO+ePBxffRZ4iFYFYpG14UrBOStOHI7FuIwFkM2rTOYlxB8CGpQqUf1hFncEGDGhDu3vtPXNiiMu3JK2lpNMNsrdGoQWi4mTuqtvZzD82E6xSI1WxIxqkFyJYZiXcw7iIeeYpRTqC9e3MgM3EgTiothnP6BkF/hA5kTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR0/TRQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR0/TRQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5BFC2BCF5;
	Tue, 12 May 2026 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599021;
	bh=K/PZGiT9f4c1za0Q759WhHTFxy6kIaMj2pvKno4REWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HR0/TRQJgZL3HoWTrpQgkbdYZkbvuO4rkUIDRtgsgZTvRCkQ0saTNuVUgFITf8VxZ
	 lo6CIm7lTgM6jihobxqNbpFxHnKi4SZ9i5EcUlAISxzHhQIG/NlypIOl7ea/BNf9oF
	 Th/7Zcs9lCi8wDM3vVgLphf/BewHWXm+Lhtxh487HgJhjfkAiCvZ05Fc+KNU+UjRaQ
	 gfsW9dRLuDj38CqK+Xrlf/xdrfdjPEgDYWAb2PPrc7iDKCeHSlHg+e2ORNSBM/i1PN
	 +UKgk/BO9aEVthrrm2GCFYHqn7LJtfFI3WhfqrqbwWTNmhORal5tQaXRX0K7LMoNzo
	 jNptkJvBFAq0A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>,
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>,
 Shravan Sudhakar <s.shravan@intel.com>, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v2 2/5] platform/x86: hp_accel: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 17:12:40 +0200
Message-ID: <2425918.ElGaqSPkdT@rafael.j.wysocki>
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

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
platform/x86 hp_accel driver.

Fixes: 8ebcb6c94c71 ("platform/x86: hp_accel: Convert to be a platform driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/hp/hp_accel.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/platform/x86/hp/hp_accel.c
+++ b/drivers/platform/x86/hp/hp_accel.c
@@ -300,6 +300,9 @@ static int lis3lv02d_probe(struct platfo
 	int ret;
 
 	lis3_dev.bus_priv = ACPI_COMPANION(&device->dev);
+	if (!lis3_dev.bus_priv)
+		return -ENODEV;
+
 	lis3_dev.init = lis3lv02d_acpi_init;
 	lis3_dev.read = lis3lv02d_acpi_read;
 	lis3_dev.write = lis3lv02d_acpi_write;



