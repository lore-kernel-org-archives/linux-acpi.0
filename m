From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/8] ACPICA: Support for external package objects as method arguments
Date: Mon, 18 Jun 2007 00:53:28 -0400
Message-ID: <200706180053.28518.lenb@kernel.org>
References: <1180761344795-git-send-email-len.brown@intel.com> <6287ee32952b502c23d54f12895c3895ddbe5013.1180761191.git.len.brown@intel.com> <1180995938.5466.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50953 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbXFRExh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jun 2007 00:53:37 -0400
In-Reply-To: <1180995938.5466.3.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

Applied.

thanks Myron!

-Len

On Monday 04 June 2007 18:25, Myron Stowe wrote:
> >From : Myron Stowe <myron.stowe@hp.com>
> 
> I believe there is an issue with the new 'package' argument type support
> just submitted upstream.
> 
> In the routine acpi_ut_create_package_object(), if the
> ACPI_ALLOCATE_ZEROED() fails then ACPI_FREE(package_desc) is called as
> part of the cleanup.  This should instead be
> acpi_ut_remove_reference(package_desc) in order to remove the reference
> acquired from acpi_ut_create_internal_object() [see the routine
> acpi_ut_create_buffer_object() as an example of proper functionality].
> 
> This patch is against the Linux-ized ACPI CA, since I don't have a good
> way to modify or test the original Intel version.  I hope it's small
> enough that you can easily make the corresponding change to the Intel
> version.
> 
> This modification may be used under either the GPL or the BSD-style
> license used for the Intel ACPI CA.
> 
> Signed-off-by: Myron Stowe < myron.stowe@hp.com>
> 
> --- a/drivers/acpi/utilities/utobject.c    2007-06-04 15:49:19.000000000 -0600
> +++ b/drivers/acpi/utilities/utobject.c    2007-06-04 15:52:17.000000000 -0600
> @@ -177,7 +177,7 @@
>         package_elements = ACPI_ALLOCATE_ZEROED((acpi_size)
>                                                 (count + 1) * sizeof(void *));
>         if (!package_elements) {
> -               ACPI_FREE(package_desc);
> +               acpi_ut_remove_reference(package_desc);
>                 return_PTR(NULL);
>         }
> 
