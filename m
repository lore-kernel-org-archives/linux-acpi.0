From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/1] gpio: add Lynxpoint chipset gpio driver.
Date: Wed, 19 Dec 2012 17:24:47 +0000
Message-ID: <20121219172447.5DB123E0C7C@localhost>
References: <1355326958-18914-1-git-send-email-mathias.nyman@linux.intel.com> <1355326958-18914-2-git-send-email-mathias.nyman@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355326958-18914-2-git-send-email-mathias.nyman@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 12 Dec 2012 17:42:38 +0200, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
> Add gpio support for Intel Lynxpoint chipset.
> Lynxpoint supports 94 gpio pins which can generate interrupts.
> Driver will fail requests for pins that are marked as owned by ACPI, or
> set in an alternate mode (non-gpio).
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Applied, thanks

g.
