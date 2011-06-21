From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/4] ACPI, APEI, GHES, Prevent GHES to be built as module
Date: Tue, 21 Jun 2011 09:23:01 +0200
Message-ID: <20110621072301.GA3263@one.firstfloor.org>
References: <1308640587-24502-1-git-send-email-ying.huang@intel.com> <1308640587-24502-2-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308640587-24502-2-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 21, 2011 at 03:16:24PM +0800, Huang Ying wrote:
> GHES (Generic Hardware Error Source) is used to process hardware error
> notification in firmware first mode.  But because firmware first mode
> can be turned on but can not be turned off, it is unreasonable to
> unload the GHES module with firmware first mode turned on.  To avoid
> confusion, this patch makes GHES can be enable/disable in
> configuration time, but not built as module and unload at run time.

It's better to keep it as a module, but disable unloading.
You can do that with a __module_get(THIS_MODULE) in the init code
when FFM is detected.

-Andi
