From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/9] vsprintf: add %pR decoding and %pr for raw
 struct resource
Date: Tue, 13 Oct 2009 13:32:00 -0700
Message-ID: <1255465920.18975.72.camel@Joe-Laptop.home>
References: <20091013192040.22336.84876.stgit@bob.kio>
	 <20091013192210.22336.28703.stgit@bob.kio>
	 <1255462808.18975.70.camel@Joe-Laptop.home>
	 <200910131407.08290.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761148AbZJMUck@vger.kernel.org>
In-Reply-To: <200910131407.08290.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2009-10-13 at 14:07 -0600, Bjorn Helgaas wrote:
> On Tuesday 13 October 2009 01:40:08 pm Joe Perches wrote:
> > On Tue, 2009-10-13 at 13:22 -0600, Bjorn Helgaas wrote:
> > > This adds support for printing struct resource type and flag information.
> > > For example, "%pR" looks like "[mem 0xf5df0000-0xf5df3fff 64bit pref]",
> > > and "%pr" looks like "[mem 0xff5e2000-0xff5e2007 flags 0x201]".
> > Isn't it better to avoid using multiple characters
> > for a single type?
> I followed the example of F/f, S/s, M/m, etc.  I could
> easily go back to %pR/%pRf or something, but I don't know
> if it's worth the trouble.

I'd prefer %pR and %pRr for raw, but maybe that's just me.

cheers, Joe
