Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985093D904B;
	Wed, 18 Mar 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842251; cv=none; b=qQw9T8noMOJ6PN30wTzi3vQ+S3diOyWlysFm7ithLi/SjOyjUBj/R6I//iEoZZ058fan83cs/OaHbPZkYkeQsMvxNfPuSUlRiReoZrTQ27fp6vK1P7C4Lig8D8PbWvhmjEd0X21o1EMrXToxzOygJhSDkjyAVFckKrvJNWbs2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842251; c=relaxed/simple;
	bh=v0SyTd4wsaaSo7HH33IAJf/zCdLsJtLEd1RmhKj7PuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7AvT0NuDpbwg7dAaJHlmF9hOlSIEIQRVr8lWWaDlMJRXzSvCDs0AUHbfqe+CET9qbsjuTMNuu2xFxO+Z8y9kPtAQHpT4eXeAgECq+5Vs2CMSuI8fuy+oO+Cl3WJVXoSkw9Nzbz5Ab6KrMnmQyZGvEyFW0BWVZALKhHMl6p1t90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXVx6XNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXVx6XNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8B5C19421;
	Wed, 18 Mar 2026 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773842251;
	bh=v0SyTd4wsaaSo7HH33IAJf/zCdLsJtLEd1RmhKj7PuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXVx6XNXwFChQVttQSowkd9QTx9a02sP4JOjd5K0qGSqi9K78N0trmzcX/yQWCIO8
	 K9EEKJgTnNjmpt6RShrv6ulqMjphK2slx3xOR82mJPS9TbBxOPPc/4SWmHDmoyRRTH
	 Kg7Uzjoodi/wXcvHE/UQXUT7fARFtXkJppSOJSyohEyXywECHhpw6zgEVRIReKJACA
	 ujfiWauPnbtfV3uS+JhD2zytlouWUUl3sYPSuPB84MZUxqA9RFwG2d/8lKjPHmVHGA
	 jeLNjC0MwuC66aWrQQSe+pYjTMjxPhxijhAw/qlV+8xaeGXadna2qbuD3Oq584ghAr
	 y6tMZaszlfSzw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>
Subject:
 [PATCH v2 1/3] platform/x86: system76: Drop redundant
 devm_led_classdev_unregister()
Date: Wed, 18 Mar 2026 14:50:08 +0100
Message-ID: <5057164.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4721148.LvFx2qVVIh@rafael.j.wysocki>
References: <4721148.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=46rom: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Drop two redundant devm_led_classdev_unregister() calls from
system76_remove().

No intentional functional impact.

Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--

v1 -> v2: New patch

=2D--
 drivers/platform/x86/system76_acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/sy=
stem76_acpi.c
index 3da753b3d00d..d8b64e2c2713 100644
=2D-- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -800,9 +800,6 @@ static void system76_remove(struct acpi_device *acpi_de=
v)
 		kfree(data->ntmp);
 	}
=20
=2D	devm_led_classdev_unregister(&acpi_dev->dev, &data->ap_led);
=2D	devm_led_classdev_unregister(&acpi_dev->dev, &data->kb_led);
=2D
 	system76_get(data, "FINI");
 }
=20
=2D-=20
2.51.0




