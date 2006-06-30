From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 0/10] drivers/acpi/asus_acpi.c updates [RESEND]
Date: Sat, 1 Jul 2006 00:59:05 +0200
Message-ID: <20060630225905.GB31642@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:29971 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1750891AbWF3W7J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 18:59:09 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi,

The following batch of patches update the asus_acpi driver to version 0=
=2E30
through the following changes:

Readd WLED for S1N
Rework model detection for more flexibility and less oopses
Resolve confusion, "bluetooth" entry controls both the internal adapter
  *and* its LED
Added support for L5D
Added support for W5A (patch from Fernando A. P. Gomes)
Added support for A4759GUH (A4G, patch from Giuseppe Rota)
Added support for W3400N
Added support for W1N LED display (thx =C9ric BURGHARD)
Added support for A3000G
=46ix M6R/M6N mismerge

Please apply.
Best regards,

--=20
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
