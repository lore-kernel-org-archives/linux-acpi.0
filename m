From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date: Tue, 11 Dec 2018 23:16:23 +0100
Message-ID: <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
References: <20181210181315.5023-1-okaya@kernel.org> <20181210181315.5023-2-okaya@kernel.org>
 <20181211170957.GA335@infradead.org> <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
 <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com> <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 11, 2018 at 10:57 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/11/2018 4:46 PM, Rafael J. Wysocki wrote:
> > On Tue, Dec 11, 2018 at 6:37 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>
> >> On 12/11/2018 12:09 PM, Christoph Hellwig wrote:
> >>> On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
> >>>> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
> >>>> out calls that depend on PCI.
> >>>
> >>> I think you want to skip building at least all of hwpci.c if CONFIG_PCI
> >>> is disabled.  Or replace that whole stiking pile of crap with something
> >>> resembling C code..
> >>>
> >>
> >> I can give it a try but I'm under the impression that we don't touch
> >> ACPICA code in general.
> >>
> >> Feel free to correct me.
> >
> > We don't as a rule, but depending on what the patch looks like, we
> > might not follow the rule this time.
> >
>
> OK. Good to know. I'll take a stab at it.
>
> > I wonder though what we do if some AML wants to access PCI config
> > space via an opregion in there.  Have you thought about that?
> >
>
> Return an error.
>
> AFAIK, ACPI spec says that AML code running on non-existing op-regions to be
> discarded last time I checked.

I guess you mean "disregarded"?

So the spec appears to expect the OS to silently ignore the failures
in those cases, so why should an error be returned?

> I know Linux is noisy about these.
>
> I did boot QEMU without CONFIG_PCI. There was a bunch of ACPI errors reported
> during boot as expected but boot succeeded. There was no hard lockup/failure.
