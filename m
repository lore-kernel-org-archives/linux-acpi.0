Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8F34FF49;
	Sun, 22 Feb 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770076; cv=none; b=lmyD5vXLZceziYmSmlz6yqSawIt2Be08yzGQzvhrkQvWjYCy8UDl7rScJROBHFheciiPlaEqNSGfi+gSejjol5TEwBZ6MVwXq8McsWVCtognifsbqx0OxIT0BgskGzhq4dKLHkOjQv1iO/fjCM219iv2B4y5pGZLwQSvuYJ6LWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770076; c=relaxed/simple;
	bh=pKnu5ghCWORmWsnYXjGF2vIjExr5Er46xm9u06mSHmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hq3zOy5m3dgu5zFf19luTNdbJp9OOFJh9rFSgrgyPzLOSVDUWAS5LgOiV9Jr62D2/qEDcDjECPAODNbicQ/HedE61RSuTB34KUm3L/QMOMKTfBOA1WJP5xaq8WJH0uBpMWQWf0e7r0fYyVX6kVqPNWZ49RTiHt67vMHZ/BuT/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYJNRG2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYJNRG2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1860C19424;
	Sun, 22 Feb 2026 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771770075;
	bh=pKnu5ghCWORmWsnYXjGF2vIjExr5Er46xm9u06mSHmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYJNRG2W3JDFQgx59u6OLVCJ9B+t59RMBGZxHiBD1PU4shQX/qGQ/XhA5VCP59PeB
	 i8GYxgPYE45qFAzqnKpRf5lNB2ULceuSU7zhHeCYHTJIkfGx8uq4GyD7BVD9Uxrd9g
	 PAnHGKnfamZnkguAzJ9/uOl8PwisMOL80yDvoxTRo0Dr1aqq9JpFK9pMiKrzEX3mU1
	 HTS7QGKEIvLkOU9pJaFnW0pyx7TV0wEZ2/uhoeVJSdnoG/IcmVqw4qSvBOyCYUuOA9
	 /8tyCg2odj6xeAU8I1kTVzc0+TZcXZ8P0P4yoD2gk1PfP7M5Zx+XV0FZnVdapQmOcW
	 34rcBVd3TdpPg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v0 4/6] ACPI: TAD: Clear unused RT data in acpi_tad_set_real_time()
Date: Sun, 22 Feb 2026 15:17:47 +0100
Message-ID: <3416235.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4727679.LvFx2qVVIh@rafael.j.wysocki>
References: <4727679.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the clearing of the fields in struct acpi_tad_rt that are not used
on the real time setting side to acpi_tad_set_real_time().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -96,6 +96,10 @@ static int acpi_tad_set_real_time(struct
 	if (acpi_tad_rt_is_invalid(rt))
 		return -EINVAL;
 
+	rt->valid = 0;
+	rt->msec = 0;
+	memset(rt->padding, 0, 3);
+
 	args[0].buffer.pointer = (u8 *)rt;
 	args[0].buffer.length = sizeof(*rt);
 
@@ -233,10 +237,6 @@ static ssize_t time_store(struct device
 
 	rt.daylight = val;
 
-	rt.valid = 0;
-	rt.msec = 0;
-	memset(rt.padding, 0, 3);
-
 	ret = acpi_tad_set_real_time(dev, &rt);
 	if (ret)
 		return ret;



