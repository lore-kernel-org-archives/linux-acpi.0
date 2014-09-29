From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1 linux-next] ACPI / SBS: fix sparse warning
Date: Tue, 30 Sep 2014 01:49:55 +0200
Message-ID: <2310110.VDaAnN6nFV@vostro.rjw.lan>
References: <1411929887-2440-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53558 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751028AbaI2X37 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Sep 2014 19:29:59 -0400
In-Reply-To: <1411929887-2440-1-git-send-email-fabf@skynet.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sunday, September 28, 2014 08:44:47 PM Fabian Frederick wrote:
> Adding parentheses around expression to avoid:
> drivers/acpi/sbs.c:444:28: warning: dubious: !x & y
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

I was faster: https://patchwork.kernel.org/patch/4990671/


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
