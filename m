Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A2272E56;
	Fri, 13 Mar 2026 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407079; cv=none; b=on92CPeA8JlBgX7LpL9HSCUFfU+M+urp50yWyDpqhqMDe+sh4Qs/TS92WRGOa7yNNKhN4isfx8V3cHxI25Nmu/8c142zPPOVmPmlxrWxkdaNmZHqR3a42eLhA2O3/ea0gAecT309r6p+1fFi+7gfsn065Ky0fMkhKBnY3UGcgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407079; c=relaxed/simple;
	bh=C3Ic2bjaZP+Oml7vLA57zqG396WSoFwe59qAqPPunlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoWLB2qLjyi6JH30Yyschs264qTrqA+zIqY7pSJruUIJUrz36etWYZHsX/7XNur4cSCyteq/DK5ZeTwJ6XXOckrMvT3CohrYOA+Jxlis/aYkw5iNetWzN97xFzsftITCtK46vLTDvdmK64CThKbcqs77/ic8sM2Hl/2/nyhyUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQeQjwQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQeQjwQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3246CC19425;
	Fri, 13 Mar 2026 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407079;
	bh=C3Ic2bjaZP+Oml7vLA57zqG396WSoFwe59qAqPPunlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQeQjwQI7CsY7sZaF9Kjg0LfOQkNsopzqNt+qf0GBdnYN2Fm8oH4GAznjYYHdYgeb
	 kAg10/mvbsZWgUs0JLhLh4gnP6RamCWySBPnw3K4+WSIrutxvU7kHO8Lx4OfKVSJM0
	 Tujx/rJG4jqabzKKZIILWFbEuOaGXgUx+ao0y+lWG8KBQqDhkqJVH9YvK91WLzJWww
	 zR0Un2wOS+zyNR+onTecBPAmtdxw+vg7wSGhYgYPiJ8vLvYPZosa8zKumG9BCDX4ec
	 d2GJGr3U8tcF6IRZR0eIOMTZ49si+GuGDEBRbSsSbr1yxMy0B4vFVvqTWHsDvbSs8f
	 pFoUrJz3Ss8ig==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject:
 [PATCH v2 1/8] driver core: auxiliary bus: Introduce dev_is_auxiliary()
Date: Fri, 13 Mar 2026 13:53:03 +0100
Message-ID: <5079467.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce dev_is_auxiliary() in analogy with dev_is_platform() to
facilitate subsequent changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Danilo, Greg, please let me know if you have objections or concerns
regarding this one.

The new function is used in the next patch to limit the scope of the
search when looking for duplicates of the device being probed.

---
 drivers/base/auxiliary.c      |   10 ++++++++++
 include/linux/auxiliary_bus.h |    2 ++
 2 files changed, 12 insertions(+)

--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -502,6 +502,16 @@ struct auxiliary_device *__devm_auxiliar
 }
 EXPORT_SYMBOL_GPL(__devm_auxiliary_device_create);
 
+/**
+ * dev_is_auxiliary - check if the device is an auxiliary one
+ * @dev: device to check
+ */
+bool dev_is_auxiliary(struct device *dev)
+{
+	return dev->bus == &auxiliary_bus_type;
+}
+EXPORT_SYMBOL_GPL(dev_is_auxiliary);
+
 void __init auxiliary_bus_init(void)
 {
 	WARN_ON(bus_register(&auxiliary_bus_type));
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -271,6 +271,8 @@ struct auxiliary_device *__devm_auxiliar
 	__devm_auxiliary_device_create(dev, KBUILD_MODNAME, devname,  \
 				       platform_data, 0)
 
+bool dev_is_auxiliary(struct device *dev);
+
 /**
  * module_auxiliary_driver() - Helper macro for registering an auxiliary driver
  * @__auxiliary_driver: auxiliary driver struct



