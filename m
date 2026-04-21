Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E62773F0;
	Tue, 21 Apr 2026 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776804105; cv=none; b=qEm760BrYCOrU8PYUDrWKNrv3BoerbHjEZjgY1BbneLJI2c5gbSaaWXNieUz6DmTpFAVkUJtBrTXoa8rwNT1PJj0dhBig0VowBRdbdrh8exmJ8SSISAnxRmKKrZ+k3YB1y/ESgfGlsYTV7/fd0THE3TypE+CldCcMolJF3XpU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776804105; c=relaxed/simple;
	bh=h5Q6N+6L+lNIA19t2uhymE8LOReWMBHJNcZTTKeHwN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBFVw7TvRobMD6oxfcKNS01kFVDGuoPZYC6fE7GbFikfLh/cfOmBT7LKYCzdt2lMCwUofOlY88pmVcFlYVM7TWRv8pXRznaLnIa08z3bL9dOOzKuoqmKRVfd6y+i1FhhYpzl4G/tbR8C1p2QsA0mlBHgPopiJiatanmGqBwuz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZggkC7J1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZggkC7J1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39AEC2BCB0;
	Tue, 21 Apr 2026 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776804105;
	bh=h5Q6N+6L+lNIA19t2uhymE8LOReWMBHJNcZTTKeHwN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZggkC7J1d2rerYP/ojICrYCSo8IGkcVe3SKIKmxDovH+8vw2wKWbN+n+g59zYJctM
	 9I0shcO3RVCCLDh0LveB/bUjVgmg6OLb3/AegS6VWShK6+son81OkR4d2IXvDlKJm2
	 PspVwTQSCaiUUyYXzsfgdal8S6w5OS97Fu+qlKXt5vP3sO0i9M5RVkYL26ShflLHPi
	 U7tz3IPmjmHw2dIh/i8at+hurIPjV4wFIZm5y7gKo/8Uxcco7nc2aT1HLz4yKfukM1
	 ehydOnSbNQRhXh1UdwfYs3iVhbYPmZw4tBaUMJMfAhRKOpoEPYHxf2uA38qoOtHHec
	 wpmttfxFKKOIw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Evgeny Sagatov <sagatov@ya.ru>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: Pressing the power button causes the device to freeze completely
Date: Tue, 21 Apr 2026 22:41:41 +0200
Message-ID: <12879883.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <33307e6f-19f6-401c-bd49-725c56596678@intel.com>
References:
 <184091776095270@mail.yandex.ru>
 <33307e6f-19f6-401c-bd49-725c56596678@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday, April 21, 2026 5:11:36 PM CEST Wysocki, Rafael J wrote:
> Hi,
> 
> On 4/13/2026 6:46 PM, Evgeny Sagatov wrote:
> > Hello,
> > I have a PC with a motherboard GA-EP45T-UD3LR (Rev. 1.0) 
> > <https://www.gigabyte.com/Motherboard/GA-EP45T-UD3LR-rev-10> and 
> > processor Intel Core 2 Quad Q9550.
> > Previously, I had Debian 12 with kernel 6.1 installed, and pressing 
> > the power button would shut down the PC as usual.
> > I updated to Debian 13 with kernel 6.12.74, and now pressing the power 
> > button causes the PC to freeze completely.
> > I see that systemd doesn't even begin to shut down. It freezes 
> > immediately after pressing the button. There's no error message in 
> > console. There's no error message in the logs either. Netconsole 
> > doesn't report any errors, and the kernel doesn't panic. It just 
> > freezes completely.
> 
> It looks like the ACPI button notify handler crashes on your system for 
> some obscure reason.
> 
> It should be possible to get to the bottom of it, but it will require 
> some investigation if you have the motivation and time to run debug patches.
> 
> 
> > I checked that Live CD with Debian 12 continue to shut down normally, 
> > but Live CD with Debian 13 freeze.
> > I tried updating and resetting the BIOS. I tried various kernel 
> > parameters related to ACPI settings. I also tried kernels 6.18 and 
> > 6.19. Nothing fixed the problem.
> > If I unload the "button" module, the system doesn't freeze, but it 
> > also doesn't shut down.
> 
> This is a useful data point, thanks!
> 
> 
> > I built "button" module by rolling back its version to commit 1a20d40 
> > <https://github.com/torvalds/linux/commit/1a20d409c874255086e2f42a729826d490294c91>, 
> > which corresponds to kernel version 6.1. This module does not freeze, 
> > but does not turn off the PC either.
> > I've found that the freezes have been occurring since commit 0d51157 
> > <https://github.com/torvalds/linux/commit/0d51157dfaac05ea66616d8a250dce04bef49a4f>.
> 
> The main difference made by it is the fixed events handling and if there 
> is a problem with that, a few debug patches should suffice to find out 
> what's going on.  I'll send you one to try shortly.

First off, on top of 7.0.0 (since the issue is present in this one, I think
it's better to focus the debugging on it), let's first check what happens if
the ACPI fixed event handler is not installed for the power button at all.

This should be similar to using a 6.1 version of the button driver (that is,
no crash, but pressing the power button will have no effect).

Please test the patch below and let me know what happens.

---
 drivers/acpi/button.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -628,9 +628,7 @@ static int acpi_button_probe(struct plat
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
-		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-							  acpi_button_event,
-							  button);
+		status = AE_OK;
 		break;
 	case ACPI_BUS_TYPE_SLEEP_BUTTON:
 		status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,



