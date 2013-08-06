From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] acpi, acpi_pci_irq_enable must return an error if ACPI
 cannot map an IRQ.
Date: Tue, 06 Aug 2013 10:37:52 -0400
Message-ID: <52010A40.1040409@redhat.com>
References: <1373900260-1599-1-git-send-email-prarit@redhat.com> <51F0F67F.8070200@redhat.com> <51FEE549.3050001@redhat.com> <2316212.cUEmm9I6aI@vostro.rjw.lan> <20130805140416.GA3882@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130805140416.GA3882@xps8300>
Sender: linux-pci-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <mstowe@redhat.com>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/05/2013 10:04 AM, Heikki Krogerus wrote:
> Hi,
> 
> On Mon, Aug 05, 2013 at 03:30:16PM +0200, Rafael J. Wysocki wrote:
>> On Sunday, August 04, 2013 07:35:37 PM Prarit Bhargava wrote:
>>> Hey Rafael,
>>>
>>> I know you're busy but I was just wondering if this was queued up anywhere or if
>>> you had any other questions?
>>
>> Should be qeued up for 3.12 (currently in linux-next).
> 
> This breaks my xHCI :(
> 
> If the issues is that you are not getting any interrupt, then should
> it not be checked separately and only fail in that case? I'm attaching
> a patch that I made on top of linux-next, where I do just that. Would
> that work for you?
> 

Testing this right now ... I'll get back to everyone when I have results.

P.

> Thanks,
> 
