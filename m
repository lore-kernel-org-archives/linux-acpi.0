From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.27: "array subscript is above array bounds" warnings
Date: Fri, 17 Oct 2008 23:50:46 -0700
Message-ID: <20081017235046.f3c6c86e.akpm@linux-foundation.org>
References: <48F4FE60.4060102@tfh-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60636 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972AbYJRGuy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Oct 2008 02:50:54 -0400
In-Reply-To: <48F4FE60.4060102@tfh-berlin.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Bock <bock@tfh-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xfs-masters@oss.sgi.com, linux-usb@vger.kernel.org

(cc's added)

On Tue, 14 Oct 2008 22:17:36 +0200 Oliver Bock <bock@tfh-berlin.de> wrote:

> Hi all,
> 
> FYI, I just came across the following warnings when compiling 2.6.27 
> (release) using gcc 4.3.2 (Debian 4.3.2-1) on Debian Lenny (i386):
> 
> ----------
> drivers/acpi/tables/tbfadt.c: In function ___acpi_tb_create_local_fadt___:
> include/asm/string_32.h:75: warning: array subscript is above array bounds
> 
> drivers/usb/core/hcd.c: In function ___usb_hcd_poll_rh_status___:
> include/asm/string_32.h:75: warning: array subscript is above array bounds
> 
> fs/xfs/xfs_mount.c: In function ___xfs_mod_sb___:
> fs/xfs/xfs_mount.c:1456: warning: array subscript is above array bounds
> ----------

