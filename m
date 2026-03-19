Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271A370D51;
	Thu, 19 Mar 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920029; cv=none; b=H+aLJxkA9oLrZIG8pM/RDchcVEwbqEgUE36hW5vY9knBtRuMbGgzCLd8CwdlKdSMRRmmo77YCFHvPK/lpORocYeEOOpLlyGbQxslZCnpSM4r0qA7tYN3MoPUBU02gy/K4/yJRITdB9zl2PHRjfANYIq1Ha5t/SG7TUf1RXVtef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920029; c=relaxed/simple;
	bh=bahAOU76Nprh8RdGJqEXDVlnQKGPbJJFFOMuh/ShlmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AI/nZAtfGIWANiYrp4gVN/rz+quEV04jst6eRycZ66wMz80VmErPn7Myd+mYdSn05MuHYRwHahZGfPYQMb6EBFEUbE4H0Zw8JqDPA+ETERwptswHzFg6FIIaq2oKy/XS2e1kKnEuKKySD+s9Lv5qQoV7+BHDQwUmI7DI3cQlHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBa5lcWN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBa5lcWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C261C2BC87;
	Thu, 19 Mar 2026 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920028;
	bh=bahAOU76Nprh8RdGJqEXDVlnQKGPbJJFFOMuh/ShlmE=;
	h=From:To:Cc:Subject:Date:From;
	b=IBa5lcWNrFOO2T/wHdltJKRpgQDYR1cadiDc/51EoJjbbNILo0gZstp2hnIWxLuSW
	 sdDirYQ8Z9ygMS6jHXH1mheGCfAxKAFIB/MNJclWE07aiT5w04QycUqRTONdx59dd/
	 HW4yFaham4pV7a+Tu2RFXVA4b/gtFtAvbUpUGTnZy9D5mFxsSpwX0xAypFbOxX5PDi
	 Z/uis8OvBTv3vtaa1acvywTAhe4fJQFjVdMdfZ4mZPPz3CbopAWdmbnw3Xu/PalimN
	 3bLhk36l6GfrqinS9C7cb5LeBFT1zlv1Da4DaYEwMRu+G0tjXCnfM38VEa2zlD5mYS
	 V5A2BICerMQXw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v3 0/5] platform/x86: panasonic-laptop: Bind to a platform device
 instead of an ACPI one
Date: Thu, 19 Mar 2026 12:23:24 +0100
Message-ID: <12863246.O9o76ZdvQC@rafael.j.wysocki>
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

https://lore.kernel.org/linux-acpi/5979471.DvuYhMxLoT@rafael.j.wysocki/

adding one patch and modifying the initial patch in v2 to retain the
current behavior when the registration of an ACPI notify handler for
OPTD fails.

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



