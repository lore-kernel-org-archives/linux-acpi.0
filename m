From: Ed Swierk <eswierk@aristanetworks.com>
Subject: Re: [RFC] [PATCH] PCI mmconfig without ACPI
Date: Tue, 5 May 2009 13:09:30 -0700
Message-ID: <9ae48b020905051309h14cf1d7au175e19c66137555@mail.gmail.com>
References: <1233766786.16414.26.camel@localhost.localdomain>
	 <20090204181738.GA16174@elte.hu>
	 <1234812741.28801.4.camel@localhost.localdomain>
	 <20090505105744.4268e341@hobbes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:5373 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbZEEUJa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2009 16:09:30 -0400
In-Reply-To: <20090505105744.4268e341@hobbes>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

On Tue, May 5, 2009 at 10:57 AM, Jesse Barnes <jbarnes@virtuousgeek.org=
> wrote:
> I'm still a bit dubious about this; does it solve a real issue? =A0Or
> just remove the ACPI dependency for its own sake?

Our products run Linux with a non-ACPI BIOS (Coreboot), so this is not
just a theoretical issue.

--Ed
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
