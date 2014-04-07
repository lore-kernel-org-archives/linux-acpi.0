From: Thomas Renninger <trenn@suse.de>
Subject: Introduce acpi_validate and ec_acces in tools/power/acpi
Date: Mon,  7 Apr 2014 15:16:53 +0200
Message-ID: <1396876617-53345-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47850 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755370AbaDGNRB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 09:17:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lv.zheng@intel.com, linux-acpi@vger.kernel.org

Hi Rafael,

these are tools we already have packaged in our acpica package for quite
a while:
  - acpi_validate  (disassemble and recompile dumped ACPI tables, or a
                    provided acpidump file. It references all SSDTs/DSDTs,
                    which people often do not know or is cumbersome to do).
  - ec_access       is the userspace tool for the ec_sys EC debug driver.
                    Formerly only the thinkpad_acpi driver could do this.
                    This got proplery moved into a ec_sys debug driver and
                    ec_access can monitor changes e.g. every second of the
                    EC registers, nicely shows them to find out about
                    EC problems.

IMO both perfectly fit into tools/power/acpi.
Other candidates could be:
  - acpi_genl       (Monitor ACPI events)
                    https://01.org/linux-acpi/utilities
  - wmidump         This one can interpret WMI objects from a raw _WDG
                    buffer (part of DSDT/SSDT BIOS code).

I didn't use the last one often, but it seem to be really useful if you
implement ACPI WMI stuff.

If you agree with these patches, can you please queue them up for the
next kernel release, please.

Tested: Created a tarball with tools/power/acpi directory added and
        include/acpi copied into and build them separately as a package via
        our build service via:
make -C %{acpi_tools_dir} CFLAGS="-DDEFINE_ALTERNATE_TYPES
        -DACPI_USE_SYSTEM_INTTYPES=0 -I ../../include %{optflags}"
make -C %{acpi_tools_dir} install DESTDIR="%{buildroot}" mandir=%{_mandir}


Thanks a lot,

      Thomas

