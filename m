From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] Add x64 support to debugfs
Date: Wed, 12 May 2010 14:47:37 -0700
Message-ID: <20100512214737.GA27785@kroah.com>
References: <1273653641-4519-1-git-send-email-ying.huang@intel.com>
 <1273653641-4519-2-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1273653641-4519-2-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, andi@firstfloor.org, linux-acpi@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 12, 2010 at 04:40:40PM +0800, Huang Ying wrote:
> Add debugfs_create_x64. This is needed by ACPI APEI EINJ parameters support.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> CC: Greg KH <greg@kroah.com>

Do you want me to take this through my tree?  Or should it go through
the acpi one as you depend on it?

If so, that's fine with me, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patch then.

thanks,

greg k-h
