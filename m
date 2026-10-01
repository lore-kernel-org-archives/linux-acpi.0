Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B42F8E91
	for <linux-acpi@vger.kernel.org>; Thu,  1 Oct 2026 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828351; cv=none; b=oQUySii39lUQJoWW1wPbQZ+dhItNCqbwDdlEacT96aKl1kG3/qEMbbpg3lxoZYpfuqDaAUM7ZXWPx5OhIvtrsdAxjF/ofwOWYUb/b6OoLHnbFeEms0VYQ1p6zmk17IQ3NbVMkagBVI9xSfZ+VxMcdqnZ0CwmlGlkIF9LYTw+Qg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828351; c=relaxed/simple;
	bh=fIM13QEFlmcI9y+ExG4Tih5mXaHroRUcHVgG/rxTxl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMTd68lIr3U808KT+Gxv7Y1zv647tFxnN9Qf5UqPq3PoVlfk0Yo2dVw3nyRcIrICHEDFC+K7HHplKDDB1IoVob1taGFWeHOXz+T98li9e9oGuVReB3B0Cn7WX7TaWtfabDwb/XSZF2G1k7bMTyorSSG5EgPH3GnlRp5INMSuqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNPSpOC0; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNPSpOC0"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c2a97ec17so1379387eec.3
        for <linux-acpi@vger.kernel.org>; Wed, 30 Sep 2026 21:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790828349; x=1791433149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIM13QEFlmcI9y+ExG4Tih5mXaHroRUcHVgG/rxTxl0=;
        b=rNPSpOC0046BjPIBhf0FvKKYMBinE/zoK/GQK+x092mKtmZ2Irfh9qz0nTi8J5DaI3
         5aUjrAY5nDJGLai8Lf20LqypGGlWc64RKMW+7KLUpKjfFFyD2ox5ellIqojsvolcA8uO
         +zh00lfncWudq2NEi91wAZr1Lxu+M+v0LO7rSxeo8vuxAlxnEX5CcyeCNmHQo+8RzQll
         nU7CPO78xPV2wCFFq21128hmoZzWE6hGjo6gRKYSCgEwesUReyrR9UPK7KkqRy3Jv0r3
         jILrSDlgsFptRt+rBm79T2NHFT++VhMB44ArRhOuOI5mpEn/e3CVehEzZqEFrKrSvbqk
         UEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790828349; x=1791433149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIM13QEFlmcI9y+ExG4Tih5mXaHroRUcHVgG/rxTxl0=;
        b=b5Gap0pb5D2jerd88zXO6mucdky3D4WRhbDV6XyUlIdyg6mxX+O420AebOYNewGvQR
         8gcuzE9qdGI4WhzJJ80JfOhA4qBZNOeziczLUlocscwgnPq1000O19FI6/1an2TadLWK
         /6y7DSs7OP1JINng7iiSNNNiwSAzD/OYIxXlMoN+m8+KwXy0B5UPFlGQngh0eeXu8o2P
         jCdH13+lQG5xpPSxPQpu+RnHF+YKdYxM8WM1QD68NIdgaDUq72Sv7YQGxYvVTpDZCylC
         HG9d2PyqwWTHbUc6g6cpdmF9w7Fjyf5upHF8cA7egaYJtdmuTa2MyUXG8Iq249bR/FdG
         Oe1A==
X-Forwarded-Encrypted: i=1; AKwUvBzpEThrCyRDvdLdRaV7HC91XeQcSO5FWhQkzHfRXFO5GTYwRw7m8RheLtMURq9H8ut3ChLM0AZtnSQ3@vger.kernel.org
X-Gm-Message-State: AFq9FYIkVZBXN+Gd0fhLq8sDZHIbSOIZ1qpUFrg2+y6qjh8xfkk5QbIC
	A8tCGmuXCa5I/fxivHBH7sVhu2sqYFJueAXyCffN+WNl3CucZOvitLE0QR8ju8FbR/Y=
X-Gm-Gg: AYBFou0O0bNhjil+6bsAHCa2okmrCWxMsUCAhVOVfP2mcIiwiEkxUIzWq9+AJswtwzv
	juo9+rTFOnd5ar2q7xRONnglcE8p6cf96clX2SYT5zXXEEJaGy+KqHegRY1G6Hcah7yQSmpsNWW
	d02lnkJzyOFqn7IilPPsBgWt7A/k1K0ch/CPQSjDQ/Bx8dAGhhg2wk7kxUBSBt8SCPJYNZOe5/z
	3ROS+/N6v2xKgBHHlh5wCrqDM3ZKBIceFXINJhQctrPKzN5KQd/DiW5x6gCraJiCE+R0SSFOKv5
	iqOFHaro7Pr3XzVAXglKh2p3+l5vsT9wsGyeqPpjcxmPiGSxzjq4BpwXED4yA2Wy0Jpm/sE0YTV
	hgIcZsS6NW3/uFnmoetdcnPXJVPBQgArW5/uLzdNqCQIy/QwpmHE5di9AhwaS4aJoyUobMua+C+
	RmKhn15jXtTOgbWCih8wL0Rwoc4LpJSg/bicbKd+f/03xmljAVVzNu0UuBRUNcrzbdI39NeE6a4
	doiMJLSPKenTWZB5OcPaWdbVzT5fKyIaNcUiMdkyQqMRxXM++QlFs59NZE6NwBrI8YzfId2KMNW
	FHl3Z38VOoaTXADG3mFAsPxytFz7c4U9vf+iiQ==
X-Received: by 2002:a05:7300:88:b0:34c:3ae5:c280 with SMTP id 5a478bee46e88-34cdb5f92b7mr3311931eec.10.1790828348454;
        Wed, 30 Sep 2026 21:19:08 -0700 (PDT)
Received: from rahuls-x2elite ([157.51.37.69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db315e8ecsm3877424eec.6.2026.09.30.21.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:19:07 -0700 (PDT)
From: Rahul Pon <theflyingrahul@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: GED: Support GpioInt event resources
Date: Thu,  1 Oct 2026 09:48:56 +0530
Message-ID: <20261001041856.1984-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <CAD++jL=45ZdTbHsLDTAmTt3f+=VBVK014TLJyd5Drdba3V=dSQ@mail.gmail.com>
References: <20260930111505.1108-1-theflyingrahul@gmail.com> <CAD++jL=45ZdTbHsLDTAmTt3f+=VBVK014TLJyd5Drdba3V=dSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 1, 2026 at 1:52 AM Linus Walleij <linusw@kernel.org> wrote:
> I don't understand the patch at all, but I understand that Andy or Mika must
> review it otherwise it's not going anywhere, so looping them in.

Thanks, Linus.

Andy, Mika: some context that should have been in the commit message.

ACPI 6.6 section 5.6.9.2 says a GED _CRS contains only Interrupt
resource descriptors, so this firmware is outside the spec. It is still
the only source of lid events here: LIGE's _CRS is a single GpioInt on
the GPIO controller (pin 960), and the controller's _AEI lists one
other, unrelated pin. ECGE is the same, with pin 768. On Windows, the
in-box ACPI device driver (acpidev.inf) binds both GED devices, and the
lid works there.

For _EVT, section 5.6.9.3 passes the GSI number, which a GpioInt does
not have. The patch passes the pin number from the GpioInt descriptor,
as section 5.6.5.3 does for _EVT under _AEI. Both _EVT methods on this
laptop ignore Arg0.

If the approach is acceptable, v2 will state the spec deviation in the
commit message.

Thanks,
Rahul
