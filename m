Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347065;
	b=ecH4zHe9REWEDfzbLFDW6N3V2akNM6ZYmm2176ckA3Uyh463Z1c9x3Dmqlr0SI+KMS0z
	 xHqh4mdMoUVIXP82UFXqnPP4EqcTCZT4hlPjmpPATVMtQ1iZdgwiTMz8KXKVWzVHhNlSG
	 80AanrQ61+WWFbcGu6g0Jla07EpqlyXiITZ97icG60WpCA5j/H1dWdtyUv9BGf5DMJU8j
	 Waq6E9xDJBkn2e6xT5bTfki9bfDXHoOr62L7/LHVKgms9hyDiWRK2rky2FCgEd2FlNzaG
	 g4GxpjA+TNaqbPfvL5hKx0ZEIkloVDroazJxyhN7abCDGSL9QZCt8Q2jokQ0Rmr46ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ObLQIYquGzBiqCTd14UQGXrFZOGeRqctaF0y4LnV60Y=;
	b=xp8mI6n6bd82+NPuKkhMblpkVUNuW9cFy68dGROC8xbNlAn4TAIPow1KHZ5IB9jlXXrp
	 VpMbRMB80q+nP5mEApOUSk9I5DCyc1n/dlJwBNH7cogWOUgsFVS2OVjn51a2SKU5GjX2z
	 Ll1dDTp7oMj9N+AlqnnBwLA1qow4FDBT+QPkdnv/SbUU1mRfFQbbtlZG9RdvHHHlI2vD1
	 dlo4uPJnYSpnOkvDhEZKv79hyrbi53kZte+olvPjOlIZj1LADOToEKadHtjVma7ozkf/1
	 Qj+Zmj4rQoDQ4v3w7ZzhrgM+kIXpz6PGsk3Djsb0EYcaa9N7wGeF8wRAgtY9MqIkLHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fireburn.co.uk;
	spf=none smtp.mailfrom=fireburn.co.uk;
	dkim=pass header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mrFrWyUr;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4D606A31D
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 07:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B4D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mrFrWyUr
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so352702f8f.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793347063; x=1793951863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObLQIYquGzBiqCTd14UQGXrFZOGeRqctaF0y4LnV60Y=;
        b=mrFrWyUrHxvEivP2DgRPPmSDKFqCjsC+pk1cnEIsYJPsRF9pO0/VTsznBFpxMPDtqa
         n+Xyu2saCK9m4daJymY2sac3/5HA1IZvFQZ+izkSZviyMzn9Y0HIwjMiuAOyPCL/uB4K
         5Ddmhwryl2+AYgeXMkrujLmCjO8nQdtKmDPJezSHH8HbKDl8UL9YcZbt57nCNC09Qu5t
         rUDSoFR0WbyXZPphUmhJ2hiGrmXNrjF/FD4Bjte8VYvZJXF2Ukf+R6UtSk3eXi6gBxNA
         dwBS/pN4EastSa/F619tYYkroBQc+QzbdhkGP6+xbkyaZrhJFI5Ibu7Lro0w2iI8mczA
         kDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793347063; x=1793951863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObLQIYquGzBiqCTd14UQGXrFZOGeRqctaF0y4LnV60Y=;
        b=P70Q2RXlMCwESKqhyXx2MPIH3MSYdMviEG8/ZYV0sJy0FGjNi4zei2hzvAjvArRU9k
         zs9LfvIrQALtgm//Csj99gxkLwT6mMGcqR3qCVYoeTJUqPOFEudV7ijXJ4P/sY4V3hFr
         Sg3l809Ikc6jo/fKdrZTBIKdS/4SQjlwxulbwmx3/uC/191nttSdLocrdMl5+U1lWzXs
         NPIJK6l4Ly0B0bEs8khKaktj9Bwj+y80lMejZW2JPcOhvf9/z3LZ5jZrBcNqyASQcvR+
         BHea2/GbV1jtjZR/Kh/mTPbk+QjbDT+q1yNhpT4YA6exxK32OPE/djBaIkojyDoJRxxB
         hsQw==
X-Forwarded-Encrypted: i=1; AKwUvBxSNcy7id+rt01K7eHHFwarRZMKeE+z8g930ZJviR+GMuxq8rjtgxV757Q6HFPHKNwiTJpX7TUAcecx@vger.kernel.org
X-Gm-Message-State: AFq9FYKu4a6J4pS1G1wVh9I1A0M2TBbY4omBWFBHXpRKUIdOLX3dxOtb
	DxTgW1QuOYrGKMbwuPfB+Cmvs8VpVPmqJgpCuCeA7t1qGwnOv9Z0MmTexxDRLEq4PQ==
X-Gm-Gg: AYBFou2ZizF+U628pzfcSF9R34aZf+R1XSEidUcsmowReBXt4oBvlA3UeHPqqkxdeRN
	hi/worEM1Z2qk1OFbDxJlW/KVatDadi+mSezhKEUM26/gg8RXWgHFU8/iPxwAOB9enD0F3YjIkf
	V15EOIeYVfGMPj+GixfxJ2g/Z2d3GYEvt9AAtCEbBd7XNGAZK/BnpR/qnjV9mKMMIpyXQxoDMzC
	a9H+JcsFcdWE3qGuBiMLUGt36yBdaYJ5vCuaKs1rpPXPjRmgLUzLzbWQfZnqKCI8jzMvfBxV/MM
	yGmIm4uek2LzJ/mQndrdQL9aOtubZ7kecr5+pue7TUEnZINkb/4POqPDjTsNnPsJontIS3fuZ1w
	BTHOMOxpo9Q7QFer57fG1kqiOyb6FQ6lS0Dh+352f7xTasJEagtDuEZ3VjFKvg2U3x3KNHh8xmo
	fxamybLz/TOmm0N7kO6eNoF3ik+mETmXH3gffTYPxRBg4ae+uYx9TU+SI4CvEZ0hgjs8UV/A0bR
	ADJ4Fss97LcSLfneDo5pw4e2tJZNx77QYraS5i7lmqQvXKDr6A6zsAdCw/2jALRy2tHB2RPr9Ov
	vxEKsz6OUdaJnHx5tBQ5AM0mcLQOgHlqVQj7rLaujkY66i9eXNx67p7w+8jjPg4xMkD1+hQEZG2
	a
X-Received: by 2002:a05:6000:4a19:b0:48c:4442:54e with SMTP id ffacd0b85a97d-48e6e4f4405mr3497370f8f.30.1793347063048;
        Fri, 30 Oct 2026 00:57:43 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8bd8esm1675411f8f.42.2026.10.30.00.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:57:42 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: Alex Deucher <alexdeucher@gmail.com>,
	Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from its own node
Date: Fri, 30 Oct 2026 07:57:35 +0000
Message-ID: <20261030075735.356811-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CADnq5_PbewORwc3Wsqw3VQESz3RNAKJy+KdnWHx9J1rKg35-Hw@mail.gmail.com>
References: 
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026, Alex Deucher wrote:
> I'm not sure about BACO.  In the BOCO case the OEM has a mux on the HPD
> pins that redirects them to the EC when the dGPU is powered off.  For
> BACO it's usually a PCIe add-in board so there is no way to redirect
> the HPD pins.

Agreed, and I can't test BACO anyway, so I'll keep it BOCO only in v2
Mario, sorry, I'll leave your BACO suggestion out unless someone has a
board that needs it

> Mike Lothian does your system have ATIF?  This is already code to
> handle this.  It sounds like it's just registering the wrong ACPI node.
> You should be able to use the existing handler.

It does, but only on the iGPU: ATIF is in SSDT7 under \_SB.PCI0.GP17.VGA_,
and the dGPU node (\_SB.PCI0.GPP0.SWUS.SWDS.VGA_) has none

What arrives here isn't an ATIF notification either.  _L05 in SSDT9 is
just Notify (\_SB.PCI0.GPP0.VGA, 0x81), and that path doesn't exist on
this board, so the interpreter aborts the method with AE_NOT_FOUND and no
Notify is delivered to anything.  I've put the tables and the errors in
a bug: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

What I haven't checked is whether the firmware would flag a dGPU display
event in the ATIF SBIOS requests if the Notify did arrive at the right
node.  If I alias the path so it resolves, I can turn on drm.debug and see
whether amdgpu_atif_handler() fires and what request flags come back, and
if ATIF_DGPU_DISPLAY_EVENT is set I'll use the existing handler rather
than add a new one.  I'll report back

Mike
