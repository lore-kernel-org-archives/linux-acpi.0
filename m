Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8F258CD9
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055932; cv=none; b=AS7JVSWanbi+R7GYt61vp0k7xgyjhD3dgKUisp00FlrKhGOlrNu7dwqD6a7/deWTlJS8Sy+e6Qf4bY7A55HNrpbFOJuGx8Xes/p/w9iqNsgdewM0imuCek4iDpi9faDy395Q2TqzAXE0RkNF2gkTTby4wGEqR5Ig8WAqxNt061A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055932; c=relaxed/simple;
	bh=MJBp72SKMyjsUAzv3mWv2+ZOo0GNt4ALfKXaxFLidIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5w5HBDKsYLznkPI/uIuHRXJq8kAPmkmBOt7ZZGb6Wfd8mbX/8YJDo5ViVgu0idNLAZXXZxJDEWe+5xW6ZM1xO9lhByYjoF2gFe9FfLX61G8KngZwEqe4nxrv5lQLovNTfta5iVzNeC3moUupUF8Q/kN+mMSaLeQlMLXOxQXbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QIVfsdJd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QIVfsdJd"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91562bf6c12so754049685a.2
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 18:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781055926; x=1781660726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+GrVwUVnyXoJ3l/Ws8SD/JHytJBmijCAuGEqrIfnVw=;
        b=QIVfsdJdxRWb4Oy76ocNAdd0yvYcwrWH5A9XsF2lC8tFbL2vwY1D1hVcfrlgoLofRI
         EYwycpkhujwSGdjaOT25GTGEFuAL0SaaRxUaa8iZ/GzWHAYJSi0SUY2ihotN8ITcbMiF
         nIRQ4dZa2CO+llnHJTGqodzQ3LPVMNYTedaieYmnUm8pU7eAeuaZ11qlEGNLxRuXrxRx
         wycCnfcCTieT7z4Aed1zQMn/2vOV5Q8L5Tmv52Vo/fkJ41CdzL/LlKC+JWYTH716JtWk
         3ahNiOvmEBlYnAZUzJJJMnfiXhooV1X+ENefRC3mEgtnPEm3X08ZXzPRKYsB04f0RVNy
         YfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781055926; x=1781660726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+GrVwUVnyXoJ3l/Ws8SD/JHytJBmijCAuGEqrIfnVw=;
        b=WK1rjotmcdSLucuOnt3IZM+YxURYhH50gxWSU8kc86884qGSYSrmySNSMoHe8lTB/g
         WpVoHvenyYrbdcO7F5YKTAwf8Fxqa4rjRsZFYsZIiJ0BumHNgX4TIzeGmjy/ysR7u6zD
         HSy7SOO2LlQV0Aax+Gg6MWhn2Qd7hPqNykoOngaUMEOBR356ybrwgP1R6midsB1qvRbc
         X/JJnf40ZQxgMnbu83ZulIiQRiJRBUAKlJIv88YaehYYvectq0OAtVtlOfSLnCSgmHwx
         Lg6mpL9nhCm2i/nKJ9Ns+Urk9yOBd8rIGp8Z38nWfub1SVc8Q45ZFJw6P7RATsRkZbYe
         llkg==
X-Forwarded-Encrypted: i=1; AFNElJ/tD1wks1cIRbUCdU8HCyFvJsGJYXCHwyyhd9+UEuumZrtMY8X0mdANpiQTgNUjUKjCa4OTbUgDB/AT@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSS+5TNIieDY3oWCgjjUec/A486qaxptV89tmT26id3PRx7th
	mEQRq6LgNAddnaGHLR7KWZ4R+4HY3hNP5D4ffBEnqsvswL3Qn33XOp6fk3Ee2jnOFOU=
X-Gm-Gg: Acq92OGfowXNauku+4Fhy1ODHbX1K/43TolqkBifRQSCT6llEVYHgNWeSWzX69UVa8w
	ZeyvHGx3sG1rS/R0RgNFMoeYlARzc658G2eHv/S63kodTtM4KvAdRZTn+Wr+APwPbWyCOZV009r
	smKClVB91pGM3IUUb0rj3mZC4/QLZH4SHJl/TpwfLaNQklpV7zCE+rLjm6uZdCnjdkhBYw6E+u8
	ah/wZuJo/kb1CT0Nx0DS1SftBeVrR7U7Pon307ivuoqy++RZ4irbwQUSnz5zCuhJgjfMEC7Vtvq
	LjY/BMjQVmgzDVRgsPQVpuu+q65vcTgMmyRajO6omTgyYvQ49pdFNV/jN3x2Twf39ykGDdsJXsS
	z05HuDdSNDLvEzMIfBqZA6ckkq75JXMLvNS50w5iMIF0k8WhZbNbsBKrOEDSgsWaH6mrCGHKD+H
	M+oYQ6bctF9som/GW553RxtNp8i4FXpjbq6btCp5J4vZZMi8dlvQupkVkyo8J/Qcrto94gLJuTg
	9aqrD8n/FPhw4NjP1FapZ4=
X-Received: by 2002:ac8:7612:0:b0:517:a02f:171a with SMTP id d75a77b69052e-517a02f1d7bmr208979241cf.36.1781055925526;
        Tue, 09 Jun 2026 18:45:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm205923261cf.4.2026.06.09.18.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:45:24 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	kernel-team@meta.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	rdunlap@infradead.org,
	feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com,
	elver@google.com,
	kuba@kernel.org,
	ebiggers@kernel.org,
	lirongqing@baidu.com,
	paulmck@kernel.org,
	gourry@gourry.net,
	dave.jiang@intel.com,
	jic23@kernel.org,
	xueshuai@linux.alibaba.com,
	kai.huang@intel.com
Subject: [RFC PATCH 0/3] mm/numa: reserve standby NUMA nodes for runtime claiming
Date: Tue,  9 Jun 2026 21:45:14 -0400
Message-ID: <20260610014517.253609-1-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NUMA node must be "possible" at __init time to be usable later; a node
that is not described at boot cannot be brought online afterwards.

For memory tiering or isolation it is sometimes desirable to spread
hotplug memory (CXL, GPU, virtio-mem, ...) across more nodes than
firmware describes.  Additionally, some memory devices may provide
more than a single class of memory and need flexibility to redefine
the effective topology at runtime instead of depending on BIOS.

This series adds a way to reserve empty "standby" NUMA nodes at boot
so drivers can place hotplugged memory on distinct nodes later, at
runtime, without those nodes being described by BIOS.

Using the feature
=================
A standby node is an empty, offline-but-possible NUMA node: at boot it
has no memory and no CPUs.  A driver claims one at runtime, brings
memory online on it, and releases it when done.

This series adds 3 ways to reserve standby nodes.

  - numa=standby=N
      Boot parameter.  Reserve N extra empty nodes.  Platform
      independent; works with or without ACPI.

  - CONFIG_ACPI_NUMA_STANDBY_NODES=N
      Reserve N extra empty nodes on ACPI systems (honoured only when
      firmware produces a usable NUMA configuration).

  - CONFIG_ACPI_NUMA_ADD_CFMWS_NODES=K
      Reserve K extra empty nodes per CXL Fixed Memory Window (CEDT
      CFMWS), for CXL topologies that want several nodes behind one
      window.

All three default to off (0 / unset).

Reserved nodes show up in /sys/devices/system/node/possible but not
.../online until a driver claims one and onlines memory on it.

Testing
=======
Built and booted under QEMU (virtme-ng) across a matrix of boot
parameters and topologies:

  - Each reservation source, individually and combined: reserved nodes
    appear as possible-but-offline with no memory, claim/release
    round-trips correctly, and node distances are sane.

    The CFMWS path was exercised with an emulated CXL Type-3 device
    presenting a CEDT/CFMWS.

  - Fallback: when ACPI NUMA init does not produce a usable config,
    no standby nodes are reserved.

  - NUMA emulation (numa=fake): renumbers the node space.

    Standby nodes are created only after the (possibly emulated)
    topology is final, so their ids can never alias emulated nodes.

    numa=fake boots cleanly with the feature enabled and behaves
    identically to a baseline kernel without this series.

    Tested with CONFIG_NUMA_EMU both enabled and disabled, and with
    and without numa=fake on the command line.

  - Default-off builds behave identically to a baseline kernel.

Gregory Price (3):
mm/numa: add exclusive node pool and numa=standby boot parameter
acpi/numa: add CONFIG_ACPI_NUMA_STANDBY_NODES
acpi/numa: add CONFIG_ACPI_NUMA_ADD_CFMWS_NODES

 .../admin-guide/kernel-parameters.txt         |   8 ++
 arch/x86/mm/numa.c                            |   2 +
 drivers/acpi/numa/Kconfig                     |  35 ++++++
 drivers/acpi/numa/srat.c                      |  14 ++-
 drivers/base/arch_numa.c                      |   2 +
 include/linux/numa.h                          |  14 +++
 include/linux/numa_memblks.h                  |   3 +
 mm/numa.c                                     |  90 +++++++++++++
 mm/numa_memblks.c                             | 118 +++++++++++++++++-
 9 files changed, 284 insertions(+), 2 deletions(-)

--
2.54.0

