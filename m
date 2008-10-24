From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: ACPI warning in 2.6.28-rc1
Date: Sat, 25 Oct 2008 00:09:12 +0200
Message-ID: <b637ec0b0810241509j43a6bfc9q506dc16a612e7f06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37534 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbYJXWJN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Oct 2008 18:09:13 -0400
Received: by gxk9 with SMTP id 9so291849gxk.13
        for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2008 15:09:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Hi all.
As the subject says:

ACPI Warning (nspredef-0858): \_SB_.PCI0.LPCB.EC0_.BAT0._BIF: Return
Package type mismatch at index 11 - found Buffer, expected String
[20080926]

No functional problems so far.
