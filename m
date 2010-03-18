From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/3] hpet: pass physical address, not entire hpet_data,
 to hpet_is_known()
Date: Thu, 18 Mar 2010 08:27:48 +0100
Message-ID: <4BA1D5F4.7070304@ladisch.de>
References: <20100317173329.31124.69795.stgit@bob.kio> <20100317173505.31124.74595.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100317173505.31124.74595.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org, "Venkatesh Pallipadi (Venki)" <venkatesh.pallipadi@intel.com>
List-Id: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> No functional change; hpet_is_known() only needs the physical address,
> so supplying that instead of the whole struct hpet_data makes the callers
> a little simpler.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Clemens Ladisch <clemens@ladisch.de>
