Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A484221DB3;
	Fri,  8 May 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263327; cv=none; b=NYgZVlMcB0Ycr1/XW/af03avs1piutNZEKa/H7oaQwjgOKZf4IiXK6ub5XfX/VcdaHtcROGVnrb8uMXVBKRYqpvVdjSb2EzTV4XxGuI52RABsp29mGB3t1YAA3+8SlrUBIrvgSx6DCACKVVZMeG1GhX9np+HLR8OoG/VtkgwLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263327; c=relaxed/simple;
	bh=uu0BnmfoBJMYfGn+9XrMXbqyei59QDGjBgLtDIRQXZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amLF0/8rM5IRRXl1LZgz+AFqLLHV0MoFCW8pcR27tQudwqPQ0OMSqg7Z1y6NwaktByDAIqeQ9OJxv3yW1kB2rWW5gNC/Cvdcoh3RAuL6SGyDnsbQ6nmuxKekjYomzEpZY8bQdnETOF1DJ1kR2OGroDXkw2PU06lXwCPnAV552Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3sLI1By; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3sLI1By"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B808BC2BCB0;
	Fri,  8 May 2026 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778263326;
	bh=uu0BnmfoBJMYfGn+9XrMXbqyei59QDGjBgLtDIRQXZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3sLI1ByLhi84vhy+HowfwUJBZDj4RspZrEMbquEFZR5rAsvDiADWRRtpEDDoAP4S
	 jsiqt077Eh2+TvzUdtb8l9TU+MYOni/Hv9Vkw8bfYhyFZ+/U1pmUQNOSBfrUOvBGXI
	 TUdL34K3fDWYb/b8FofJhMd6pPFYqTQXwbHeOGjKHOKXg/cpyYHcc11aPDwuUStkQK
	 aadsvHfavEnoc6iOdWU+eug80WlirYBYjCm3NfZDwdY+z46NXC9sO/kgWHX8A8rKh5
	 An7Kmj0TVxi5oXEy30IcMptz80cb5dZ+SzVRRk6/dIf5VHlvDkGp2AVmRlt7/GdCma
	 Yy4mmhQIvkDuQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: x86 Maintainers <x86@kernel.org>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Subject:
 [PATCH v1 1/2] x86/platform/olpc: xo15: Drop wakeup source on driver removal
Date: Fri, 08 May 2026 20:00:27 +0200
Message-ID: <2069931.usQuhbGJ8B@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <1868425.VLH7GnMWUR@rafael.j.wysocki>
References: <1868425.VLH7GnMWUR@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Prevent leaking a wakeup source object after removing the driver by
adding appropriate cleanup code to its remove callback function.

Fixes: a0f30f592d2d ("x86, olpc: Add XO-1.5 SCI driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 82c51b6ec528..276caf756a9c 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -186,6 +186,7 @@ static int xo15_sci_add(struct acpi_device *device)
 
 static void xo15_sci_remove(struct acpi_device *device)
 {
+	device_init_wakeup(&device->dev, false);
 	acpi_disable_gpe(NULL, xo15_sci_gpe);
 	acpi_remove_gpe_handler(NULL, xo15_sci_gpe, xo15_sci_gpe_handler);
 	cancel_work_sync(&sci_work);



