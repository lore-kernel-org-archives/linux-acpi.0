Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67843147;
	Fri,  3 Apr 2026 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205955; cv=none; b=c129kbF91sOkzr3dezBrv//2PFGRbrvdtbjQ2qvvebi5FAxyUzH0g6B9BAcyk5Xv2HfX+39XtoLlQqQU/6XZGulIOJ98q/LTt7FsoWdooVDossjVOQZPXuyVswUqGnHIGyHt+qehPWWhF7tEiv6J7tOcgIQTAl0C81lJu+1J8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205955; c=relaxed/simple;
	bh=Hpm3U1WnLpJu7i31BrOnNMQW6zCeIl/NGeqf4iAmgwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KSH8Z6Gy+uSUPysHG3IPQ0ah47NsN8NReX97/xr0vimK2LXzSNUQW7Yp/0bZDAlLEU5UV3Sduvs9bmjejpn8Kw0CDO9w0scy0eQ1GRQj65/1/drvNB8kGGUXe3qGJhuZ3G2lQDisZeutrqxmT5I8twJ4Jza354zSxYTmiug3flw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=jzKwqLBk; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="jzKwqLBk"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+cl1UGkNELaUkQFAdZ5UWGReiv4GzdSFoHv0mWPbBIo=;
	b=jzKwqLBkCWAIarb3jII59oNRdlR7EN8ZHqghKHem7ct8JAwbhJ4oEFSRW5E+c7uublD6bYg87
	ryDZcNNU+07qeH/JNGraKELlLJsGlW8WUj7oy5/DK4VS8QEz+QqlBVZt1dI7+mt2VyVd/61jyJA
	CHa3prd9QjhuNmvibl+rl7o=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fnBwh3G1SzRhTp;
	Fri,  3 Apr 2026 16:39:32 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 761C44056D;
	Fri,  3 Apr 2026 16:45:43 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 16:45:43 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Apr 2026 16:45:42 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>,
	<wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] cpuidle: Simplify cpuidle_register_device() with guard()
Date: Fri, 3 Apr 2026 16:45:42 +0800
Message-ID: <20260403084542.708104-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Use guard() macro for mutex to simplify the control flow in
cpuidle_register_device().

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/cpuidle/cpuidle.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c7876e9e024f..8c037db46792 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -679,16 +679,16 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 	if (!dev)
 		return -EINVAL;
 
-	mutex_lock(&cpuidle_lock);
+	guard(mutex)(&cpuidle_lock);
 
 	if (dev->registered)
-		goto out_unlock;
+		return ret;
 
 	__cpuidle_device_init(dev);
 
 	ret = __cpuidle_register_device(dev);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = cpuidle_add_sysfs(dev);
 	if (ret)
@@ -700,16 +700,14 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 
 	cpuidle_install_idle_handler();
 
-out_unlock:
-	mutex_unlock(&cpuidle_lock);
-
 	return ret;
 
 out_sysfs:
 	cpuidle_remove_sysfs(dev);
 out_unregister:
 	__cpuidle_unregister_device(dev);
-	goto out_unlock;
+
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_register_device);
-- 
2.33.0

