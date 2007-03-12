From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: regarding ACPI support in 2.6.21
Date: Mon, 12 Mar 2007 15:46:49 +0000
Message-ID: <20070312154649.5f661a39@lxorguk.ukuu.org.uk>
References: <45F5648C.7020506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <45F5648C.7020506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> I think it might be better to give up ACPI support in 2.6.21 and target
> 2.6.22.  What do you think?

I removed it from my tree already so that I can actually use libata and
do real work. The "crash every non PCI controller" feature in the current
ACPI hacks means PCMCIA and ISAPnP do not work any more with libata.

In its current state it should be disabled, its broken, its wrong.

Alan
