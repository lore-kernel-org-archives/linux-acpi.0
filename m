Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB83E0C41;
	Wed,  1 Jul 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933470; cv=none; b=FhgXKiiHJHNBde9fsW6OBfa6EZj2m/PbqgVEcQ5nYGSyFNkQL51DCCXAyaPN6zToBBZ7CLF4oC+n2mP5Soo2oWAvzsjFq+COuLj7i/pL4O/kVAXmOvOmfLEVRSlHdeEEm6q92d18YGi1yJfUbOGq3J0iin7kFoBT4jscgQ0kNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933470; c=relaxed/simple;
	bh=eX50BX/r+6llFUlAe8GrtLxOQ8GSwiCC6D3ObIBf+gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWohS/yNfaRI3OV/uhCFBjpyjhZaSNjhTyiACiqBl7Lz14w2EjXlQ8hR4gePWfTWn6oBI7Y2K+AWUQCg5e+hUR646gC7yQxzpPu3VFQHsUrJjugHeKmtm4gfTmzWa185KjSgNsyrpHysou2ZSOYReJLtmP3S0+xnN53yTJAz8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUs0Jeq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUs0Jeq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B501F00A3A;
	Wed,  1 Jul 2026 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782933468;
	bh=eX50BX/r+6llFUlAe8GrtLxOQ8GSwiCC6D3ObIBf+gw=;
	h=From:To:Cc:Subject:Date;
	b=gUs0Jeq7Me+uDtTvtmtoAdeOK3mLlnS71XS+n+ABb3q7C6TIJDvWV57VkHSbVEJ8W
	 eG8thqJ8J455oOtIITwP0Q7Rj/RqKXi4oAZRn/4ezaNr+K+6kHtS32W0vdCR5E76gW
	 wSjxXeZvxWTIgtXMclgF+OrDz/Nu1PXA67sQGbB7n7UU/06UNnqLBq47yr6unhvl+5
	 lXg7JEPfD3EhKPcQ3d5Io1Jx1yTEXAnOtNG8RHX+MhUye0htpONurxpFeOJILhCqP6
	 LJjFjuBHQTAzQ4QmLkrEmL8RiFpmiiQ2mA13QcayVaR7JCuGFe0kmJY2ciHrJ0vPWj
	 gEUw/ZIuxyMWA==
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 driver-core@lists.linux.dev
Subject: [PATCH v1 0/2] ACPI: bus: Remove struct acpi_driver from the kernel
Date: Wed, 01 Jul 2026 21:15:27 +0200
Message-ID: <6027395.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

After converting all of the drivers using the struct acpi_driver interface to
proper platform drivers, that interface can be dropped now, which is done in
this series (patch [1/2]).

Additionally, the no_pm flag is set for all struct acpi_device object since
they are not going to be directly involved in any kind of power management
now (that is, they will not have PM-aware drivers and they will not be
included in PM domains).

Thanks!



