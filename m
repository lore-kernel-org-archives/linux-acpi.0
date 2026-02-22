Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4E26ACC;
	Sun, 22 Feb 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770083; cv=none; b=o6X602T2r0D83STDRASI3M677F3NwyUlSk67Kj6ziE/e+6eFdcd7vEANSG8mZiWbl6tBWjIY8/DLhv3PgzpWQdUZ4EqUqdSU7QwASPZFoJa3nOX4D4kGn9q0C8zJRwVF74DSeuR6f8Md7HzoAN5R8MbdLf3AEQcK2tunvqIGrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770083; c=relaxed/simple;
	bh=9GoprUYSUZssZ1PQaBB39NYf3vii5X9keDoAbe8U6Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNceT4DEKiBwd4CKD2IvKmMrNuh6A81hzNyp4vQ4ycA6BdgGoZpgxt4Cl8Mc2zpYdOWuMbOYuBMjRN7KestRze6XUwRdTzDvq8VfNlhE7W758pIscN1UTMO0Q0HmsoMyj2DqyW6r/pjmwruDmf26E8OrOpgObX7LGXEIpqH3ONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtl4Tf52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtl4Tf52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B253EC19424;
	Sun, 22 Feb 2026 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771770082;
	bh=9GoprUYSUZssZ1PQaBB39NYf3vii5X9keDoAbe8U6Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtl4Tf527xC1n+aF7rudJ27ftyA6r/s6nsH4R3D/yNeNWC212dD2sTFundLmEnjmx
	 7a4p13hpgyPEnW2qDqHkDAJlJ0VEyDhzzodBaQGuXNUz3CoZKN/iWgeLT6AGT0DsJG
	 ly7SuajhKvpM5JHYq+ohIsW3R6C06Dn0W62FyVHV2lbmruT2Vq34mJI/vK3KoKra/I
	 PnDyBW2y513wa82oobhamp68K6+vb5PV/Ena6Q7tevQdH9PMwAoIFB8epxAClZRI8G
	 c4pjZLHS/3zulvyr1PQBzL2ZVhnpvZG4jPDao+6kcb+1jH47sVaLsNNVfjWWjJrJIC
	 CiXgE8/QhI//A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 2/6] ACPI: TAD: Use __free() for cleanup in time_store()
Date: Sun, 22 Feb 2026 15:16:19 +0100
Message-ID: <2266821.irdbgypaU6@rafael.j.wysocki>
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

Use __free() for the automatic freeing of memory pointed to by local
variable str in time_store() which allows the code to become somewhat
easier to follow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -167,57 +167,57 @@ static ssize_t time_store(struct device
 			  const char *buf, size_t count)
 {
 	struct acpi_tad_rt rt;
-	char *str, *s;
-	int val, ret = -ENODATA;
+	int val, ret;
+	char *s;
 
-	str = kmemdup_nul(buf, count, GFP_KERNEL);
+	char *str __free(kfree) = kmemdup_nul(buf, count, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	s = acpi_tad_rt_next_field(str, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.year = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.month = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.day = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.hour = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.minute = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.second = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.tz = val;
 
 	if (kstrtoint(s, 10, &val))
-		goto out_free;
+		return -ENODATA;
 
 	rt.daylight = val;
 
@@ -226,10 +226,10 @@ static ssize_t time_store(struct device
 	memset(rt.padding, 0, 3);
 
 	ret = acpi_tad_set_real_time(dev, &rt);
+	if (ret)
+		return ret;
 
-out_free:
-	kfree(str);
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t time_show(struct device *dev, struct device_attribute *attr,



