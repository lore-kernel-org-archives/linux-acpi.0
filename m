From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RESEND][PATCH -tip] x86: acpi: move acpi_mcfg_64bit_base_addr
	into CONFIG_PCI_MMCONFIG
Date: Wed, 27 Aug 2008 08:25:22 +0200
Message-ID: <20080827062522.GB6255@elte.hu>
References: <48B48019.6080803@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58926 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbYH0GZi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 02:25:38 -0400
Content-Disposition: inline
In-Reply-To: <48B48019.6080803@ct.jp.nec.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, John Keller <jpk@sgi.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


* Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com> wrote:

> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> acpi_mcfg_64bit_base_addr is used when CONFIG_PCI_MMCONFIG is enabled.

applied to tip/x86/cleanups, thanks!

	Ingo
