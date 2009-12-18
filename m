From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [git pull request] ACPI and driver patches for 2.6.33.merge
Date: Thu, 17 Dec 2009 17:28:50 -0800
Message-ID: <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
References: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40935 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZLRB2y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2009 20:28:54 -0500
In-Reply-To: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>, "Barnes, Jesse" <jesse.barnes@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org

On Wed, Dec 16, 2009 at 12:06 PM, Len Brown <lenb@kernel.org> wrote:
> Hi Linus,
>
> please pull from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git=
 release
>
;..
>
> Shaohua Li (3):
> =A0 =A0 =A0ACPI: Add a generic API for _OSC -v2
> =A0 =A0 =A0ACPI: cleanup pci_root _OSC code.
> =A0 =A0 =A0ACPI: Add platform-wide _OSC support.

it seems these three patches broke the _OSC on my intel new systems.

revert them fix the problem with AER and pciehp and etc

YH
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
