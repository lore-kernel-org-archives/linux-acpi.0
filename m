From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BKPATCH] LAPIC fix for 2.6
Date: Sun, 10 Oct 2004 10:45:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
References: <1097429707.30734.21.camel@d845pe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268397AbUJJRpk@vger.kernel.org>
In-Reply-To: <1097429707.30734.21.camel@d845pe>
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org



On Sun, 10 Oct 2004, Len Brown wrote:
>
> Hi Linus, please do a 
> 
> 	bk pull bk://linux-acpi.bkbits.net/26-latest-release

Ok, this version of the patch suddenly looks like a real bug-fix in that
it now makes the command line options "lapic"/"nolapic" a lot more
logical.

Pulled.

		Linus
