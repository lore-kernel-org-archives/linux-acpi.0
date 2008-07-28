From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] fix warning in pci_slot
Date: Mon, 28 Jul 2008 15:05:47 -0700
Message-ID: <200807281505.47467.jbarnes@virtuousgeek.org>
References: <20080722183717.GF7337@parisc-linux.org> <20080722205602.GA7657@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20080722205602.GA7657@ldl.fc.hp.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, July 22, 2008 1:56 pm Alex Chiang wrote:
> * Matthew Wilcox <matthew@wil.cx>:
> > I get warnings about 'device' possibly being used uninitialised.  While I
> > can deduce this is not true, it seems that GCC can't.  This patch changes
> > `check_slot' to return device on success and -1 on error, which shuts
> > GCC up.
> >
> > Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
>
> Perhaps a more meaningful patch title, like:
>
> 	fix bogus "'device' may be used uninitialized" warning in pci_slot
>
> But otherwise,
>
> Acked-by: Alex Chiang <achiang@hp.com>

Applied, thanks.

Jesse
