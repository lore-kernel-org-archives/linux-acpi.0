From: Florian Echtler <floe@butterbrot.org>
Subject: Looking for some pointers on WMI/EC access
Date: Sat, 17 Apr 2010 17:37:33 +0200
Message-ID: <1271518653.4549.186.camel@flunder>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:33551
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0DQPse (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Apr 2010 11:48:34 -0400
Received: from [192.168.178.27] (unknown [93.104.92.96])
	(using SSLv3 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTPSA id 0E4EA15407A
	for <linux-acpi@vger.kernel.org>; Sat, 17 Apr 2010 17:39:14 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello everyone,

I've just bought an Ideapad S10-3t, and most features including ACPI
work fine. However, since neither thinkpad-acpi nor lenovo-sl-laptop
support this device, I've been looking around for some hints on how to
access the embedded controller in order to get the hotkeys working. I'l=
l
post what I've found so far and hope that somebody could give me some
hints as to how to proceed.

=46irst, I've dumped the DSDT and browsed through it. I've found a _WDT
section, and wmidump shows:

ABBC0F20-8EA1-11D1-00A0-C90629100000:
	object_id: =EF=BF=BD
	notify_id: 80
	reserved: 00
	instance_count: 1
	flags: 0x8 ACPI_WMI_EVENT=20
ABBC0F40-8EA1-11D1-00A0-C90629100000:
	object_id: IO
	notify_id: 49
	reserved: 4F
	instance_count: 1
	flags: 0x1 ACPI_WMI_EXPENSIVE=20
05901221-D566-11D1-B2F0-00A0C9062910:
	object_id: AE
	notify_id: 41
	reserved: 45
	instance_count: 1
	flags: 0

As this laptop also runs some kind of Splashtop instant-on Linux called
Lenovo Quickstart, I've decided to extract the initrd from its kernel
(*) and browse through the modules. Interestingly, I've found a
lenovo_ec.ko: strings shows that it accesses some DSDT elements which
are present on the S10-3t. Would it make sense to disassemble this?

Yours, Florian

(*) The Splashtop kernel is obfuscated in the most stupid way
imaginable: XOR "encryption" with 'QWER' as key. Need I say more?


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
