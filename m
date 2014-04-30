From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Revert "ACPI / Battery: Remove battery's proc directory" and "ACPI: Remove CONFIG_ACPI_PROCFS_POWER and cm_sbsc.c"
Date: Wed, 30 Apr 2014 23:58:58 +0200
Message-ID: <3471256.NMmqNu6jmx@vostro.rjw.lan>
References: <1398872369-2755-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398872369-2755-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, pavel@ucw.cz, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 30, 2014 11:39:29 PM Lan Tianyu wrote:
> The commit 1e2d9cd and 7d7ee95 remove ACPI Proc Battery
> directory and breaks some old userspace tools. This patch
> is to revert them.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Please split that into two patches so that each commit being reverted has
its own revert patch.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
