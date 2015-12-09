From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: constify pci_platform_pm_ops structure
Date: Wed, 09 Dec 2015 02:21:21 +0100
Message-ID: <11604085.iKre2i4LQp@vostro.rjw.lan>
References: <1449419625-29045-1-git-send-email-Julia.Lawall@lip6.fr> <1556686.IXJIjFBvQx@vostro.rjw.lan> <20151207160649.GG7994@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151207160649.GG7994@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, December 07, 2015 10:06:49 AM Bjorn Helgaas wrote:
> On Mon, Dec 07, 2015 at 02:41:34AM +0100, Rafael J. Wysocki wrote:
> > On Sunday, December 06, 2015 05:33:45 PM Julia Lawall wrote:
> > > The pci_platform_pm_ops structure is never modified, so declare it as
> > > const.
> > > 
> > > Done with the help of Coccinelle.
> > > 
> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > OK
> > 
> > Bjorn, do you want me to handle this one?
> 
> Sure, sounds good to me.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK, queued up for 4.5, thanks!

Rafael
