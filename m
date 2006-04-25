From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] reverse pci config space restore order
Date: Tue, 25 Apr 2006 12:51:01 +0200
Message-ID: <1145962261.3114.23.camel@laptopd505.fenrus.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13D48A5@pdsmsx411.ccr.corp.intel.com>
	 <20060425104800.GA26109@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932193AbWDYKvL@vger.kernel.org>
In-Reply-To: <20060425104800.GA26109@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2006-04-25 at 11:48 +0100, Matthew Garrett wrote:
> On Tue, Apr 25, 2006 at 02:50:57PM +0800, Yu, Luming wrote:
> 
> > -	for (i = 0; i < 16; i++)
> > +	for (i = 15; i >= 0 ; i--)
> 
> We certainly need to do /something/ here, but I'm not sure this is it. 
> Adam Belay has code to limit PCI state restoration to the PCI-specified 
> registers, with the idea being that individual drivers fix things up 
> properly. While this has the obvious drawback that almost every PCI 
> driver in the tree would then need fixing up, it's also probably the 
> right thing.

it has a second drawback: it assumes all devices HAVE a driver, which
isn't normally the case...
