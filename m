Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD73F3288;
	Thu, 23 Jul 2026 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841170; cv=none; b=Y34viDD+42Xyg775zWQwGIlP8JFltj7rD5FKPwMesWehPyEq8suYkkkPYC8+iqj039AnQnZfF70kZ3DQBWEj7JxfBcIIPSLeryWJ02k8CyqpRrECgqsHK1CjufJXbbzxUkOnSyDvAKLUw0JMxaFDYAALECeX3maj9j1P+rp41GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841170; c=relaxed/simple;
	bh=oPL9ggiBSByF/zWsDP4Hkc2TF776H4ZlObruSnjWXLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLTBgkmjjt2VaxbYTDXmSnbjxmV5i4fnBNzUa99bCzt+3NVlN+JC1FLNdIV5Jy1UNPIX+tB2FEUeAw6SecVhLWJ2ViXuMrZQ4OolxazHYtP7qcydv5/5fboE2yYHMZgthSFC5SRbP/19RiA0f2LV4TmlpIIw/7WfnY+MU49WGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja0aQ+Qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja0aQ+Qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F651F000E9;
	Thu, 23 Jul 2026 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784841163;
	bh=a64RI79kM4Cr0iDQbGv07xZJYlNVsekzsgBWUeJESOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ja0aQ+QaCpCioDy1PFInV5LnOgsflnH+gN0ZIuWS0y6MngWV+bwmBTgIiAZbaMXsF
	 yUwskWXLWR9iohsXyiLlqXdI9/sxuMDhrhDqVEAYUgWyKnzmqJD4tSZmZgmn2/B2CM
	 2Ix4WpbeKgf2fCts5TKQaDhBMXROBvWQr8y+TYhcYwak1183QWZW9Q1RGG8OoqU6op
	 wDHNxoZtNL9/WtEgvcfDz8GH+HYFYU/Mjrnk+sONCAgW8YL3oph2W4AevRn7eOonxQ
	 pIVAGuXxt3ZLDn7Sg5L1veHFOy+dqSMbY8Nb2Xed41NuV/wSfI62WrZPqWZPWQxAoc
	 4d1I1bXa1ljrQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2] device property: mark internal data as private for kernel-doc
Date: Thu, 23 Jul 2026 23:12:38 +0200
Message-ID: <20260723211238.3451096-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721023218.3490573-1-rdunlap@infradead.org>
References: <20260721023218.3490573-1-rdunlap@infradead.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 19:32:18 -0700, Randy Dunlap wrote:
> [PATCH v2] device property: mark internal data as private for kernel-doc

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] device property: mark internal data as private for kernel-doc
      commit: 503735347320

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
