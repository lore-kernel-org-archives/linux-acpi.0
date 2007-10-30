From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Brightness buttons broken on Toshiba Satellite Proc A100 in	kernel
 2.6.23 (Fedora8)
Date: Tue, 30 Oct 2007 16:55:07 +0300
Message-ID: <472737BB.2000609@gmail.com>
References: <loom.20071016T122903-517@post.gmane.org>	 <4714CB1A.7010300@redhat.com> <1193746910.18110.1.camel@rechenknecht.peppercon.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030404050402070708050303"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:58328 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbXJ3NzV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 09:55:21 -0400
Received: by ug-out-1314.google.com with SMTP id z38so114225ugc
        for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2007 06:55:20 -0700 (PDT)
In-Reply-To: <1193746910.18110.1.camel@rechenknecht.peppercon.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Baumann <dannybaumann@web.de>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030404050402070708050303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Danny Baumann wrote:
> Hi,
> 
>>> after upgrading to Fedora 8 which brought kernel 2.6.23 with it I can no longer
>>> use the brightness buttons (Fn+F6/F7) on my above mentioned laptop. Pressing
>>> them generates F6 and F7 key events instead of ACPI events. This used to work
>>> fine in Fedora 7's 2.6.22.9 kernel.
>>>
>>> Is there anything I can do to debug this? Writing a value to
>>> /proc/acpi/video/VGA/LCD/brightness still works fine, so it's just a matter of
>>> the key mapping.
>>> I would try to debug this myself, if I just knew where to look at; so any
>>> pointers in this direction would be appreciated, too.
> 
> Ok, I played around with it some more. It seems that on my Laptop the
> firmware sends out notifications on Fn+F6/7 press.
> Kernel 2.6.23-rc2 worked fine, -rc3 is broken. Reverting ec.c in the
> current Fedora kernel to the version in 2.6.23-rc2 makes brightness
> control work again. After finding that, I tried the current HEAD version
> of ec.c - unfortunately to no avail.
> 2.6.23-rc3 doesn't show up the (unwanted) key events for Fn+F6/7 though
> - this behaviour was introduced in -rc4.
> 
> Is it possible to fix the problem with the amount of information
> provided? If no, what additional information can I provide?
Please check if attached patch changes situation.
Also, please open a new bug entry in bugzilla.kernel.org and put all the data you've collected there.
Please also attach full output from acpidump.

Thanks,
Alex.

--------------030404050402070708050303
Content-Type: text/x-diff;
 name="x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x.patch"

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 06b78e5..22bc38c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -866,6 +866,8 @@ int __init acpi_ec_ecdt_probe(void)
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
+return -ENODEV;
+
 	boot_ec = make_acpi_ec();
 	if (!boot_ec)
 		return -ENOMEM;

--------------030404050402070708050303--
