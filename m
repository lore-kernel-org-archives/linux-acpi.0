Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286659;
	b=kz5ToZyOXaEpvgKKNku7KMCMi7hFuFPitHOBCsU1IWuJQNBqmkI2nsDl8SEj+rZcfqEx
	 LybtuxwrVzpKmP3Gy8BgrHPqhDvWl1BJ3OQ9bgLqtYS5zQW2Vq5CRJED+Nn+T9LGL/Eku
	 KzVIiJX1byj+OU1wLUJq0TLDFdXkWRN7SbhWCORJe+sXEjNRLSkr1k0ce5CXV5K2G0t5Y
	 1spT0y1d05lz+/UhFPXuW74IpMPkeBpp+3NaomiMmMgVNSpw3HKExBjvHLQm7zY5LFlfj
	 tXOeXoCesVz+cCtYdK9s2j4vhqL7s+ZUk8/J54LUVoaieOn0X/SOfDv8+Td+WdFOEcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G8cNe0vIDRqZFn4+nV+82o9Gia0vdZIXG/CoMPVcrRk=;
	b=FOY8G74tG/PTsCn4MY8NQQwi6qAdNEdeGLiFA4nbRXKVEiULuJAbIU12KKz2ZlP8bwcm
	 2YH7MT3hhsUkp+XI1g9dI0n4jpEID0dgMlhlvt5gxKG6WU/idpaNJO6SQ2w4k2wT/VOHm
	 0G4srsZ8UXvkDTm+Kqss+SCAVCrgXIQSVaHf8u99Rte0IqGcZpoKqfdjmSiSoMM+ST6fu
	 1V9DTfysuf2Y46H1Vte2aLdT7WmuwWwj60IuHWwuoiz9o6FhBrX3/Lqto190W2NiZdyiu
	 t9ZiSwJzSMdo5gTTFd3/49FxOvmEeKPz4BBVgdjsqWHl/WDFOehRecui3A4xg554WbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpQqGpjW;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5685606A31D
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 15:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5685606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpQqGpjW
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so2538647c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793286658; x=1793891458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8cNe0vIDRqZFn4+nV+82o9Gia0vdZIXG/CoMPVcrRk=;
        b=WpQqGpjW+ZTfSHK0//mGHKzJyuHbZ7C9dLgAuRjn/zP8brmYCt8mCzMLoSj/FXaDjk
         sNSJuq9gkdWMPJ32BuJHZqdT8WCo9oCZVUGqk26bKiEx/3PMMIhjyzjcr4JfYI7FsFLu
         Cq79BHQPD2UgZXv7AMOvewB4vnhxNaMxhssAO0IMYT/DvQxV7FB06+M6dpusB2gAiisp
         jRE+ru1Tw8aJHIrkNMcHly6I0escIRdsrsmFMkS3dsa0CMb7CeI2IbG9AA5He7PXim96
         VEB26AhbLZk9oJWwscKOga8Snu5CLj+NIMNs+3N+eWy18dh1O6jXO0ixjnZbyqt0NfB5
         J3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286658; x=1793891458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8cNe0vIDRqZFn4+nV+82o9Gia0vdZIXG/CoMPVcrRk=;
        b=C/doN//+fR9waXn0pnIUGBfCV3dll0vAgem87OsqQoXZ3DcN+f4HvCvgn/h4/zZWWb
         JVMIxBpNHH0B1HnomI0/P8AvucaNjHUAguUy9+TCv4LxqT5NyFm/eFEeZIaGdBrS+cQf
         fm0h/NPNUzE3PDXZh9IivyChRQ9sOW52TUPOIaFY8YokxxjQLP3vFOwE59ZzAq/5nd1a
         LMQAvdvhz9+NwdFa9gee0j8FZHJf836wWQ7o6AyFvjUbsf1GWqVjtJg+9ZkNGv7pEf0v
         4hG7p+cYy8EDzY7GpVuDPj9cetOy+yek2kIeykia1gF+CbBOccZ/WesbPnV6AFe5HlH1
         3ZWQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4NcoJFzIP4c9ZqiArtxA1wT6Dl9Ef63nkyd0hsMn0RydpauhQ0bNOoSkf/6p7kEDD12z2SjlE7X3l@vger.kernel.org
X-Gm-Message-State: AFq9FYLD5xZHPsTwzYr2mFH/YMKf0cJc+83hNHOdvD/3dAYBUW4gS8QN
	xIcS959hjM5o0rny2h79kPSHMjR1rucx58/dmIjJHmVd2IfUjgrHvP4=
X-Gm-Gg: AYBFou2YaKNt8uyPiyUHgSnFTKnsZvRyKSXzhrwPZvmu9H7x5YnxPnG/77stzxQ+N96
	qvsEOaQYrUO7s8ruoIwo1Eznf9O9zcreNauBPJ549pdEYzOr4PBzZzaOrqpmmlw0GruNLRVKUIY
	JqKhCdyWZK0Yixcv2nTHJSqigljFDh593wC5e2rZZmlwoWGjkQMb0beCOT977nVQHxQrTegdhN6
	pnkOXUvkV93BEp2n0YkqdyYVPl6cHLS4Lz4Plh0v7CffKvC/JKHLbPhBSuQD8l1hc8C1XjQqFLa
	3I8hgzmAYYbeA+UsVPPp+SY3Oc5LnWrnLKN111/5qdKzpgggU5gwS2d/JBCbBkXzmwfYQieMwGB
	NI5FInWxzWKhUOdV3QAm505KUxROacvmtoUhLQfiZGuRUxHzdCMzArBeTx5CA9SVK4ln+9oek4G
	PCOkpZqMGfmC+MCYLcbYqsggStpJfJhalaW0W58KJmO3izNMgbwF60UAKoKGI0Ix5qvSbRSRJLT
	ynFXLk65nIetRO7lIsBG5J5ILxqrawcizSvCBxJgxkNJvikY6uHTiTb7FhJ4hOSw7MvOO3sClum
	w4KYlGbfxtEzGs5qnyD+ra0mzjDEv+kmGMLP+Ryxk4E8jxe2zaBP97KP6zTRqPF1GA==
X-Received: by 2002:a05:7022:f50f:b0:18d:9eec:e0be with SMTP id a92af1059eb24-1a6c9cda82bmr7738949c88.2.1793286657636;
        Thu, 29 Oct 2026 08:10:57 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e5c6d4fsm27327662c88.14.2026.10.29.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:10:57 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: atharvatiwarilinuxdev@gmail.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH RESEND] ACPI: processor: Use Apple-specific methods for P/C-states
Date: Thu, 29 Oct 2026 11:10:51 -0400
Message-ID: <20261029151051.1124-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015204450.1270-1-atharvatiwarilinuxdev@gmail.com>
References: <20261015204450.1270-1-atharvatiwarilinuxdev@gmail.com>
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

Hi can i please get a update on this, i sent this patch almost 15 days
ago.

Thanks.
