From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RESEND] [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Thu, 31 Jul 2008 12:45:11 +0200
Message-ID: <20080731104510.GI488@elte.hu>
References: <20080715194714.1437.92354.57492@attica.americas.sgi.com> <200807291934.m6TJYGai478010@fcbayern.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:45251 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbYGaKqT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 06:46:19 -0400
Content-Disposition: inline
In-Reply-To: <200807291934.m6TJYGai478010@fcbayern.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* John Keller <jpk@sgi.com> wrote:

> Just checking on the status of this patch.
> If there are no issues, please apply.

> SGI UV will have MMCFG base addresses that are greater than 4GB (32 bits).

applied to tip/x86/uv, thanks John.

	Ingo
