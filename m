From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / PMIC: make intel_pmic_opregion_data
 structures const
Date: Tue, 7 Nov 2017 11:30:55 +0200
Message-ID: <20171107093055.GP18997@lahna.fi.intel.com>
References: <1509721428-6147-1-git-send-email-bhumirks@gmail.com>
 <1509721428-6147-3-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509721428-6147-3-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 03, 2017 at 04:03:48PM +0100, Bhumika Goyal wrote:
> Make these structures as const as they are only passed to the function
> intel_pmic_install_opregion_handler having the argument as const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
