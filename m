From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v3
Date: Mon, 22 May 2006 11:33:01 +0200
Message-ID: <20060522093301.GB25624@elf.ucw.cz>
References: <200605220333.k4M3Xkg6020638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750753AbWEVJdl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 May 2006 05:33:41 -0400
Content-Disposition: inline
In-Reply-To: <200605220333.k4M3Xkg6020638@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jayakumar.acpi@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Po 22-05-06 11:33:46, jayakumar.acpi@gmail.com wrote:
> Hi Len, ACPI, and kernel folk,
> 
> Appended is v3 after removing unused defines and whitespace 
> cleanup. Thanks to Pavel Machek for the feedback.
> 
> Please let me know if it looks okay and if you have any feedback
> or suggestions.
> 
> Thanks,
> Jaya Kumar
> 
> Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>

ACK, but I guess you should cc Dmitry (input maintainer) and possibly
Andrew Morton to get it in... Ok, few more nits.

> +#else
> +#define atlas_free_input(...)
> +#define atlas_setup_input(...) 0
> +#define atlas_input_report(...) 
> +#endif

Does the driver actually do anything useful in this case?

> +	}
> +
> +	return status ;

Extra " " before ;.

> +static struct acpi_driver atlas_acpi_driver = {
> +	.name = ACPI_ATLAS_NAME,
> +	.class = ACPI_ATLAS_CLASS,
> +	.ids = ACPI_ATLAS_BUTTON_HID,
> +	.ops = {
> +		.add = atlas_acpi_button_add,
> +		.remove = atlas_acpi_button_remove,
> +		},

Extra tab before }.

> +MODULE_SUPPORTED_DEVICE("Atlas ACPI");

Are you sure this si good idea?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
