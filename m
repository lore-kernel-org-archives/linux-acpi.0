From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset
 in acpi_read/write
Date: Tue, 15 Nov 2011 08:13:15 -0700
Message-ID: <CAErSpo7SJNM73ei5aN=9UCsvgU6OZoupWUoUP3Hts3GGfwE37A@mail.gmail.com>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com> <20111111230513.20897.36014.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44145 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab1KOPNg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2011 10:13:36 -0500
Received: by yenq3 with SMTP id q3so708079yen.19
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2011 07:13:36 -0800 (PST)
In-Reply-To: <20111111230513.20897.36014.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Huang Ying <ying.huang@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Thomas Renninger <trenn@suse.de>

On Fri, Nov 11, 2011 at 4:05 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> acpi_read(), acpi_write(), acpi_hw_read(), and acpi_hw_write() curren=
tly
> ignore the GAS bit_offset field (but they do warn if it is non-zero).
>
> APEI tables are starting to use non-zero bit_offsets. =A0APEI uses
> special-purpose apei_exec_read_register() and apei_exec_write_registe=
r()
> interfaces that apply the bit_offset.
>
> This patch adds bit_offset support to the generic interfaces, which i=
s
> one small step toward using them instead of the special-purpose APEI =
ones.

Eww, brown paper bag time.  Just pretend you never saw this lame
implementation attempt.

I do think we need to make acpi_read() smart enough to extract a bit
field, but this try doesn't work.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
