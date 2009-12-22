From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI and driver patches for 2.6.33.merge
Date: Mon, 21 Dec 2009 21:10:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912212107560.5520@localhost.localdomain>
References: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain>
 <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_PYxWQyax0Sf0nnooOgrVKQ)"
Return-path: <linux-pci-owner@vger.kernel.org>
In-reply-to: <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>, "Barnes, Jesse" <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_PYxWQyax0Sf0nnooOgrVKQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

> > Shaohua Li (3):
> >      ACPI: Add a generic API for _OSC -v2
> >      ACPI: cleanup pci_root _OSC code.
> >      ACPI: Add platform-wide _OSC support.
> 
> it seems these three patches broke the _OSC on my intel new systems.
> 
> revert them fix the problem with AER and pciehp and etc

Yinghai,
does 3563ff964fdc36358cef0330936fdac28e65142a work or fail on your 
system?  That is (ACPI: Add platform-wide _OSC support)
on top of 2.6.32 with no other changes.

thanks,
-Len

--Boundary_(ID_PYxWQyax0Sf0nnooOgrVKQ)--
