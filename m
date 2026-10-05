Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099651F63D9
	for <linux-acpi@vger.kernel.org>; Mon,  5 Oct 2026 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791170859; cv=none; b=e/J2fSUeQ5sBLRwuieZPI1mfdVANK71HUjBPkqP3Sl7Gs+LetzPKkgf6p1fCGrgGPXAiMtXswlt3ldOr8a1ouSSy2X0E81jk0foGk2YkcX/DwsEkDuGd2Qw8TWCVIx30BuKJfy1N9oyA+ysnGLXCxEGd/3FQ+stJ15LzdlNXuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791170859; c=relaxed/simple;
	bh=E5O0wlXlJyvkkz/5Vo5XiLD7vEKkwgsN4f53JEeHJvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF/C/m/VBYsnrv0Wi9mkGX9CPAylAo/rCNiridEAsU4Lxo4o+zeZ6fpa7rqN2Vx29Q7n/HsVZSEl8wrpUxvnoPuTcXp5LruGPF06P9hR95WFvPxwOU0fFQynEwESnUvSEvu2CEXk5a+y+lJL7FFm3andyRlbp49VqZlwQXTjsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPYcFeIO; arc=none smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPYcFeIO"
Received: by mail-pz2-f36.google.com with SMTP id d2e1a72fcca58-88a0f29ce98so498147b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 04 Oct 2026 20:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791170857; x=1791775657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7rtVf2jZjIswFkHLMjLn3J1S9WPnjKaw0RzizJrzhw=;
        b=bPYcFeIO1SmYox9vZpDt3UsSZir491cPfkqonSfQitiBaVVX4uS1B3YIy0Fgf4kMgE
         K+t9ArkkH3nj3tbCB2Ahatqi4vkh8MzU5PPkDJSzWF5HkpJJhltDRBlXp0JnAQDQ+mih
         JyPEvH2RRdlg0+EkkhMIe3WO8/THIVVdnoeyJL/fmZ+to6K/jOjJoayncKpLZbJMo+xm
         DsgpierdVc7Z3et8+6hnFwzowjXTVRTSja2xM1brQAjU6dOysEBBwKru3M55o77S37Hh
         bLBmgk2gQV3Kq0Z6nY3mvx0i1xez2gpfuA+AU8NWAOFcCJ/CMIGKgv7C5VjJmSIa42De
         OVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791170857; x=1791775657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7rtVf2jZjIswFkHLMjLn3J1S9WPnjKaw0RzizJrzhw=;
        b=OwUjvlTKVDnrN6N7UKN/q1SozfhsRklaBBBv6+m9kn7Zs/QPmeo892DgBSqUyiku2/
         0UWzR1ouM2MMKMDwCrDpdnRqZYiZAJH4H8PM/Wlcpd8PzKyt/ScFhMPtI4NwZKshJvFn
         GPmSVNSWYyaYiSbv+1XZzkmrEeON44+6DyPzDk7bwpBkk6TyvAC4FHtCXg9pLk4lsDuO
         cQR77qgWiCGVoL81JsMewpiPJ7Q8kAenM6AOxGJrffUUGKwnogZKTfWZQbzEMO30cZpq
         4yy16RlMj3JDXV0cdN7yTzsYK3QyeDOhiwfbKSpJwlPQROfSZKi19n1TmG84+oWhKA59
         HvDA==
X-Forwarded-Encrypted: i=1; AKwUvBy/zWYVUXOEso6en6+dCJqIhB5ZUmkoaydUpqRcyL+Cepm/LJUS3OpsJXzzvPHWNvxaYD0lIC2rJf9a@vger.kernel.org
X-Gm-Message-State: AFuF++nlCT15TrfBn9dNnKlPUYWOyowg17KyQoeJRWeD6t6io167LbER
	6v6hoEnGaWk0Fwy51qS8z1fJ5oiDw2L2qNAZOiLOChxggoacA0TPf+Z5cEVyc9Yi
X-Gm-Gg: AYBFou0r3435DlmmYVQu04PMiv+MifFwvHVkIQKf/M3Oei9x781k/EBIAxiawnMWc5z
	iY3jh2SO+ImEMyNoXhwTEgyYmisTXsP90sXrcqlAf6R2i31XZxy/RTwMYamG1KhPR3W6hiz7uDP
	wdvsvWV2pBEpwTUVGutwkFO59FCh39kwFH2nIaTv1SKe6QygyqKk6iuS78+a42s09A8NAfRi5YH
	qaprT1zMFr/JNebznBB3NtMOm6sOF1CYaH5uu95AQEUrXAh6XB3ZUW/R9RL5uGSoGZsBEIURB4j
	XSryEtt28dUi3z7NcrGjnThiIVfDh/nBiWu1Min2qmc95ZlRgPiMZkCpyyhShQwlRzPKBfvTcjs
	QZ49Pr38F2mT914ImyNfwvNqIcCZ4aB3YWTBHP90NBUMGqLIvjM8q12qfhxz9eE6QLH2FUt3Zs6
	QTpkZB4Vyb58JcQlHUoeGzc3Dut86fazGn4bqeqT3awDbN7ioEA6UNY9t4BSdrpuzp57PH8s9qA
	rHH3lmRBH+uNeQFb55yUsn+sbncVeHHBqIEPkk=
X-Received: by 2002:a05:6a20:4324:b0:3e0:d65c:494b with SMTP id adf61e73a8af0-3e0d65cf428mr6369545637.26.1791170857208;
        Sun, 04 Oct 2026 20:27:37 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([112.2.158.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6ddd9a25sm115037a12.22.2026.10.04.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:27:36 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: westeri@kernel.org,
	andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0662 to i2c_acpi_force_100khz_device_ids
Date: Mon,  5 Oct 2026 11:26:55 +0800
Message-ID: <20261005032655.12633-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005024654.26888-1-xuyuqiabc@gmail.com>
References: <20260918054109.23550-1-xuyuqiabc@gmail.com> <20260918055653.GD106095@black.igk.intel.com> <20261005024654.26888-1-xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andi, Mika,

Please don't apply this patch. I was wrong about the fix, and I'm
sorry for the time already spent on it.

I treated this as the same 100 kHz quirk as the other ELAN touchpads.
That was a mistake. On this machine, forcing ELAN0662 to 100 kHz does
not stop the touch jumps.

The firmware already asks for 400 kHz. \_SB.I2CA (_HID AMDI0010)
publishes the timings through _DSM. iasl marks the UUID unknown, and
I could not find a public AMD specification for it:

    Method (_DSM, 4, Serialized)
    {
        If ((Arg0 == ToUUID ("d93e4d1c-58bb-493c-a06a-605a717f9e2e")))
        {
            Switch (ToInteger (Arg2))
            {
                Case (Zero)
                {
                    Return (Buffer (One) { 0x03 })
                }
                Case (One)
                {
                    Return (Buffer (0x04) { 0xE5, 0x00, 0x6A, 0x00 })
                }
            }
        }
    }

The same UUID is present on other Lenovo AMD platforms. AMD's
amdi2c.sys 1.2.0.126 reads function 1 as two little-endian words,
LCNT 0x00E5 (229) and HCNT 0x006A (106), and programs IC_SDA_HOLD
with 0x48. I could not find that layout written down anywhere else.

i2c-designware does not evaluate this _DSM. It derives HCNT/LCNT from
the 150 MHz input clock and leaves SDA hold at the reset value of 1.
The comment above i2c_acpi_force_100khz_device_ids already suspects
those default counters, and notes that Windows works at 400 kHz.
Forcing 100 kHz only avoids the bad fast-mode counters.

Programming the values from the _DSM changed the result:

  100 kHz, SDA hold 45: touch jumps within about a minute
  400 kHz, FS HCNT/LCNT 106/229, SDA hold 0x48:

    i2c_designware AMDI0010:00: SDA Hold Time TX:RX = 72:1
    i2c_designware AMDI0010:00: Fast Mode HCNT:LCNT = 106:229
    i2c_designware AMDI0010:00: Bus speed: Fast Mode (400 kHz)

  the same use no longer logged "Touch jump detected".

So this entry does not belong in
i2c_acpi_force_100khz_device_ids. The follow-up will be a separate
i2c-designware patch: in i2c_dw_acpi_configure(), when SSCN/FMCN are
absent, take fast-mode HCNT/LCNT from that _DSM and set SDA hold to
0x48, and leave the bus at the firmware speed. Please drop this one.

Thank you for the Ack, Mika, and sorry again.

Yuqi
