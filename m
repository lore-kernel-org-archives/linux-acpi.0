From: Len Brown <lenb@kernel.org>
Subject: Re: MacBookPro2,2 unable too boot with the latest HEAD
Date: Tue, 20 Apr 2010 10:17:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004201011050.2402@sony>
References: <i2vdd18b0c31004140812i6a0e9430u68ab49b24273fe9b@mail.gmail.com> <20100419142804.3cd53666.akpm@linux-foundation.org> <4BCCCCDF.4010605@gmail.com> <20100419145741.95688467.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100419145741.95688467.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org


> > the patch here fixes it for me:ACPI: EC: Limit burst to 64 bit
> > https://bugzilla.kernel.org/attachment.cgi?id=25962
> 
> hm.  I wonder how you go from a bugzilla attachment back up tot he bug
> to which it is attached?

Use "A comment contains this string" in bugzilla's advanced search
and plug in "attachment.cgi?id=25962" for this case.

you'll find the patch in this comment:
https://bugzilla.kernel.org/show_bug.cgi?id=15749#c7

It is a bit more user friendly to supply the
URL of the commment containing the patch rather than
the direct URL of the attachment itself.

> Oh well.  Alexey, I trust that patch is in the 2.6.34 queue?

it shipped in 2.6.34-rc5 in commit 
2060c44576c79086ff24718878d7edaa7384a985

thanks,
Len Brown, Intel Open Source Technology Center
