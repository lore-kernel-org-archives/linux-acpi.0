Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF7396B90;
	Fri, 20 Mar 2026 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003014; cv=none; b=c/feWEXEOhdQ7ptYOxyHjlbxrOFia3vGnV6bpkLFjjzw6SiJdnIo9TFHg99zHuZ/tWLuu/SoAvtE/cO4coPxYnA/jvf5zQmRUvvupNl3FGHRnzyYQr+OfmlYZSCHEUkrGb8qopY7MfTaklYRFtJxKm+4ksYJLZkrQWX6qlPOPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003014; c=relaxed/simple;
	bh=E2ObjWVrG+Clkh00qR58fZvMqXy6i87N9LV6csxrbfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DoK6b6IpoqXDHO9fyb356PUJdrcaMrlQ7LK6zuVE5FtTh8nrSlb1c9YvCG4Iq/iNadelKbQFyh9m9klZsp7JGrXeTATuv+uK1hnBZO8DF6uA54uEvOA2wJvnu6i2q8uzFOOu+LrBGxD4SL0DZQ3pH3KhXlsbnUrQl09+vz8VZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7avxjdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7avxjdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557F2C2BC9E;
	Fri, 20 Mar 2026 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003014;
	bh=E2ObjWVrG+Clkh00qR58fZvMqXy6i87N9LV6csxrbfM=;
	h=From:To:Cc:Subject:Date:From;
	b=f7avxjdcLsfX49oUFS1zN63MeDCR4nrnqVuY+R1GIsYAbxIBBhEbcj3osO5aNfU25
	 7rJu5fUjF6E7oRz4quRQEShWzW0eMPBx8v688UKnO0gB8fc7lh5KrQOGlojBZJnXnI
	 NgX1H481qiDiunMCR1G358U9ejM7cXV3+KrmVSlTGl7K3o0S0p73V3CROcdeR6jJFL
	 Uqjps/MI3LqGGc581dZ6qnsPDPy5cpFZUucmcwtbx2kcrJ4DuWrWFeNTvhB3upLf6n
	 dsI12XArTYE2tYmq8cMvtJFDg7rcmUHcq6MGREA5Q7qzENiestwD8fmBdoP5ONJS0M
	 I1RctmPJtVPxA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v4 0/5] platform/x86: panasonic-laptop: Bind to a platform device
 instead of an ACPI one
Date: Fri, 20 Mar 2026 11:29:16 +0100
Message-ID: <5983583.DvuYhMxLoT@rafael.j.wysocki>
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

This is an update of

https://lore.kernel.org/linux-acpi/12863246.O9o76ZdvQC@rafael.j.wysocki/

addressing a driver_data pointer leak in the last patch.  The other patches
in the series remain unchanged.

The previous series description below still applies.

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of the platform x86 Panasonic
hotkey and LCD brightness control driver.

Patch [1/5] changes one function return type to void.

Patch [2/5] fixes the rollback path in acpi_pcc_hotkey_add() and rearranges
the driver removal code ordering to match it.

Patch [3/5] removes some redundant checks from the driver.

Patch [4/5] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [5/5] converts the driver to using struct platform_driver for device
binding.

Thanks!



