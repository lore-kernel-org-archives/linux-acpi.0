From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] x86/PCI: for debuggability, show host bridge
 windows even when ignoring _CRS
Date: Wed, 4 Nov 2009 10:28:18 -0800
Message-ID: <20091104102818.2d7b9f24@jbarnes-piketon>
References: <20091104173601.17517.71697.stgit@bob.kio>
	<20091104173913.17517.30881.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20091104173913.17517.30881.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 04 Nov 2009 10:39:13 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> We have occasional problems with PCI resource allocation, and
> sometimes they could be avoided by paying attention to what ACPI
> tells us about the host bridges.  This patch doesn't change the
> behavior, but it prints window information that should make debugging
> easier.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Nice, applied these two to linux-next.

-- 
Jesse Barnes, Intel Open Source Technology Center
