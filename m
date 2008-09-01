From: Steven King <sfking@fdwdc.com>
Subject: Re: 2.6.26.[1-3] + x61 tablet + x6ultrabase: no resume =?utf-8?q?after=09undocking?=
Date: Mon, 1 Sep 2008 12:05:04 -0700
Message-ID: <200809011205.05253.sfking@fdwdc.com>
References: <200808301535.22419.sfking@fdwdc.com> <20080901112816.GA21970@khazad-dum.debian.net> <48BBDD2C.5020804@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp100.biz.mail.mud.yahoo.com ([68.142.201.176]:26785 "HELO
	smtp100.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751360AbYIATFK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 15:05:10 -0400
In-Reply-To: <48BBDD2C.5020804@dbservice.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Monday 01 September 2008 5:16:44 Tomas Carnecky wrote:

> I just tested suspend/resume with the CDROM drive removed (an empty
> bay). Suspend/resume now works just fine, regardless how I dock/undock
> the laptop.

I'm seeing the exact same things as Tom.  Also, in my dmesg I see:

ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: found ejectable bay
ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: Adding notify handler
ACPI: Error installing bay notify handler

is this significant?


-- 
Steven King -- sfking at fdwdc dot com
