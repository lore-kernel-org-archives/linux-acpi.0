Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2F3A4F49;
	Thu, 12 Mar 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326456; cv=none; b=DYQbaY7fVz057eDs79tLEyKb2HcZk5u1d4Ap4FgzIYCoFD39yk7FPJzi6L8qpdtCn5CW/hGh4YvlLC3IfnPzhe89oAubbpXMG2DPis6jJaH8KmbU+MHhWDtUQUlr2//+eHgDnNzRS9FIZNxwFfk7oJrQJY1jPGEiQayGNz+A328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326456; c=relaxed/simple;
	bh=sbNjanzXY9pvDbT1/N8ddmtkwPiyoduQKb+psrdmbDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0Fpj0e6vMTQ9jdrOvlZtcV085ODzqh8A6mkUP7fJKDdo/Xc4Ebu5WYJZvhZuYJ83a2ASCblQ0Y/E397+brsAhyvc/eU2B5V6VXt0B3/2g+BeH29PGR1VtpR+otMqjw+ooMNfehELSIKtbp38buKFm6bEu6KmG7dmJBmE8VsIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWUZIBuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWUZIBuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E342CC4CEF7;
	Thu, 12 Mar 2026 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326456;
	bh=sbNjanzXY9pvDbT1/N8ddmtkwPiyoduQKb+psrdmbDw=;
	h=From:To:Cc:Subject:Date:From;
	b=BWUZIBuc60wwKCndUPD5aMenKZe+PQYW6GDTBkHzK2ElGKdSnkJJis5slKyWo+xdv
	 CL+j/N3B3Ppj/CFbJAK2faIhEn1FkFq0Z/QcsbvOmniggs/4+zNZooy10GfyXu8ovL
	 eXQgZee0JD3ShKbuZQrhZWufvRUXtNv2Mu0YOWr/FJS+oct0LpQ087Auz9k+9MLvKn
	 YWey58mvDKIvmzFeQb7dC/YCTJTiYueU7IwkzbD0MMci2+Z8ltQMC9Ar3VLUn7AbN4
	 aY0PYIx8BDyHAxIPrb5DJm5nj6R5CQTlP8vZPwV4tgyxThHKUjI/HtPhvsokv6WZJx
	 9xv0IONe/M3RA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 0/2] platform/x86: wireless-hotkey: Bind to a platform device
 instead of an ACPI one
Date: Thu, 12 Mar 2026 15:37:45 +0100
Message-ID: <23052072.EfDdHjke4D@rafael.j.wysocki>
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

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of the platform x86 airplane
mode button driver for AMD, HP and Xiaomi laptops.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!



