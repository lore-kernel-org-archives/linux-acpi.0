From: Dave Jones <davej@redhat.com>
Subject: 2.6.16rc5 acpi slab corruption
Date: Wed, 1 Mar 2006 15:32:08 -0500
Message-ID: <20060301203208.GA21722@redhat.com>
References: <200603012014.k21KE9FI010352@dhcp150.install.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:167 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751177AbWCAUcK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 15:32:10 -0500
Content-Disposition: inline
In-Reply-To: <200603012014.k21KE9FI010352@dhcp150.install.boston.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>

With the latest git, on a testbox here, we're seeing this..

  slab size-512: redzone mismatch in slab f7d74040, obj f7d74078, bufct=
l 0xfffffffe
  Redzone: 0x170fc2a5/0x170fc200.
  Last user: [<c0205e51>](acpi_ut_allocate+0x28/0x45)
  000: 53 53 44 54 fa 01 00 00 01 f9 50 6d 52 65 66 00
  010: 43 70 75 30 49 73 74 00 00 30 00 00 49 4e 54 4c

over and over just after booting.
Translating that to ascii, it looks like..

SSDT =EF=BF=BDPmRef
Cpu0Ist0INTL


(Does no-one else run with slab-poisoning any more?
 Sometimes I feel I'm the only person who sees these.)

		Dave


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
