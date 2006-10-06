From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH] Cast removal
Date: Fri, 6 Oct 2006 16:35:55 +0200
Message-ID: <20061006143555.GC14186@rhun.haifa.ibm.com>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932368AbWJFOgB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>, Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 05, 2006 at 03:14:02PM -0700, Moore, Robert wrote:
> If you're discussing this type of thing, I agree wholeheartedly:
> 
> static void acpi_processor_notify(acpi_handle handle, u32 event, void
> *data)  {
> -	struct acpi_processor *pr = (struct acpi_processor *)data;
> +	struct acpi_processor *pr = data;
> 
> 
> I find this one interesting, as we've put a number of them into the
> ACPICA core:
> 
> -	(void) kmem_cache_destroy(cache);
> +	kmem_cache_destroy(cache);
> 
> I believe that the point of the (void) is to prevent lint from
> squawking, and perhaps some picky ANSI-C compilers. What is the overall
> Linux policy on this?

IMHO there's another reason to do this which is much more relevant: it
tells the reader that whoever wrote it knows that it returns a value
and ignores it on purpose.

Cheers,
Muli
