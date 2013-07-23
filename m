From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/13] ACPI/IPMI: Fix potential response buffer overflow
Date: Tue, 23 Jul 2013 07:54:19 -0700
Message-ID: <20130723145419.GA12065@kroah.com>
References: <cover.1370652213.git.lv.zheng@intel.com>
 <cover.1374566394.git.lv.zheng@intel.com>
 <be902a592144313dbf382876965166166bf81438.1374566394.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <be902a592144313dbf382876965166166bf81438.1374566394.git.lv.zheng@intel.com>
Sender: stable-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 23, 2013 at 04:08:59PM +0800, Lv Zheng wrote:
> This patch enhances sanity checks on message size to avoid potential buffer
> overflow.
> 
> The kernel IPMI message size is IPMI_MAX_MSG_LENGTH(272 bytes) while the
> ACPI specification defined IPMI message size is 64 bytes.  The difference
> is not handled by the original codes.  This may cause crash in the response
> handling codes.
> This patch fixes this gap and also combines rx_data/tx_data to use single
> data/len pair since they need not be seperated.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Reviewed-by: Huang Ying <ying.huang@intel.com>
> ---
>  drivers/acpi/acpi_ipmi.c |  100 ++++++++++++++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 39 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>

Same goes for the other patches you sent in this thread...
