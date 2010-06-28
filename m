From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Mon, 28 Jun 2010 15:37:25 -0600
Message-ID: <AANLkTil-sdbojCXBp6sR_4xL3JIe6ZENqXuueB61VJ8c@mail.gmail.com>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz>
	<4C27E965.80508@gmail.com>
	<4C283D84.6080504@suse.cz>
	<20100628171410.GA27367@srcf.ucam.org>
	<4C290245.2040001@suse.cz>
	<20100628204820.GA32503@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100628204820.GA32503@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Slaby <jslaby@suse.cz>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 28, 2010 at 2:48 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Jun 28, 2010 at 10:12:53PM +0200, Jiri Slaby wrote:
>> On 06/28/2010 07:14 PM, Matthew Garrett wrote:
>> > http://www-07.ibm.com/hk/products/pos/300/specs.html indicates that
>> > Windows is supported on this hardware. It would be good to verify that
>> > it also fails before we try a model-specific quirk.
>>
>> It would be good for what? I don't see the point, DSDT is broken on that
>> machine and the patch works this around. Why do we need testruns from
>> Windows? And why you think Windows will fail anyway, they can very have
>> the pretty same quirk there.
>
> I can guarantee to you that a generic Windows install does not have a
> quirk for an IBM PoS system released years after that CD was pressed.
> The relevance is that if Windows works without a quirk, then somewhere
> our behaviour diverges from that of Windows and it's likely that other
> machines are also hit by the same issue. Users of those systems may not
> have a support contract with a commercial Linux vendor and may just
> decide to use Windows instead, so there's an incentive for us to
> determine if that's the case and fix Linux's behaviour to match Windows
> rather than to just quirk over it.

Exactly, this seems like a pretty obvious failure, so either IBM's
testing on this machine under Windows was hopelessly inadequate and it
is broken there too, or else Windows is doing something different and
maybe we should be doing the same thing..
