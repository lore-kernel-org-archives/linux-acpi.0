From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks correctable
 errors as "fatal"
Date: Thu, 26 Apr 2018 13:20:57 +0200
Message-ID: <20180426112057.GB15009@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-4-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180425203957.18224-4-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 25, 2018 at 03:39:51PM -0500, Alexandru Gagniuc wrote:
> There seems to be a culture amongst BIOS teams to want to crash the
> OS when an error can't be handled in firmware. Marking GHES errors as
> "fatal" is a very common way to do this.
> 
> However, a number of errors reported by GHES may be fatal in the sense
> a device or link is lost, but are not fatal to the system. When there
> is a disagreement with firmware about the handleability of an error,
> print a warning message.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/acpi/apei/ghes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8ccb9cc10fc8..34d0da692dd0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -539,6 +539,12 @@ static void ghes_do_proc(struct ghes *ghes,
>  					       sec_sev, err,
>  					       gdata->error_data_length);
>  		}
> +
> +	}
> +
> +	if ((sev >= GHES_SEV_PANIC) && (ghes_actual_severity(ghes) < sev)) {
> +		pr_warn("FIRMWARE BUG: Firmware sent fatal error that we were able to correct");
> +		pr_warn("BROKEN FIRMWARE: Complain to your hardware vendor");

Pasting the same comment from last time since you missed it:

"No, I don't want any of that crap issuing stuff in dmesg and then people
opening bugs and running around and trying to replace hardware.

We either can handle the error and log a normal record somewhere or we
cannot and explode. The complaining about the FW doesn't bring shit."

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
