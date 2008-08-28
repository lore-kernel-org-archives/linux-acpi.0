From: Thomas Renninger <trenn@suse.de>
Subject: Re: [ANNOUNCE] ACPI BIOS Guideline for Linux
Date: Thu, 28 Aug 2008 11:41:28 +0200
Message-ID: <200808281141.30178.trenn@suse.de>
References: <200807241732.23412.trenn@suse.de> <200808272129.16131.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754009AbYH1Jlp@vger.kernel.org>
In-Reply-To: <200808272129.16131.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 27 August 2008 22:29:15 Carlos Corbacho wrote:
> On Thursday 24 July 2008 16:32:22 Thomas Renninger wrote:
> > \section{WMI - Windows Management Instrumentation}
> >
> > WMI is a Microsoft specific service. A small part of it
> > describes possible ACPI WMI implementations provided by the BIOS.
> > This is not part of the official ACPI specification and BIOS developers
> > should avoid using it. The Linux kernel driver supports basic WMI ACPI
> > functionality (since 2.6.25), but it is marked experimental.
> > ACPI functionality should not depend on the WMI interface.
>
> Perhaps it would be more useful to suggest to vendors/ BIOS writers what
> they should use here instead?

They can use their own devices.
There is a section about if you provide your own device, document it, etc.:

2 Vendor specific ACPI implementations
...
2. If new devices or functions are introduced, document how to use them. A
   short specification or a request for comments (RFC) can form the basis of
   a new standard which follows your needs.


But yes, it could be pointed out clearer.
I'll look closer at it when I touch it the next time.
Text snippets/suggestions are also appreciated.

Thanks,

     Thomas
