From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Board hangs without acpi=off
Date: Tue, 26 Mar 2013 23:47:20 +0100
Message-ID: <2284691.bnhzHFpqfq@vostro.rjw.lan>
References: <CAM3Q4oGq+nLYPR68NnA_mTTLvrmRzxWNbRpQ_zjq6VO5_hUp-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43775 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3CZWjz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 18:39:55 -0400
In-Reply-To: <CAM3Q4oGq+nLYPR68NnA_mTTLvrmRzxWNbRpQ_zjq6VO5_hUp-Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: olivier@diotte.ca
Cc: linux-acpi@vger.kernel.org

On Tuesday, March 26, 2013 11:09:55 AM Olivier Diotte wrote:
> Hi,
> 
> I have a development board here that hangs when trying to boot linux
> (actually Ubuntu Precise Pangolin's kernel 3.5.7.6).
> Supplying the kernel parameter 'acpi=off' allows the board to boot
> correctly. The problem is that we need this board to boot with a
> working ACPI stack.
> 
> I recompiled Ubuntu's kernel adding support for ACPI debugging
> (CONFIG_PM_DEBUG=y, CONFIG_ACPI_DEBUG=y) and did some tests with
> 'acpi.debug_layer' and 'acpi.debug_level' and can provide these if
> needed, though I am unsure if this is the right approach.
> 
> Is there something I can do to get this board's ACPI working? Any hint
> and/or approach would be a good step forward.

Can you get any debug output from boot attempts without acpi=off?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
