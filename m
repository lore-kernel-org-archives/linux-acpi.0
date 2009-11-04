From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] vsprintf: use %pR, %pr instead of %pRt, %pRf
Date: Wed, 4 Nov 2009 09:43:35 -0800
Message-ID: <20091104094335.31247fe2@jbarnes-piketon>
References: <20091027192647.12712.36043.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757595AbZKDRni@vger.kernel.org>
In-Reply-To: <20091027192647.12712.36043.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, Joe Perches <joe@perches.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Oct 2009 13:26:47 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Jesse accidentally applied v1 [1] of the patchset instead of v2 [2].
> This is the diff between v1 and v2.
> 
> The changes in this patch are:
>     - tidied vsprintf stack buffer to shrink and compute size more
>       accurately
>     - use %pR for decoding and %pr for "raw" (with type and flags)
> instead of adding %pRt and %pRf
> 
> [1] http://lkml.org/lkml/2009/10/6/491
> [2] http://lkml.org/lkml/2009/10/13/441
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Applied, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
