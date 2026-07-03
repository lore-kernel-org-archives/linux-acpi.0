Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC43C8716;
	Fri,  3 Jul 2026 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078758; cv=none; b=llQ82NBNqrN/RhNC0ydMGNdVGhLaUK+NEggXbzEqqVlP0DWqyh9LpXRJS+YQOwnouBTiGTD0EikhxDDsSaIIETz14naUtHsovogttgr59L1DkDDfSmfVig/AHPEKUzqlDaYxMHoJuh+iLi+GWEgc/wh8Gyco8Kznlb8BWVxo/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078758; c=relaxed/simple;
	bh=pf5V9wP6Ld6uqFA8mlK1Kv6cIbJp0Hg5jSt/Lxi68iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P0ydOpt8qBpp3fwvH77MX+IGWUYKQrFfj2F416g/8fQ7JsKf1wCciK451PNWdCUGQN1yXMsogOAwoYJdLgO+eJBhTyqymeCn30s099Y2XzFbzZiGcVm9ffKC69mQ57gP7TKSNdf3VxI7vsExGjoXyHGCV5CjAXjlvOU1To76xpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJFeBBD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJFeBBD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1B31F000E9;
	Fri,  3 Jul 2026 11:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078757;
	bh=pf5V9wP6Ld6uqFA8mlK1Kv6cIbJp0Hg5jSt/Lxi68iY=;
	h=From:To:Cc:Subject:Date;
	b=RJFeBBD98qjzTKUhe1GOw5uNvcKYy9xyzfRiJoEQHrSTUoes8h+6RZcIWSPGg3YcG
	 JHe410ie5NBRFX2zXowTprcvNeKMnQwHIPzuHIjPqhRz54KqHDTqwHARgw097OcW7D
	 PcGEmv8ZzkH3ljKwCNQjM7zoDTEYKXbU+a8stkyxBjist9pQNzyonvRRFFC4j+SHiz
	 GEo+20ujQtoBkBjl0GZRpkXZp65VZTPCL6adOlUn6PubQV9yy0G069UNc6J+LxMHJo
	 9Jzf5tu9jIqeJl2MjjY5f2PgO5otm9nr8o2tVgqIqNQbZ6hvw+zr78gobfUI4z0E1U
	 SHkyGugkwmMUQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>,
 Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, Mattia Dongili <malattia@linux.it>,
 Azael Avalos <coproscefalo@gmail.com>
Subject: [PATCH v1 00/10] platform/x86: Stop using acpi_device_name/class()
Date: Fri, 03 Jul 2026 13:15:01 +0200
Message-ID: <5135166.31r3eYUQgx@rafael.j.wysocki>
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

There are two fields in struct acpi_device_pnp, device_name and device_class,
that were supposed to be populated and used by device drivers, but they have
never been used consistently and some drivers just populate them and don't
access them later, and some drivers use them uninitialized.

All of that is confusing and messy, so the drivers for core ACPI devices
have been updated to stop using those fields which are now slated for
removal, but they are still accessed in some places.

This series updates platform x86 drivers accessing those fields to stop
doing that.

Thanks!



