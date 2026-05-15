Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0C3B6371
	for <linux-acpi@vger.kernel.org>; Fri, 15 May 2026 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858839; cv=pass; b=q78s6aCJLz/jxuhKVhoD2AjVvwe9v7qGWGywZ55MFWvA2JPdE0A/+PLcXGK1uiYQQ3KlBI5twfUeOCDpNlrCT92IdKX+dKJdBaFEA+rvgl9Gw3Tq3Gyi4/b3GAwbqs3kYsyjaWJ80++gnTU2zYJf3/+01IBX7VKpq4FuKIhDWII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858839; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gTHVlUi4NIdrJCwRMIh+biiQUl5z+MLmqZsb7sbNRO4MfsuMOX3utpyYt7YcUuaOGGEuP1eXCxVy4TTalHexcAUveTmkFCMNfpWWqNYsbR6tQL5icR9xXnjN085GOi5b6xqtHyuWd0Cy6KMQ6eWnq/2hzFW28htckOi+JxfMVpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYfOgZGq; arc=pass smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYfOgZGq"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso9474257a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 15 May 2026 08:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778858836; cv=none;
        d=google.com; s=arc-20240605;
        b=fYa3amkdC8ZXysQIuvp8Rc1IuITUGhNmY6bqLvlf009irByd51XxJ2+G5p3Jlk1WiB
         TofH66MZpF+uagejwRQ7/+JPK8U6GxfPADqrAFUHS/mHU9gWbqqljzdUXHTRjWUxiJGN
         q/3wn9sIBUxABCBQYLA7mk+VTHblZ+fAkzbddUdnnjeukTdyo+UfKhXW46MOXE5UAjHW
         bcNscIJ20yNLSgRi17u2RVUgZ2qxfGLh6q0Zp0+wdbzV5sVWuHeXROYRUp3ts6I5g9o3
         q9Swg4AqNbbMvrEWPoD2/Uxp8HIK5ELM9Rwl/T5jZ3mmNFF2C8z5STxtcQtjxPaoX4YJ
         Joig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        fh=GmFy5nA39On4RWbrn/GETH8dUHq8oY5XORs93v5i3qg=;
        b=PmFH30WBpVNzQuJM8qTeNCYkYEcFzGfQOwO0og1PxXKIqGOCNzBtfLNY3KQ09/PxcF
         dUMmUUE7/NEmE5yLAvwTah7Ju0vS0bHE5/qDBXOVknTaeJGDVFmKcFjxU+QKKYKnklRt
         m1IuVBX2/sGk1vRTxI1QZgAFJKoLi4zO60uO5inroe08+R6Cm80bl3qOhsuYHJGKX9Yx
         2ZWZSzX4pB1jJ3g2l5eUS4wA9M2sSTx9NfRLATfDA8Iuu481sIIFzlbSw4w/gwCa1ohj
         T9+/2GCraaRobczz5C1TIahNdWxYOH7XQW9c+qCPuZj3UivTbjdsTAemq6MxKXzEap2n
         fxYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858836; x=1779463636; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=HYfOgZGqyfaAzbet7yCDBVMhNyNRUg+l9ndDbg/LnS0Db6Ol0b9gcl3TvQNOV953OB
         um2CkZFr9co27ehE9A5hzvGN6hMs782aFbIIExj28WzRVYFETstB/MOL22lCBsGm8Ksn
         EGMVoksfFSN/kbbl5yxsUxeVCmoIS27chFP6TLtlc4kJYsNMA23CdiXcIq3WD/QW8KRp
         Xd0T4nsao6cMNVbUCvV7F3nXz7DQf3hreeNr5Uk+8km+2AssoZI5kQCQmkLNzQCCxtsA
         oQ26eMQc/bDq95Got2jbJJFkk0o35BHTXCqH1sCz3NCMQJM/2gXWgVBg1hTX1Y+hAmWA
         v0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858836; x=1779463636;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=Mo6blSp7nN3i4F9tBoBb0WINzfauXykdY/lIVMm6ZpTL6aEKli3nVOLDTKve2znY3f
         4WbZzi0ZerkG73JsIWin9ULo92T+6WXUtXMBqDZdMKTWm+KHvihqG3V3I+g+rRp6fgNq
         7XD23TxslNunFi2rEU1XRN1pi49ux36wBO6gt9JRCByCdM/mgy/6dQ4aJ3USytT22Z0X
         fFpk6+WOX5rjDBF+kaM8KvAyN6nfLRuQDDtuI08M2IvE8gWy+awFIt40S77/uZt7Vf2p
         tHnsekYiI1QY2IXKzT/97n4DyET9SpqQTbHQcxVqvYYYan46N95HZ4Np2YzWnqPLjTvQ
         V9rA==
X-Gm-Message-State: AOJu0YynAoAd21P/+D1Ie1XJSpFzrY+7qD/NgDDkGtvUngTK7oPhcyit
	DNHXhyORHsIJF74v47PF1pIELDAmk8+Ucm6gOM5Zth/a63xLESmxYtcfjvw4rp9GoQs6VfvqEhl
	Fut6gUp6FNQPWv9lmo1nMcDBaJkgwmwjAur292w0dsQ==
X-Gm-Gg: Acq92OHDMs/N7Mt3cE+P0oksHEo15gk6ODBcxUkbUHZhP+u2nWm5uv0JGAytovOh7ci
	ijphV3F+RwUquekbWlXCWnaQ2CBX7/0dKWhyU+JmiblVl3mkLH2ROMKc9El64//tYg/PB4t8UW4
	LwOwgRTitQOTYAld4AuW9MHUyIgMXlHNKuk7nIoWpavyQC1uNJc1XFKZ+9axYjGUYMOISCr0Ych
	lUmkSg+LD/fpy+OqgjucGqvhmfSmj4qceUPzTWR5C7iFoayoam8pNX4M5mSNpE6E7Wjh/x+5HZM
	IZPW21EXaz1IjZtf
X-Received: by 2002:a05:6402:358e:b0:674:40c3:f047 with SMTP id
 4fb4d7f45d1cf-683bcd9eefbmr2411953a12.12.1778858835876; Fri, 15 May 2026
 08:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: IM AgentX <imagent4bd@gmail.com>
Date: Fri, 15 May 2026 23:27:04 +0800
X-Gm-Features: AVHnY4KmXs6e09cj1nMHIkKucUuepn_5XvbEG6e13DmVN1TaRznVBsyV9U_lJt4
Message-ID: <CANUqUTUDBqs3zXv77QuzGHNQjqbckOJwJvwARy12UoBTwzsgLw@mail.gmail.com>
Subject: 
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe
