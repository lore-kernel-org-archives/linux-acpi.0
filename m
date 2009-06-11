From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [PATCH v2 08/11] PCI Hotplug: acpiphp: convert to
 acpi_get_pci_dev
Date: Thu, 11 Jun 2009 14:48:45 -0700
Message-ID: <20090611144845.76e7dc1d@jbarnes-g45>
References: <20090604054504.18802.21690.stgit@bob.kio>
	<20090604055857.18802.34388.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759797AbZFKVte@vger.kernel.org>
In-Reply-To: <20090604055857.18802.34388.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 03 Jun 2009 23:58:57 -0600
Alex Chiang <achiang@hp.com> wrote:

> Now that acpi_get_pci_dev is available, let's use it instead of
> acpi_get_pci_id.
> 
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Signed-off-by: Alex Chiang <achiang@hp.com>
> ---
> 

Applied to linux-next, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
