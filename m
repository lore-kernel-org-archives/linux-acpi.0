From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/9] PCI: revert to allocating bottom-up, avoid E820 areas
Date: Fri, 17 Dec 2010 09:00:55 -0700
Message-ID: <201012170900.56415.bjorn.helgaas@hp.com>
References: <20101216173614.8185.19462.stgit@bob.kio> <AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 16, 2010 02:59:33 pm Linus Torvalds wrote:
> On Thu, Dec 16, 2010 at 9:38 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> >
> > So I think the best band-aid for now is to revert to bottom-up allocation
> > and do a better job of avoiding E820 reserved areas.  Obviously, it's not
> > complete because we could still trip over ACPI devices (as in 23802), but
> > that's a problem we've always had and it's not as likely if we go bottom-up.
> 
> Ok, ack for this series. Have we got testers for it? In particular,
> have the people who have seen regressions been notified of this new
> series?

I put the patches in these bugzillas:

    https://bugzilla.kernel.org/show_bug.cgi?id=16228 (Dell T3500)
    https://bugzilla.kernel.org/show_bug.cgi?id=23132 (Dell 1545)
    https://bugzilla.kernel.org/show_bug.cgi?id=23542 (HP 2530p)
    https://bugzilla.kernel.org/show_bug.cgi?id=23802 (PCI / TPM conflict)

Bernard Wiedemann reported success for 16228 on a Dell T3500.  No
news yet on the others.

For this one:

    https://bugzilla.kernel.org/show_bug.cgi?id=23332 (HP nx6325)

I have an nx6325 and tested it myself.

Bjorn
