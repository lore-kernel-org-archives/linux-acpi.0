From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: Introduce acpi_validate and ec_acces in tools/power/acpi
Date: Tue, 8 Apr 2014 02:09:58 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802546F72@SHSMSX101.ccr.corp.intel.com>
References: <1396876617-53345-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19142 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbaDHCKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2014 22:10:41 -0400
In-Reply-To: <1396876617-53345-1-git-send-email-trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Thomas

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Thomas Renninger
> Sent: Monday, April 07, 2014 9:17 PM
> 
> Hi Rafael,
> 
> these are tools we already have packaged in our acpica package for quite
> a while:
>   - acpi_validate  (disassemble and recompile dumped ACPI tables, or a
>                     provided acpidump file. It references all SSDTs/DSDTs,
>                     which people often do not know or is cumbersome to do).
>   - ec_access       is the userspace tool for the ec_sys EC debug driver.
>                     Formerly only the thinkpad_acpi driver could do this.
>                     This got proplery moved into a ec_sys debug driver and
>                     ec_access can monitor changes e.g. every second of the
>                     EC registers, nicely shows them to find out about
>                     EC problems.
> 
> IMO both perfectly fit into tools/power/acpi.
> Other candidates could be:
>   - acpi_genl       (Monitor ACPI events)
>                     https://01.org/linux-acpi/utilities
>   - wmidump         This one can interpret WMI objects from a raw _WDG
>                     buffer (part of DSDT/SSDT BIOS code).
> 
> I didn't use the last one often, but it seem to be really useful if you
> implement ACPI WMI stuff.
> 
> If you agree with these patches, can you please queue them up for the
> next kernel release, please.
> 
> Tested: Created a tarball with tools/power/acpi directory added and
>         include/acpi copied into and build them separately as a package via
>         our build service via:
> make -C %{acpi_tools_dir} CFLAGS="-DDEFINE_ALTERNATE_TYPES
>         -DACPI_USE_SYSTEM_INTTYPES=0 -I ../../include %{optflags}"
> make -C %{acpi_tools_dir} install DESTDIR="%{buildroot}" mandir=%{_mandir}

Please also do the tools build tests with the DEBUG environment switched.
Something like:
make DEBUG=true ....
make DEBUG=false ...

Thanks and best regards
-Lv

> 
> 
> Thanks a lot,
> 
>       Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
