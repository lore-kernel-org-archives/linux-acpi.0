From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: REGRESSION: 3.10-rc1: Dell Latitude e6410 hangs within 3 seconds
Date: Tue, 14 May 2013 22:34:30 +0200
Message-ID: <1396357.SFbZsj3Bmy@vostro.rjw.lan>
References: <5192363E.7040204@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46855 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756895Ab3ENUZ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 May 2013 16:25:57 -0400
In-Reply-To: <5192363E.7040204@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday, May 14, 2013 03:03:58 PM Arend van Spriel wrote:
> Laptop hangs pretty soon after booting. Workaround for me was to turn 
> off ACPI on kernel command line, ie. acpi=off
> 
> Attached is my kernel configuration.

Well, I have no idea what may be the source of this.

Any chance to bisect?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
