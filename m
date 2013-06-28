From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] ACPI / dock: Notification rework and memory leak fix
Date: Sat, 29 Jun 2013 00:47:30 +0200
Message-ID: <1515394.L46AJCfCTt@vostro.rjw.lan>
References: <1640211.P0jyS5muX2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1640211.P0jyS5muX2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

More fixes/cleanups for the ACPI dock driver (and related), on top of the
series I sent earlier today.  [Well, that code is like the Rabbit hole in
"Alice's Adventures in Wonderland".]

[1/3] Rework the dock driver's handling of notifications (the changelog tells
      the whole story).

[2/3] After [1/3] there are no more users of the ACPI bus notifier call chain,
      so drop it.

[3/3] dock_add() leaks memory on errors (although only theoretically, because
      it is very unlikely to fail), so fix that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
