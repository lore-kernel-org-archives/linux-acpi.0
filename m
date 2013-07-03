From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] ACPI / dock: One fix and more cleanups
Date: Thu, 04 Jul 2013 01:23:51 +0200
Message-ID: <2759309.GsYqNLU1ac@vostro.rjw.lan>
References: <1640211.P0jyS5muX2@vostro.rjw.lan> <1515394.L46AJCfCTt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515394.L46AJCfCTt@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

As I said before, the ACPI dock driver seems to be in an endless need for
cleanups and fixes.  This time I found one oddity (patch [1/4]) a couple of
nitpicks ([2/4] and [4/4]) and a notifier chain that can be dropped (unless
I'm overlooking a reason why those things have to be done atomically - [3/4]).

[1/4] Actually define acpi_dock_init() as void (-stable material).
[2/4] Do not check if ACPI dock is a module (it can't be).
[3/4] Drop ACPI dock notifier chain (and modify acpiphp to use something
      different for fixups).
[4/4] Drop unnecessary local variable from dock_add().

All on top of the bleeding-edge branch of the linux-pm.git tree.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
