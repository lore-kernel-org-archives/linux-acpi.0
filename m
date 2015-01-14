From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH] Fix checkpatch warning in drivers/acpi/nvs.c
Date: Wed, 14 Jan 2015 11:18:52 +0100
Message-ID: <1421230733-24149-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

attached a simple patch fixing a checkpatch warning about
printk(KERN_INFO vs pr_info.

Moritz Fischer (1):
  acpi: nvs: Fixed checkpatch.pl warning.

 drivers/acpi/nvs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.3
