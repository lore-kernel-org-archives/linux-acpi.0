Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF983DBD53
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181775; cv=none; b=dw5VZGSW4mmaGxsvwjcJmOa+UrTtN0j59MmQZ5pshGuL+XwJ8BGthI3XsRk7nj/H9X/xYQOKPm6SDWQ7HYk5FoSQGVqih5VeZ70d9foUy4z3HZk9SJOjqVnAemkzeDSf5yWAc8+PJ1R28phIkH4O0ZBDcu0FEdAKDP7BIQqkYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181775; c=relaxed/simple;
	bh=z1z6R0nJmox6ojIS2va5xdyWXMdp20/QF8syKYAi1IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MTcXrbNcuiZugeQDuwZM2NF8AAMFoERPeMy/mBfDUR80Vc1pp8l03460hYm/24qXHA/wJxhQM7c5uYzwmV0p0PuOtgGcgHQtGXSYQbI/Z2YCphOyF+/ZQhqAqCIYEC52ywsr2clo5pFaMD3o3rdgVpOzia10/cgB1dRcUPqNdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9E4x9ql; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9E4x9ql"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2be1dd4af34so14756645ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779181773; x=1779786573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zz10nV84PwNP40SOJ1J8qP/A1B5s58lMhIi8+aPk9U=;
        b=r9E4x9qlLKU38jP7MR54YLw2AyBV2cq8DJ/KphS8mgfbqsGC3l/T0Ok05DJIOny9QR
         DRk6ZdUndG7lXqNBh4H8U1vlV6j5yWjKsvgkwuNykw4yDOzfefAiF5s7IXYCQctr4HnU
         BqIYXJBdEqiWSKFkMHaA+abGRVeBR1aC1TIpKJ15665s38zwMazoGJH2KF5WI2oqP+Rx
         yFigaYom+xPcBUQ83c+SAOLDwkjm/75myNE+jMg3Zadgbr/6tsj47sy8WcUGUz5XwiLt
         iE/xly8ShitB2CIpVxFy7XzsiiHD0ruQwWE6kO3KRr0PxtEAsjqp9sLW7LVTKO33GJwR
         4jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779181773; x=1779786573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zz10nV84PwNP40SOJ1J8qP/A1B5s58lMhIi8+aPk9U=;
        b=E78TJJzFt2oMm9CjOwceBSFpaia92AqboodM5Alp6MAHwcdyQ5PjX1uIRp+L3+aADY
         GcVitC01mFI0sByo6ecxTURGx9NJZxT+xCWOhLwjfIQ53ucwc3qVadT8SP2wx49k3IPS
         Ly73t90fh7eXjfIjzn0esVS1a6nWED6kkGX7FBvv+143jFxI2xqYzOKWHGP03E5bFXha
         pzV0Q2poQH9OLgr+oUQ5Zr+1kolULu3tg464NGDHoigPoyTTu0f5hjGsNKQeJy6pEMhR
         v4nshhp7j8ILEj9vvfjcZjC5/om9p3rcx0ZTyDJoZpspwtQjEGtoQfsOEKH/z/K8IL/F
         ViBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BlBYWXAL9iG+ts0G7/zn0/GLt/L9U1NG/YCqdjOruO0L/d9PG02JueFF9S267g7XSOC8sEPaPyUQc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx008KH3UFLvIdbfV+IOX8UM5Y33GOwB2Emin9Q2oJpxI9uhmE9
	C7bZYS7rGTAlGd3aXMSb2alRgFdQvJVhS26ROSMD4kb/TyL2MlRMbPc9
X-Gm-Gg: Acq92OFi4ByAwoF1Na18brwJ6CccqVzdkdW1PwcqtVetuoJ/IedVXE1RhBlIrmG4kQR
	in3rL9nwBAuZUJBDCYt+r6s4crmbv/5WH38TMXvY15npNccnM2TWqAeoliwp7ffWm0RBPtsr6sd
	SU8zW0+5JlpreT8xEO+H6RX17yoP4kVyw37kfvnLtAkwyOnNPjVAIjy2gy2n5ZnHxnaTHWdKwZJ
	J0VaqH3+NPg/lZbwfwFLaS+gPFCWZwza0+oPvP5IjuDH1W6FJcLPldAWBG9OUH7ySIrOOHJX03N
	7KAr2rYTiACO7R9/LLx6bqCkev6aQFSD5Dyppv4qJDBHDsUDiQYvrhDtW+0YA/cWS/drrYzxuVd
	rsyxyerTCjy1Mw97n410K+pij7MEo1N/o5579TGpZGgjGJeXi3MLfCQ/4tmYxEYSQ97yeK9WCiG
	m7UZ2OEwTcveAfCetOY5ZwCAHuZa+xy+p16lCg+/BkInexi+dR
X-Received: by 2002:a17:902:f547:b0:2ba:3e2f:6883 with SMTP id d9443c01a7336-2bd7e8f9108mr187154835ad.19.1779181773151;
        Tue, 19 May 2026 02:09:33 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2e7sm172753185ad.5.2026.05.19.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:09:32 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: acpi/riscv: iterator after loop end in riscv_acpi_register_ext_intc?
Date: Tue, 19 May 2026 17:09:28 +0800
Message-Id: <20260519090928.1952787-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

While reading drivers/acpi/riscv/irq.c I noticed something
that looks like a past the end iterator pattern, used in two
places in the same function. I would appreciate it if you
could take a look and let me know whether this is a real
issue, and whether it is worth fixing.

The site is riscv_acpi_register_ext_intc() (linux-7.1-rc1,
around line 155):

    list_for_each_entry(node, &ext_intc_list, list) {
            if (node->gsi_base < ext_intc_element->gsi_base)
                    break;
    }

    /* Adjust the previous node's GSI range if that has
       pending registration */
    prev = list_prev_entry(node, list);
    if (!list_entry_is_head(prev, &ext_intc_list, list)) {
            if (prev->flag & RISCV_ACPI_INTC_FLAG_PENDING)
                    prev->nr_irqs = ext_intc_element->gsi_base
                                    - prev->gsi_base;
    }

    list_add_tail(&ext_intc_element->list, &node->list);

When the loop walks all entries without break (no entry has
gsi_base smaller than the new one), node is past the end.
The function then uses node in two ways:

  1. list_prev_entry(node, list) relies on &node->list
     aliasing &ext_intc_list (the head) via container_of
     offset cancellation, so the result becomes the last
     real entry of the list (head->prev). The PENDING flag
     adjustment then runs on that last entry.

  2. list_add_tail(..., &node->list) relies on the same
     alias so the insert lands at the list tail.

Both behaviours are intended (sorted insertion plus a
fall-through path that still wants the last entry's PENDING
flag adjusted), but both dereferences of the past the end
node are undefined per C11.

Jakob Koschel cleaned up many such sites in 2022, for example
commits 99d8ae4ec8a (tracing: Remove usage of list iterator
variable after the loop), 2966a9918df (clockevents: Use
dedicated list iterator variable) and dc1acd5c946 (dlm:
replace usage of found with dedicated list iterator
variable). This site was not covered.

A candidate fix would track an explicit insertion target
(struct list_head *pos = &ext_intc_list) which is overwritten
to &node->list only when the loop breaks early. The PENDING
flag adjustment then reads pos->prev directly: if pos->prev
is &ext_intc_list (empty list, or break on the first entry),
the adjustment is skipped; otherwise pos->prev points to the
real entry that becomes the predecessor in list order. In the
fall-through path pos stays at the list head, and head->prev
is the last real entry, so that branch keeps adjusting the
last entry as before. Observable behaviour is unchanged.

If this is intentional or already known, please disregard.
Otherwise, I am happy to send a [PATCH] or to leave the fix
to you. Thank you for your time, and sorry for the noise if
this is not actually worth fixing or has already been spotted.

Thanks,
Maoyi Xie
https://maoyixie.com/
