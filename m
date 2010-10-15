From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 5/5] pci: Add support for polling PME state on suspended
 legacy PCI devices
Date: Fri, 15 Oct 2010 13:10:28 -0700
Message-ID: <20101015131028.7fffba40@jbarnes-desktop>
References: <1286216549-5438-1-git-send-email-mjg@redhat.com>
	<1286216549-5438-6-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286216549-5438-6-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon,  4 Oct 2010 14:22:29 -0400
Matthew Garrett <mjg@redhat.com> wrote:

> Not all hardware vendors hook up the PME line for legacy PCI devices,
> meaning that wakeup events get lost. The only way around this is to poll
> the devices to see if their state has changed, so add support for doing
> that on legacy PCI devices that aren't part of the core chipset.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/pci/pci.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 77 insertions(+), 0 deletions(-)

Yuck, polling.  But I guess we don't have an alternative short of
rewiring all the cheap platforms out there!

So, applied.

-- 
Jesse Barnes, Intel Open Source Technology Center
