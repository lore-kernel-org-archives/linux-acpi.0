From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V3 2/2] acpi: apei: call into AER handling regardless of
 severity
Date: Tue, 28 Nov 2017 11:57:12 +0100
Message-ID: <20171128105712.zgexfehtvj4rnfur@pd.tnic>
References: <1510758867-15940-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510758867-15940-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 15, 2017 at 08:14:27AM -0700, Tyler Baicar wrote:
> Currently the GHES code only calls into the AER driver for
> recoverable type errors. This is incorrect because errors of
> other severities do not get logged by the AER driver and do not
> get exposed to user space via the AER trace event. So, call
> into the AER driver for PCIe errors regardless of the severity
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
