From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date: Tue, 11 Dec 2018 23:51:39 +0100
Message-ID: <CAJZ5v0i+rgLL+KrRs69URbGhUxDK9eUEuLifDWuL2mgpkAv_1g@mail.gmail.com>
References: <20181210181315.5023-1-okaya@kernel.org> <20181210181315.5023-2-okaya@kernel.org>
 <20181211170957.GA335@infradead.org> <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
 <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com>
 <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org> <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
 <6644defb-9199-6467-6e3e-8ce552b56f87@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6644defb-9199-6467-6e3e-8ce552b56f87@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 11, 2018 at 11:22 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/11/2018 5:16 PM, Rafael J. Wysocki wrote:
> >> AFAIK, ACPI spec says that AML code running on non-existing op-regions to be
> >> discarded last time I checked.
> > I guess you mean "disregarded"?
> >
>
> I have seen Linux complain about reads/writes to non-existing I2C opregions
> before as a read/write failure for every single AML transaction. I was under the
> impression that we didn't care.
>
> > So the spec appears to expect the OS to silently ignore the failures
> > in those cases, so why should an error be returned?
> >
>
> I can certainly return success for this case when CONFIG_PCI is not present.
>
> >> I know Linux is noisy about these.

Well, users running kernels with CONFIG_PCI unset on platforms
expecting PCI support to be present in the OS may want to know that I
suppose, so that would be a good reason to return an error, but
perhaps just once rather than on every access (maybe unless debugging
is enabled?).
