From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v3 2/3] x86/tboot: Fail extended mode reduced
 hardware sleep
Date: Wed, 26 Jun 2013 15:44:09 +0100
Message-ID: <51CB1A5902000078000E0D82@nat28.tlf.novell.com>
References: <1372255575-29567-1-git-send-email-benjamin.guthro@citrix.com>
 <1372255575-29567-3-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372255575-29567-3-git-send-email-benjamin.guthro@citrix.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Guthro <benjamin.guthro@citrix.com>
Cc: Gang Wei <gang.wei@intel.com>, tboot-devel@lists.sourceforge.net, xen-devel@lists.xen.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafaell J . Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>>> On 26.06.13 at 16:06, Ben Guthro <benjamin.guthro@citrix.com> wrote:
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -273,7 +273,8 @@ static void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
>  		offsetof(struct acpi_table_facs, firmware_waking_vector);
>  }
>  
> -static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
> +static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
> +		       u8 extended)

I don't see why this couldn't remain "bool" - the only complain was
that ACPI CA shouldn't use it.

Jan
