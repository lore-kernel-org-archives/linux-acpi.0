Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823327;
	b=QdwjtAHwBooVHH7XJPJ3F86Ac+iMU6iL9JM1gSlCbLk03ooXvcEavfeaWSxGYBSXZNsF
	 Noj9K09LifsjYmwxJAiHorTdHkhtRc6BwK02EVO/pqksp1oRJZy3AJfU9LGRhiBIcZba9
	 TeKqiZEI+jD9dNXdlHtbSdT+X2okKbD+oa8nK6lvSzJPx21pxOq77GrTiEFmJe2ORpzRS
	 EleAsxkJ4cLR0g5+zMx77Ys2TB/hSOrzuznGrcPnpwW7AOYUoiAiT2wqo1tc+jFPA9elP
	 qxdhzLM2O68wo9ELMa4rxxjjBnvB5SV9cdbKq1XlF44RFcYT+jD8kuL3tRR1/gliffg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823327;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=zsWAWduFeZpOhb2GkeIpoaCj3XU9Zxz05E+c4bxniHE=;
	b=dCLDSNjVmIifhjNZUMuvZTC+CrjREbf6O0NfuzZWZC7dYim3l43dUdY7D2BiZRppNkcD
	 PNe3VSBCPxK1gOU08Et2JdXBtd5PTw2pI6cjiv5D3QzXh36Zxd/NOvxX9rNr78tv+k7aq
	 1jcPzDV57NpwivWMkEkg08t7gtcJhEol+go0jEaHEk8CQybl4GXZtcR4lNd+vxnlpctuY
	 3k+cYUqQEZGuTiY+fC+ff/Y/8J2SJzjkMN43FewxFwHOqCE2KNhz4LSKZB/YwkuMgQtdy
	 L+z2bhFyDcosEd8e71U3ydjarYgjc1NyBM1ZTNNKOCOSLce9ORZMq/ahCOAW2yk7a8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZNB/0hnr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE56071A08;
	Wed,  4 Nov 2026 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNB/0hnr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0665B1F000C1;
	Wed,  4 Nov 2026 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823327;
	bh=zsWAWduFeZpOhb2GkeIpoaCj3XU9Zxz05E+c4bxniHE=;
	h=From:To:Cc:Subject:Date;
	b=ZNB/0hnrB2B2HN0buFTwcHzrDBEpJPJ0NJNXkv6pSrOGE7S/bduGulssOEOhmfGwI
	 wuGAGai8ptAE6BrfxmqvotBD3vfjTNYab6cP8C8ppV8lGatq9SZWvrjJrXC9CZZXAH
	 lBhnr61m0b51oZH/VaqD36lluriBZ5EpP989XVxqg7djRLN+j3kOjIMGualnbfjBog
	 lMBHogmap/raMA1vAXiOCcgevvI77O2F1ArDOWjuf3v5BFpoiPFt++CPdYzacp9kkP
	 jjVgjC+s3pzJyITPYG8t3/1KFhyqbGQ9X9DSVxnjAku3AWBZy06ODP0Pk7YSvkp7p+
	 BFukF+DYx3OOw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 0/3] ACPI: glue: Rework ACPI companion lookup related to device
 type
Date: Wed, 04 Nov 2026 21:09:09 +0100
Message-ID: <3471545.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi All,

The ACPI "glue" code is responsible for binding Linux devices (like platform
devices for one example) to their ACPI companions (represented by struct
acpi_device objects).  This is done by acpi_device_notify() when the given
device is registered.

If the device's ACPI companion is set already at that point, the binding
simply adds the device to the list of "physical nodes" associated with its
ACPI companion.  That's the case for PCI devices and platform devices, for
example.  However, there are cases in which the ACPI companion is not set
upfront and it needs to be looked up via "lookup helpers" registered by
the subsystems the devices in question belong to.  This series changes
the "lookup helpers" representation and handling.

Before the changes, the "lookup helpers" are represented by struct
acpi_bus_type objects which is doubly confusing because they have nothing
to do with bus types and because the "acpi_bus_type" name is also used
elsewhere.  Patch [1/3] renames struct acpi_bus_type to struct acpi_dev_type
because all of the existing "lookup helpers" operate on device types.

Next, the registration and unregistration functions for "lookup helpers"
are defined to return an int, but all of their existing users effectively
discard their return values (they are discarded right away or passed up the
call chain and then discarded).  Patch [2/3] changes the return type of
those functions to void.

Finally, since all of the existing "lookup helpers" match dev->type to
a certain device type, they can be rearranged to point to the device
types in question and provide a .find_companion() callback, and an
additional .setup() callback in one case.  This is done by patch [3/3]
and allows all of the affected code to be simplified quite a bit.

Thanks!





