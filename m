From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date: Wed, 4 Jul 2018 11:53:49 +0100
Message-ID: <20180704105349.GA14665@e107155-lin>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
 <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
 <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
 <8518137d-c859-657e-844f-51720f6ef8dd@arm.com>
 <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Srinath Mannam <srinath.mannam@broadcom.com>, "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>, Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, nv@vosn.de
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 04, 2018 at 12:17:20PM +0200, Nikolaus Voss wrote:
> On Wed, 4 Jul 2018, Sudeep Holla wrote:
> >

[...]

> >+1 on NACK for this and anything else that abuse PRP0001 as a short cut
> >approach.
>
> This is no abuse but exactly what PRP0001 is meant for. The basic idea of
> PRP0001 is to reuse DT "compatible" strings in ACPI namespace, see
> Documentation/acpi/enumeration.txt. Reusing also means getting access to the
> of_device_id.
>

Sorry for not being descriptive. It has been discussed a lot in past and
I assume someone would had gone through them, so gave no information in
my response.

> Allocating an ACPI id for an already existing DT driver is redundant, isn't it?
>

I think Andy had provided the summary and the intentions. Rafael has also
confirmed, I have nothing else to add.

--
Regards,
Sudeep
