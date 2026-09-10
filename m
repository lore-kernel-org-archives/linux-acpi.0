Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FE4825B6
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051879; cv=pass; b=CP4ZhmwfHBS+qkCZDP5PY8W7QdzmEYwZlSfOgRMIJ81h5RgYNfdjZ+gJVu5GwlqE5q4S1quJKTSfe9BMgIkd/kpEEMJ22DwcTMraJ5opGbQCUxWA6iIHVONkdKNrtHLpY7yawdXuxmuvl+tXP30nfyaomWQCotS8ZgO65jfVCbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051879; c=relaxed/simple;
	bh=b34I2AwfQYdUNFIb9GLKQdVS6ni82UwDJyTOzmC498A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Gwbs49HUU+CK2YGejn7jrdHPpQhAXQ25rt9IS7hhn6QzTSyY3oR58rnHvawHdVqbCQX0ukqfXLa4foEzTBDqWNxlhCEnXyqPIf7ys9DET1bi4ilU0ghNSNVdYtHZwvSm72PDTFQ/9TJEV0hY07mlAYgfzhL4SJ01spT2J+tlhxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjDFX/LV; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjDFX/LV"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-671199440fcso681398d50.3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 07:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789051876; cv=none;
        d=google.com; s=arc-20260327;
        b=WfietE8fCo/7s/YpCo115AAn5LasPrxOkR2B1JscU51dtdnba0NZ8oH6reA2wx/SBH
         MAsk3YsVLvNiF5veU1SgpwMxg72nCvMCUTnzXgDWNWO/SD6jkvwBFYNOnS9ldGc6Wyev
         4oAuILaJlY70CNQsyM6+43TwnH2nqyJmHaWgENAg5I8E7j4SgoKwu8KWEZH8MNRNj5oJ
         ATOK9qENo15umUwoR6GAWjDT6boK+f5cVlMSXvmcZmLXvuvIqr1X2LXSBu1pQsivL5Xq
         ZL580FPQ1GPjFjfccLkKLY4qXU7Fl68Sa7WzWcHPANx1G85O+R4rZyKIy6WHp0ouKn5r
         KJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7OlwrXGRxANbCh5aLwzdoFFGDRGqfexBFwjrOVLdFz0=;
        fh=SejTj4q8DPB6YPcJ5SrAixVEg/gpiHytTXF2h7Rn7nE=;
        b=YETtgNs9fQgh+OAcNPJ0vOlf7Fs1GiHcNjw8GfiLeDJCYoZUPg1f1nq3SUNa/B0sSi
         cVXKAZl+EoYyEBel25bsrw152IoceY0v1gzDzASgrI1WmG718PF6M0nAt8hBfAf4Te1Q
         T3MWxo/plwjsSrKt4v3Og0sJ8UkUYC5CFvACUz2IrJy2vCXOaObK0kB+0afKEEI5hcEd
         xGIePO9Rw1CpJf0uh7tzN/8pvleeEMMYjEF1cfm8U9ZYZr8g6YTgGgoXaihu/BixvHAt
         zibA7a6jpLto9WxswMKBOmk+Q/9t8A45ncBFC5tz4/kLkLbWMaTiElYbN6Y7apfvEhnm
         IdMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789051876; x=1789656676; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OlwrXGRxANbCh5aLwzdoFFGDRGqfexBFwjrOVLdFz0=;
        b=qjDFX/LVpRRyMcbwU5aDRX9uf/lDGgxt+/KFI2r0eUDpxvnS7d7p+gbqNEn6dGaeLY
         kHnb9kgSV2Qa1bBkbLPcQyeStR+6fMBRl9ZZy6TpUT9gJatXfcPKcK63JpsvRuXySdYY
         Q92dsv3+wCyQbIeZSQxaaIuzQJlUR6cw7xD4rndlmIlrgaaEsTghhRddT49NF5GsLOQx
         BKmxvLz+jeIJ5UyrL+BBRDkzenNTOzCaEHu2xzjDXbhNcNBDx3LWIMxyw9DJ4hEEzN7c
         +TTc0n4pryemVmCIGAUw48fahUfpakw62jXiGQ42VqbHrrcc7LgGw+tSB2I9qHtlxZ/h
         SkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051876; x=1789656676;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7OlwrXGRxANbCh5aLwzdoFFGDRGqfexBFwjrOVLdFz0=;
        b=a7g3sLNyM/RXgFsiPO8dyPK4xvX+f2ef5UZTJEzxsui0ef5isYvDD3fk1x4mA8QETr
         BHUnrUtX9exuhJpXx6ZcjllRfUaJHwXiDH08cbfTRt9HZceRb1gbZ+3vSlq5oa5FcEcl
         11jqJt5vXJvKvxa9hiVNnyi67P0iNx6BWY9TRp1BBXJCZP5UwUsGPxik2C9tmCvVjJmZ
         znSykXmT4LuQABVBwQTWaIhxqYrtu67SchHFFmnzxOkD06FrgFPK0xPm9TvSjftD35w5
         V1uP6WfBJgy4Yx/fOnGrppWmM+sarb2gq+7I3IG3Gn3LRwprjdE6qpkCxkOYa9afMCoG
         RkaA==
X-Gm-Message-State: AFuF++nXghS3GOUwhPQzQ+ObHSEazxu4J+vfwzsRKHldch0imnx45S4k
	yYopk7S95cyOiZY96Z2Q2qbQLJ7s44DMiSn0tVZMcz0G/LP3n3rj35KegJbS6duMS7GKopV8fc4
	sQokQ8KSpt2pPwkvy5NGeNcwi2xPKyMo=
X-Gm-Gg: AYBFou1jHoh3MZCj8LmjN1AJOrFNlxu/O9OhFHhhwB6tZImPufGvd5WTtq2ww5vQSC1
	IcTVnY4GILmdOIEqI5Egxmv/foJU8k1fttkHLkX/lhjiAMColMUA64XUV/Apmu2C6bmTLpZKKqe
	fU4eGiuILMfN0SZO5z+M448BCc08cY6qSsLjsf3P7HtTT3BZcIqrQtI0AynYa7zZamon2q3f9Xo
	7IKcb6IlEAH/GFJL2TEd3kdTuRsCiOB3jQWTJwQ0t+HzNIz/Eu6nMFhv8bxmhi45h0GkSGzCUEI
	UV+3sTXwQIEvrlWtWMyT8ari7S9a2nEcLx1FvDDPeE0gY6szaJgaAPex3+HoFvrX6MJnNElU/fs
	3tNoZcXAO3KcVGRKHB0MT6C97uhjpSht0oc1WL6gDy4elE7jVAK/RXkY++A==
X-Received: by 2002:a05:690e:42c2:b0:66d:113a:3928 with SMTP id
 956f58d0204a3-66fb596aec9mr9455951d50.12.1789051875769; Thu, 10 Sep 2026
 07:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marcel Moosbrugger <marcelmoosbrugger@gmail.com>
Date: Thu, 10 Sep 2026 16:51:04 +0200
X-Gm-Features: AcwNN1W4qqornyMomI8be8O6y2FOBOe1tK3kMf2k2XgTe5kTH5uGTdpAiZdLkxg
Message-ID: <CABtUotP4Ay3HDkrZX_KcHQ=XHJ8wp+Q34yPTiRT65NMoO50hxw@mail.gmail.com>
Subject: bert.c zeroes block_status, so the sysfs BERT copy looks empty to userspace
To: "tony.luck@intel.com" <tony.luck@intel.com>, rafael@kernel.org
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

A usability trap I hit while decoding BERT records by hand, on a machine
where the record is too large to print.

The kernel logs:

  BERT: [Hardware Error]: Skipped 1 error records
  BERT: Total records found: 1

and for oversized records the code points userspace at
/sys/firmware/acpi/tables/data/BERT. But bert_print_all() clears
block_status once a record has been handled, since the boot error source is
one-time polled. Userspace reading that sysfs file afterwards therefore sees
block_status == 0 while data_length and the Generic Error Data Entries are
still intact.

Anything that follows the spec and treats block_status == 0 as "no error
records" will silently discard a real record. My own harvester did exactly
that and labelled a FATAL SoC/PMC crashlog "empty BERT" for four days. The
fix on my side was to ignore block_status and walk data_length.

I do not know whether the right answer is to leave the sysfs copy alone or
just to document it, and I am not attached to either. But since the kernel
explicitly directs people to that file for exactly the records it did not
print, a note somewhere would save the next person the same four days.

Context, if it helps: https://bugzilla.kernel.org/show_bug.cgi?id=221923

Thanks,

>> DI Dr.techn. Marcel Moosbrugger, BSc
>> Computer Science - Researcher - Communicator
>> marcelmoos.com - linkedin.com/in/marcelmoos
