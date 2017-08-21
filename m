From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 19:04:15 +0200
Message-ID: <20170821170415.kttnqiwj2fkntsc7@pd.tnic>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
 <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic>
 <1503333107.2042.163.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503333107.2042.163.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 21, 2017 at 04:41:38PM +0000, Kani, Toshimitsu wrote:
> Putting to a single line leads to "line over 80 characters" warning
> from checkpatch.pl.  Would you still advice to do that?

Yes, the 80 cols rule is not a hard one. Rather, it should be overridden
by human good judgement, like making the code more readable.

> strncmp() is fine without these, but it'd be prudent in case someone
> decides to print these strings with printk().  Will do.

Someone does already use them in printk():

+               pr_err(PREFIX "Vendor \"%6.6s\" System \"%8.8s\" Revision 0x%x has a known ACPI BIOS problem.\n",
+                      acpi_blacklist[i].oem_id,
+                      acpi_blacklist[i].oem_table_id,
+                      acpi_blacklist[i].oem_revision);


> 'data' here is private to the caller.  So, I do not think we need to
> define the bits.  Shall I change the name to 'driver_data' to make it
> more explicit?

You changed it to 'data'. It was a u32-used-as-boolean is_critical_error
before.

So you can just as well make it into flags and people can extend those
flags if needed. A flag bit should be enough in most cases anyway. If
they really need driver_data, then they can add a void * member.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
