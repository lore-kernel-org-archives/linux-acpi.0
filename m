From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI: Invalid active2 threshold
Date: Thu, 04 Sep 2014 21:21:10 +0200
Message-ID: <2013965.03uY2hDTmQ@vostro.rjw.lan>
References: <201409041840.04182.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53216 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754672AbaIDTBv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 15:01:51 -0400
In-Reply-To: <201409041840.04182.a.miskiewicz@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Thursday, September 04, 2014 06:40:04 PM Arkadiusz Miskiewicz wrote:
> 
> Hi.
> 
> I'm using 3.17.0-rc3-00002-g7505cea kernel on Dell XPS 15 machine:
> DMI: Dell Inc. XPS 15 9530/XPS 15 9530, BIOS A06 07/16/2014
> (this is latest bios)
> 
> After loading thermal acpi driver I get:
> 
> [54136.633643] ACPI: Invalid active2 threshold
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [54136.633761] thermal LNXTHERM:00: registered as thermal_zone6
> [54136.633763] ACPI: Thermal Zone [TZ00] (28 C)
> [54136.634009] thermal LNXTHERM:01: registered as thermal_zone7
> [54136.634011] ACPI: Thermal Zone [TZ01] (-266 C)
> 
> 
> I assume bios is buggy (right?)

Well, we don't seem to like the value for some reason.  Also the -266 C for TZ01
looks suspicious.

> What problems can happen to this machine due to this problem? It is quite hot 
> frequently, so I wonder if there is some thermal management problem with it.

I'm leaving this question to Rui.

Rafael

