From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/5] PNP: HP nx6325 fixup: reserve unreported resources
Date: Wed, 15 Dec 2010 11:21:42 -0800
Message-ID: <AANLkTik7_6Oc6jcjQVVBmJ13LRFMopEg6qEdB43zMMz5@mail.gmail.com>
References: <20101208213606.13026.47657.stgit@bob.kio> <20101215062650.GB2728@helgaas.com>
 <AANLkTi=U+CTn=RDvYG0w6JK0Owv_TEc9YNtAtm9DeLKi@mail.gmail.com> <201012151118.30512.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201012151118.30512.bjorn.helgaas@hp.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 15, 2010 at 10:18 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> =
wrote:
>
> So here's my proposal for .37:
> =A0- Keep the current state of _CRS enabled by default (for 2008
> =A0 =A0and newer machines).
> =A0- Allocate bottom-up always
> =A0- Avoid E820 reservations

Sounds sane to me. And yes, the fact that the BIOS tends to allocate
things top-down probably does mean that the whole bottom-up approach
tends to be the safer model.

                          Linus
