From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI: EC: GPE storm detected, disabling EC GPE
Date: Tue, 10 Jun 2008 11:30:24 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806101128390.14381@localhost.localdomain>
References: <dd18b0c30806062321x2918f6feq7c817bde52ba0c4c@mail.gmail.com>
 <20080606235526.783acc83.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755837AbYFJPe7@vger.kernel.org>
In-reply-to: <20080606235526.783acc83.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Justin Mattock <justinmattock@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org



> Could someone from acpi land please help here?

Alexey maintains the EC, and he's supplied 3 patches to test
in the bug report.  The 3rd is awaiting word from Justin.

cheers,
-Len

> Justin, has this machine always had this problem or is it something
> which earlier kernels handled correctly?

note that the EC storm detection is new -- so the failure may
have simply been different in older kernels -- such as a huge
number of ACPI interrupts.

cheers,
-len
