From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/9] PCI: revert to allocating bottom-up, avoid E820 areas
Date: Thu, 16 Dec 2010 19:00:02 -0800
Message-ID: <4D0AD232.8020107@zytor.com>
References: <20101216173614.8185.19462.stgit@bob.kio> <AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <AANLkTikqmfWhLuTiP8tPqcCGMZUe=iDOJVUZGy8pnRL0@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On 12/16/2010 01:59 PM, Linus Torvalds wrote:
> On Thu, Dec 16, 2010 at 9:38 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>>
>> So I think the best band-aid for now is to revert to bottom-up allocation
>> and do a better job of avoiding E820 reserved areas.  Obviously, it's not
>> complete because we could still trip over ACPI devices (as in 23802), but
>> that's a problem we've always had and it's not as likely if we go bottom-up.
> 
> Ok, ack for this series. Have we got testers for it? In particular,
> have the people who have seen regressions been notified of this new
> series?
> 

Acked-by: H. Peter Anvin <hpa@zytor.com>

... for the series as well.  For what it's worth.

	-hpa
