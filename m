From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/2] PNPACPI, x86/PCI: handle _CRS windows like Windows does
Date: Thu, 29 Apr 2010 09:42:16 -0600
Message-ID: <201004290942.16739.bjorn.helgaas@hp.com>
References: <20100427202122.23753.63421.stgit@bob.kio> <alpine.LFD.2.00.1004282147490.2598@sony>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1004282147490.2598@sony>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 28 April 2010 07:48:42 pm Len Brown wrote:
> applied both to acpi-test tree.
> 
> you have pretty convincing evidence in the bug report that this is 
> "corrrect" -- where "correct" = matches common industry practice.
> 
> I wonder if this should wait for .35 or not...

I chatted with Jesse about this yesterday, and we plan to put the
x86/PCI part in .34.  Actually, it looks like Linus has already
pulled it.

If you wanted to put the PNPACPI one in for .34, I wouldn't complain,
I guess, but I don't think we need it because I'm pretty sure nobody
actually relies on it.  You'd be able to see the difference in
/sys/bus/pnp/devices/*/resources, but as far as I know, that's the only
place we'd notice.   

Bjorn
