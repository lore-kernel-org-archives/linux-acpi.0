From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps management
Date: Fri, 21 Jan 2011 00:06:55 +0800
Message-ID: <AANLkTikVRHfu2KhH4yi2VerkRXBdCODedCDORmpEzRXO@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62794 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab1ATQL3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jan 2011 11:11:29 -0500
In-Reply-To: <201101201226.41021.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu, Jan 20, 2011 at 7:26 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> [10/11] - Make the NVS code use existing iomaps if possible.

Seems ok.

> [11/11] - (cleanup) Remove an unnecessary field from struct nvs_page.

This seems to have an issue. Notebook tries to suspend ... then resume
immediately.

> The patches have been tested on HP nx6325, Toshiba Portege R500 and A=
cer
> Ferrari One without causing any visible problems to happen. =A0Also J=
eff has
> tested [1/11] and [2/11] and he reports that they fix the synchronize=
_rcu()
> problem for him. =A0[Jeff, can you test the whole series, please, and=
 see if
> it doesn't introduce any new issues, [10/11] in particular?]

So, everything seems ok except 11/11.


Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
