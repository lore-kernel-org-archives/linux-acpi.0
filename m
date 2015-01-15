From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Fix checkpatch warning in drivers/acpi/nvs.c
Date: Thu, 15 Jan 2015 09:53:34 +0100
Message-ID: <8169130.dsGWuzSOJ3@vostro.rjw.lan>
References: <1421230733-24149-1-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62312 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751045AbbAOIbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2015 03:31:09 -0500
In-Reply-To: <1421230733-24149-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, January 14, 2015 11:18:52 AM Moritz Fischer wrote:
> Hi,
> 
> attached a simple patch fixing a checkpatch warning about
> printk(KERN_INFO vs pr_info.

Which is not going to be applied unless it fixes a functional problem.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
