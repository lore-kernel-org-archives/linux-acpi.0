From: Karol Kozimor <sziwan@hell.org.pl>
Subject: [PATCH 0/9] drivers/acpi/asus_acpi.c updates
Date: Wed, 18 Jan 2006 22:21:11 +0100
Message-ID: <20060118212110.GA7199@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hell.org.pl ([62.233.239.4]:43792 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1030366AbWARVVT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 16:21:19 -0500
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
