Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AD328B67;
	Tue, 20 Jan 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923905; cv=none; b=bc3n9DdCo43yKH6uoFEKBglyVUvRtb0QSX8Ik8FbpgXeAYgW6g1Iw8xrVj1clMfbvoCAvkl167DK3hCImgVAYS7UAZH/XDOryfHEkck3vQww+XaEjgfyBGsXUz3+7fFcxJLTr3/jhpS7sBF0HqCbz83IxM+0WVQnra+q0DUsyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923905; c=relaxed/simple;
	bh=Pg2BkQxsBc9dyXpGiautqBpvS/L5bPjmKtyYe6frzsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r07jCA7o0hNp/EzIAwsYZAnKNkqRA8NoJMcohgn8j+lPcVeGQ3hCUxcaG+uLDzbNBhCLH4K0tFWkvks+NGF5gPZJnTry1gJzN0UxFCWNdegPzG1peqVlG1pYMPWdTGwcU6JRbYMVO5y4tb1it8M3W1qA4zYnahU+K8WsQmnOF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oliGbYJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oliGbYJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C1C16AAE;
	Tue, 20 Jan 2026 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923904;
	bh=Pg2BkQxsBc9dyXpGiautqBpvS/L5bPjmKtyYe6frzsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oliGbYJie196+c4ttIbPNu57yqceJ+D1IEs6ZgTZi+shSIQViVl/n4pP6ddDXCiJE
	 snYjeR4IiJ5p4PHSbQDQmS3GJhcq5eDObwiY9DS9XwImTK7bEkR6/3V34Dh3khbeX/
	 KUU/benvNWZfSbH0qoPNWc/vUVG8rIdharRIi6Sb9YWgQiM//vUlZT536nNyzZAVCT
	 gKVSog0yEr7zmaz0fyAPPVzr/Gmln+Ko3qzuWPlHicfHOP1YJBrhDD06os00XNIARr
	 bdnC3JnigDe/275MmP3mjsCMTWefQYyepvxRZsh9kijUezYZ6n7mkWNfy7Tr4clzFw
	 xPo7asB6qzXuA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, platform-driver-x86@vger.kernel.org,
 Azael Avalos <coproscefalo@gmail.com>,
 Matthew Garrett <matthew.garrett@nebula.com>
Subject:
 [PATCH v1 2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove
 routines
Date: Tue, 20 Jan 2026 16:44:23 +0100
Message-ID: <10789244.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3026924.e9J7NaK4W3@rafael.j.wysocki>
References: <3026924.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

toshiba_haps_add() leaks the haps object allocated by it if it returns
an error after allocating that object successfully.

toshiba_haps_remove() does not free the object pointed to by
toshiba_haps before clearing that pointer, so it becomes unreachable
allocated memory.

Address these memory leaks by freeing the memory in question as
appropriate.

Fixes: 23d0ba0c908a ("platform/x86: Toshiba HDD Active Protection Sensor")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_haps.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -142,8 +142,8 @@ static void toshiba_haps_remove(struct a
 {
 	sysfs_remove_group(&device->dev.kobj, &haps_attr_group);
 
-	if (toshiba_haps)
-		toshiba_haps = NULL;
+	kfree(toshiba_haps);
+	toshiba_haps = NULL;
 }
 
 /* Helper function */
@@ -195,15 +195,20 @@ static int toshiba_haps_add(struct acpi_
 	/* Set the protection level, currently at level 2 (Medium) */
 	ret = toshiba_haps_protection_level(acpi_dev->handle, 2);
 	if (ret != 0)
-		return ret;
+		goto err;
 
 	ret = sysfs_create_group(&acpi_dev->dev.kobj, &haps_attr_group);
 	if (ret)
-		return ret;
+		goto err;
 
 	toshiba_haps = haps;
 
 	return 0;
+
+err:
+	kfree(haps);
+
+	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP



