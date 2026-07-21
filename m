Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70F342514
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639563; cv=none; b=qBeFSZ7Uquud7vegYYV1zLodNpO8zMz1V42BT7Yjeb6aCLdhbPBeGGiagTjio4JhA+QNfZ5psu+fJ94sclzNI/u9pzWgfzCPgQXTN5TfcSmlvY2Je9/nJPIlFNrjOjCFvr9EOsDbflCGoTca3GcYTrFcOeYRGv59ltJu/dBRrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639563; c=relaxed/simple;
	bh=nS5SJQmwq8NU5ulEg4x+lVkufqolSp3mR/z1Mkjawbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K28Wpt+wrMnx51piQUtRdjdOk9y6Qixddsn+8EGYMe9ruOc8XW7o0s9JXCPf7FBGjwLUxw6DzMpSaqGUcAJT4LeBciy+JnVi0DKzAr4xzaJh6EcPIbcpRkoHjrTAYso24zIAnZaORN8/zVFDaiGchfvO32H0LX03OYHG/8lBSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dEanDhrt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dEanDhrt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47362928f65so10253883f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639559; x=1785244359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXH/AcaDYaWjD1D7W7UeWMormFqpNiZzAjn7k+W0SEQ=;
        b=dEanDhrt+jUSTiBzkZBe0IDLwLG75pM5Ej1XjXee8zrpLAmD21ET04fM4I4lSVGfIW
         Q+my3B99PjL/v3z/hKeBaEWBvESw9aih0ETnhmnxgmsV8yWAICVR863KOzNO3Q6s3zEa
         AsP7Etn7j7ODIbZAjvTfuEYqOUEIsm7vfo3jqniyHInAEsa8pv3nsw27xExEGpRa3Y9x
         MfXam53sX3lIDX0uGAnDaqX6iiaAP5givXlPKLnjV9hK/UcKtu3pnpVVebROttjRDlly
         xxuIg53CAha66tiu3ZOo2YqVicN5ea8F68oJW63P6K3AXhXD14C5DsdnTeOlMgWZtwiA
         bODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639559; x=1785244359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXH/AcaDYaWjD1D7W7UeWMormFqpNiZzAjn7k+W0SEQ=;
        b=IDTUT6Du56s1dHJodCzUP5s4AYQTV4Z5qgjlhKMS83x3QOIpiqvQJ9+qHBPdqQcMME
         Qj5SQ9dMTCbnlcr8mBHjkTlACr1Sa33vV71/tT9yiYHiMmUVV/aNKllQGeSzWKeZovy2
         S3zBZ+qLXR3zxbH57Hkykn9j93w8uWES5xG1CXhMPL07bASCYPht71VWpWpRnP9R6QUL
         L6JktHAmUVlLNjaGAOqD9+PQf3TsrGXyUyIz4xOfkmqz9I7Hkz2/3Byxn+cwiybp7V4Y
         TGIaIYaahDBDPX5NsK1oVouz8HOtYXCyR9vsM8nVIa9RRUbLuwDaSi6QRGRjEMSVsu5b
         mcVw==
X-Forwarded-Encrypted: i=1; AHgh+RqLdZunE5R8oaCu9uGy2AqghKHYYR3hCqljhfHf/KfZwH/FFCgON3QH3USMGSXY/2KiNSKhSNjGy2nw@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvfoRPW4V6j9PyfK1I9uZ9Foe9fETZ2W6eOyq447FZ2R8jy3u
	WEgUgAg0NC/SXUbab4NnwUU8VlQ1E9iat6CuTGHOYMWB0jHyh2/yajMy8SDqJ5kbhgE=
X-Gm-Gg: AR+sD13sDfZ5LnDlY94QFs8E9Ukaxd/7Z4Puz27ewbZP9FIfQ9B0vPgFuzxrH4uiCo5
	OHJoTueFR6Fzrz4RI2wHN9bGJYtw/9y3IAldZ9wj+UHX6QSneilEcLY7+Ms6q1SiiHdawdFK5S3
	Ln/+LkgzGgMrZXctX8mBIth4u6QUDfZD4bNeSXP/AaE6xgrHrglKKiAEwFLzwzoWJIHxDEnzA42
	qioAvEaKAjxIyRhyFF56cU5BG4rN5HjhnouJm/jBAn4frCTxgLZ/LCEdejJFBu0iTicRlZHl0gS
	oWuqidaSYX7rprGht2fNLN1eMcwXaa9OZFOAS6SFK5hVIzuBcI3YiiKwoNPA/K/Jj66nV6r0wgf
	fdyzo8FVKP3kdwmfX5ZzxrSlw1sOqm4tZ6DkJGfoLGQStse4cHQHiWfGu9EvxHnunl0jWIY3pPQ
	==
X-Received: by 2002:a05:6000:2084:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-47f6230e614mr22543209f8f.16.1784639559042;
        Tue, 21 Jul 2026 06:12:39 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:38 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/3] Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:24 +0200
Message-ID: <20260721131207.803760-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.

Finally, clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. The linux/module.h header is
included by every *.mod.c file to provide `struct module` and other related
definitions, so it should avoid pulling in unnecessary dependencies. Note
that this series doesn't immediately improve the situation, since most of
the files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Apologies for the wide distribution. Acked-bys are appreciated.

Changes in v2:
- Remove the linux/kmod.h include from kernel/cgroup/cgroup-v1.c.
- Add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
- Link to v1: https://lore.kernel.org/linux-modules/20260708154510.6794-1-petr.pavlu@suse.com/

Petr Pavlu (3):
  umh, treewide: Explicitly include linux/umh.h where needed
  time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
  module: Bring includes in linux/kmod.h up to date

 arch/x86/kernel/cpu/mce/dev-mcelog.c |  2 +-
 drivers/block/drbd/drbd_nl.c         |  1 +
 drivers/greybus/svc_watchdog.c       |  1 +
 drivers/macintosh/windfarm_core.c    |  1 +
 drivers/pnp/pnpbios/core.c           |  2 +-
 drivers/video/fbdev/uvesafb.c        |  1 +
 fs/coredump.c                        |  2 +-
 fs/nfs/cache_lib.c                   |  2 +-
 fs/nfsd/nfs4layouts.c                |  2 +-
 fs/nfsd/nfs4recover.c                |  1 +
 fs/ocfs2/stackglue.c                 |  1 +
 include/linux/kmod.h                 | 12 ++----------
 kernel/cgroup/cgroup-v1.c            |  2 +-
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/time/jiffies.c                |  1 +
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 22 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.54.0

