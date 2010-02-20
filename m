From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI thermal: Don't invalidate thermal zone if critical trip point is bad
Date: Sat, 20 Feb 2010 11:42:43 +0100
Message-ID: <201002201142.43801.trenn@suse.de>
References: <alpine.LFD.2.00.1002190234100.24628@localhost.localdomain> <1266661241-12344-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43894 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254Ab0BTKlt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Feb 2010 05:41:49 -0500
In-Reply-To: <1266661241-12344-1-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

On Saturday 20 February 2010 11:20:41 am Thomas Renninger wrote:

> +			printk(KERN_WARNING FW_BUG "Invalid critical threshold "
> +			       "(_CRT:%)\n", tmp);
Argh, I forgot to refresh, resending in a minute.

Sorry about that,

      Thomas
