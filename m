From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] ACPICA: Clean up whitespace of indentation
Date: Tue, 7 Nov 2017 18:43:24 +0800
Message-ID: <20171107104324.GA14732@x1>
References: <1509154461-23909-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509154461-23909-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com
List-Id: linux-acpi@vger.kernel.org

PING!

On 10/28/17 at 09:34am, Baoquan He wrote:
> Use tabs (not spaces) for indentation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/acpi/actbl1.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 6b8714a428b6..d8a4fc066abe 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1438,9 +1438,9 @@ struct acpi_srat_mem_affinity {
>  	u16 reserved;		/* Reserved, must be zero */
>  	u64 base_address;
>  	u64 length;
> -       u32 reserved1;
> +	u32 reserved1;
>  	u32 flags;
> -       u64 reserved2;	       /* Reserved, must be zero */
> +	u64 reserved2;	       /* Reserved, must be zero */
>  };
>  
>  /* Flags */
> -- 
> 2.5.5
> 
