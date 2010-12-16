From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/9] PCI: revert to allocating bottom-up, avoid E820 areas
Date: Thu, 16 Dec 2010 13:59:33 -0800
Message-ID: <AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com>
References: <20101216173614.8185.19462.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53696 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819Ab0LPWBA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Dec 2010 17:01:00 -0500
In-Reply-To: <20101216173614.8185.19462.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>

On Thu, Dec 16, 2010 at 9:38 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> w=
rote:
>
> So I think the best band-aid for now is to revert to bottom-up alloca=
tion
> and do a better job of avoiding E820 reserved areas. =A0Obviously, it=
's not
> complete because we could still trip over ACPI devices (as in 23802),=
 but
> that's a problem we've always had and it's not as likely if we go bot=
tom-up.

Ok, ack for this series. Have we got testers for it? In particular,
have the people who have seen regressions been notified of this new
series?

That said, let's just try to merge it quickly so that we get maximal
coverage before the holiday season starts. Jesse, it makes sense
through your tree, but if you'd rather me take it directly, I can do
that.

                        Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
