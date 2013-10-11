From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/8] ACPI, APEI, CPER: Fix status check during error
 printing
Date: Fri, 11 Oct 2013 10:50:43 +0200
Message-ID: <20131011085043.GA5925@pd.tnic>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <1381473166-29303-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381473166-29303-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2013 at 02:32:39AM -0400, Chen, Gong wrote:
> Commit aaf9d93 only catches condition check before print,
> but the similar check is needed during printing CPER error
> sections.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
