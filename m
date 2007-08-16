From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: scripts/mod/file2alias.c cross compile problem
Date: Thu, 16 Aug 2007 09:26:42 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A022DBC43@scsmsx411.amr.corp.intel.com>
References: <617E1C2C70743745A92448908E030B2A0211AFF0@scsmsx411.amr.corp.intel.com> <1186092501.6131.154.camel@localhost.localdomain> <1187274435.8780.780.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41824 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933779AbXHPQ0o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Aug 2007 12:26:44 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1187274435.8780.780.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, Rusty Russell <rusty@rustcorp.com.au>
Cc: Adrian Bunk <bunk@stusta.de>, Sam Ravnborg <sam@ravnborg.org>, Jan Dittmer <jdi@l4x.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org

> -#define ACPI_ID_LEN	9
> +#define ACPI_ID_LEN	16 /* only 9 bytes needed here, 16 bytes are used */

What will happen if someone uses more than 9 bytes?  With the old
limit there would be a compile time error it someone initialized
with:

	{"PNP0C0ABCDEFGH", 0},

But if we change ACPI_ID_LEN the error will move to run-time.

-Tony
