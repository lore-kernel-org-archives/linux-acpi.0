From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Sun, 4 Oct 2009 22:46:23 +0200
Message-ID: <200910042246.23712.rjw@sisk.pl>
References: <1254669853.26496.0.camel@carter> <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com> <4AC8F02B.6080209@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758016AbZJDUpt@vger.kernel.org>
In-Reply-To: <4AC8F02B.6080209@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 04 October 2009, Alexey Starikovskiy wrote:
> Hi Miguel,

Hi Alex,

> I am going to reject your patch on the basis, that the battery driver should report only
> information it gained from battery hardware, not interpret it in any way.
> As your patch fall into "interpret" category, it does not belong in the kernel and battery
> driver in particular. You may suggest it to any/all user space battery monitoring applications,
> this is the place for "interpretations".

Well, we do quirks for PCI devices, suspend quirks etc. in the kernel, so I'm
not really sure we should use the "no interpretation" as a general rule.  IMO,
if there's a known broken system needing a quirk, it may just be more
reasonable to put the quirk into the kernel than to put it into every single
user application out there.

In this particular case we have an evidently quirky hardware (or BIOS) and it's
not a fundamentally wrong idea to try to address that problem in the kernel.

Thanks,
Rafael
