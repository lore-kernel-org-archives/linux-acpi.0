From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 4] mce: acpi/apei: Add a sysctl to control page offlining
 on firmware report
Date: Wed, 3 Jul 2013 16:46:42 +0200
Message-ID: <20130703144641.GC13951@pd.tnic>
References: <20130701153728.6197.14022.stgit@localhost.localdomain>
 <20130702125137.7388.97225.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130702125137.7388.97225.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 02, 2013 at 06:24:00PM +0530, Naveen N. Rao wrote:
> I am adding another patch here to disable page offlining in case the firmware
> starts acting up.
> 
> Thanks,
> Naveen
> 
> --
> 
> Add a sysctl memory_failure_soft_offline to control what is done on receipt of
> firmware ghes notification for a corrected error. By default, kernel tries
> to soft-offline the page immediately. If set to 0, no action is taken.

What is the rationale for that? Are we adding it just in case, as a
chicken bit or do you have a specific case?

If the second, we'd love to hear about it in the commit message. :)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
