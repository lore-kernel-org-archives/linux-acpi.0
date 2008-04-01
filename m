From: Daniel Alonso <dalonso@apanoia.net>
Subject: Great improvement in laptop with different acpi boot options
Date: Wed, 02 Apr 2008 01:18:05 +0200
Message-ID: <47F2C2AD.2020802@apanoia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp103.biz.mail.re2.yahoo.com ([68.142.229.217]:25531 "HELO
	smtp103.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754947AbYDAXYt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 19:24:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

As requested I'm sending this mail to notify that the behavior of my
laptop  (Sony VAIO VGN-FZ21S) improves when I add the following to
options to my  kernel:

acpi_apic_instance=2
acpi_osi=Linux

Before this change:

1) The fans were always running full speed
2) The temperature measures were higher
3) In my core cpu, it seemed that both cpus were not independent of each
other, but always with same load.

Now all these erratic behaviors have been fixed.

Best regards.
