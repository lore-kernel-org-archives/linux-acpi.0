Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C5270540
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070884; cv=none; b=XDngTaubHfWxgCSJC5cZc+0VsHkmMsiRUV2xJFceeknWJqUixWMCP06xA/1A5VpQbTTP8VgZus074Tu21d/45PPky4uHzo+pbv7DaiM1wbMdzrBlWqCMLRG3BXF1Ah2aTqQ93t+AIdZ5cm/JVPVSkN4VFAZwA4NHMXILDcGi1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070884; c=relaxed/simple;
	bh=+0t5J3uKawirFSYDlt6mpuGzzmawvxPYoRdvTbLhz2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VznobSAmjx7zMrV6zm06uUMgjCUIRFtBzLLoibn98pEIwu50KkdnFwRK34go6YAudF49aCpPjsmvXkxTjZqoR9+IIwF8w9GWjSokA3irYuIrGE6R2WROB4JGYKIsUF1nZPBYvzjSA8zSQ7hDTLeoYjlAgiIg1pS4fIwxw4sVxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhzSr+NY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhzSr+NY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3412126f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778070880; x=1778675680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQK5Udi7dRRSC+3+y19Y1o4p+F8AR8D8gNY8SQ+8KnI=;
        b=IhzSr+NYHKIK3wS1nYaGOkf9e3+egFK97OxgDS7oF2cWZqBvZ4/OQ61bq/KKOVv8DS
         9r/4OLLNtEgf3o8BWXH83AxtO5tpVTYGvm78jV7yKPs7glAlZDM6Ei7atLnrQI8xxRBZ
         sOB4tx8uQJ+ZolpzraJGwggD+1c4IQRoKAPEQ5H1vozQiV61e4DtYD7ecuXLHB02xrRz
         KOgq6GWCpzCjlt8Cn9jL8zTH8RSfe2L6jOwjMN4tfqmd1FStoxJ8cay4qprjD5wyJsmA
         YhTu9Tf6yDC1etwLACauoui2uf6gegjkqG+YYdFIYPuc/zPbdRor4ltQro9Glw/0jR33
         qi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778070880; x=1778675680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQK5Udi7dRRSC+3+y19Y1o4p+F8AR8D8gNY8SQ+8KnI=;
        b=CGwg0kMV7AP2pK2uBLowoAUb7bowpBXL27GYizSIWW/kKmIO6/cSWencGNZ/WL0Jy7
         qaxmmBrdwP0v98TreSWpY8J0OKBBx7yJ/jnKMQ7ULGjo0PJxAnsIF9JiEczywEBOYDmP
         zRwEgqwv5DgHRizG5fV7vfqBni3TaUdTyq3Q+Olf6Pd3yySEbEYqQ0B9vr4a9LfenlXh
         LYKcgCaZZ4t3w3t+WtauKDJZeWvJ1HUltgxpkynNdsXaSVMkWLsmhGD6Ws5KlOdAwcJr
         mFJIEMw/wB1WgbL8TZDUlR+5IKkdP4CZ5m2bdpXl48BBG0Ftm9PK5bVTc7sa11PcIBWV
         ijDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rJMbbf7OyMtTi2p69vWcuMVRzAXwJ9c1ylf5BOTDs3b78+X0aoosN98hHfOVEfigOFyEaUZc1lVX5@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVyrFNu77E6MUYbojdCmIRNTp8DU6LBQMgwDVPiT5LJ+30M3p
	LEIuUuVkFLbpht6X+Ec/n+CsmqPEAHytL5/Lj12WjPBDUe4g8LzxZgigMJTYfiStNXtk1xbZ
X-Gm-Gg: AeBDievKRIOpkARAzzN4auWwX8JIJ9DuM2MOWOHCGOwO7MXiTvkBv11jj6bb00uS6t3
	QfbxBQK3mCk7+nAaVCLZAiyoQGpWgmGuMbP8PexjZWfuc/QWq7xTSBPwZPr334KPGqgxwZDeEMF
	WmEcqNmvDeKiGHH8SrzsZ0fEputxY9cuJaqheZXWkXu69YDZat2oT2aViUV8upiZDe/Inz2bWIg
	HXEx5h1W2IYH9NbD6okuwBLeetRr2DdXDeYF6ILU1uDJzrrz/LNMmZaZtTqA0lyoRaDv7RK8DfJ
	klli50l2mC8/G3hY8UEV8RfYf+454ZhnHgRKj1DMSe+IuJBp669reMDwA7pieYm4bLprVSwf4Xa
	stJ3cVNPHY2LiW5RMroB7PN3sZdVo1YlhSeA/9Qx3OYeoqaD1aDqvIpR9lY/7aDf1oG4ttKdPuS
	t7HpPv1u4nyWyfALY8z0SEbkdLcA==
X-Received: by 2002:a05:6000:e90:b0:44f:f454:8a4d with SMTP id ffacd0b85a97d-4515ce1ca3amr4245062f8f.23.1778070879846;
        Wed, 06 May 2026 05:34:39 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03df9sm11951459f8f.24.2026.05.06.05.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:34:39 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: mathias.nyman@intel.com,
	andriy.shevchenko@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi@icloud.com>
Subject: [PATCH v2 0/3] gpio: acpi: modernize resource management using cleanup.h
Date: Wed,  6 May 2026 14:34:21 +0200
Message-ID: <20260506123427.1077274-1-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506113215.GK6785@://intel.com>
References: <20260506113215.GK6785@://intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Scardovi <mscardovi@icloud.com>

*** BLURB HERE ***

Hi Mika,
thanks for the quick reply. Unfortunately I noticed too late that thunderbird had
broken my patch during copy/paste. I'm pushing it again using git send-mail.
I've divided tha patch in 3 smaller pieces: let me know if it is ok for you and
Andy. In the meantime I'm testing it against KASAN and kmemleak as You suggested.

Let me know if there's anything else I need to improve.

Marco Scardovi (3):
  gpio: acpi: modernize resource management using cleanup.h
  gpio: acpi: modernize resource management using cleanup.h
  gpio: acpi: modernize resource management using cleanup.h

 drivers/gpio/gpiolib-acpi-core.c | 68 ++++++++++++++++----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

-- 
2.54.0

