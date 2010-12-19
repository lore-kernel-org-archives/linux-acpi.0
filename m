From: David John <davidjon@xenontk.org>
Subject: Re: [PATCH 0/9] PCI: revert to allocating bottom-up, avoid E820 areas
Date: Sun, 19 Dec 2010 20:01:03 +0530
Message-ID: <4D0E1727.3040307@xenontk.org>
References: <20101216173614.8185.19462.stgit@bob.kio> <AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com> <201012170900.56415.bjorn.helgaas@hp.com>
Reply-To: davidjon@xenontk.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201012170900.56415.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

On 12/17/2010 09:30 PM, Bjorn Helgaas wrote:
>     https://bugzilla.kernel.org/show_bug.cgi?id=23132 (Dell 1545)

I can confirm that the latest PCI pull fixes this bug.

Regards,
David.
