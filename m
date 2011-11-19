From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [2.6.32] Please cherry-pick Toshiba Satellite DSDT corruption
 workaround
Date: Fri, 18 Nov 2011 23:14:27 -0600
Message-ID: <20111119051427.GB12471@elie.hsd1.il.comcast.net>
References: <20111118200908.3274.86645.reportbug@pingwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58514 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab1KSFOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Nov 2011 00:14:37 -0500
Content-Disposition: inline
In-Reply-To: <20111118200908.3274.86645.reportbug@pingwin>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@vger.kernel.org
Cc: =?utf-8?B?TWlyb3PFgmF3?= Zalewski <miniopl@poczta.onet.pl>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>

Hi Greg,

Miros=C5=82aw Zalewski wrote[1]:

> When kernel is invoked with ACPI support, it has various problems wit=
h USB=20
> detection
[...]
> When finally booted, at least wireless driver (ath9k)=20
> does not work. I heard that sound does not work as well, but haven't=20
> tested it myself. With ACPI enabled, kernel is unable to shutdown com=
puter=20
> properly.
[...]
> This is known flaw of Toshiba Satellite C650/kernel. You can find var=
ious=20
> posts around the net about it.
>
> Toshiba Satellite C650 comes in four variants:
> PSC08E
> PSC10E
> PSC12E
> PSC14E
[...]
> In July there was a BIOS update for 12E and 14E. The new BIOS is vers=
ion 1.5=20
> and it is said to fix ACPI issues on Linux [3]. Unfortunetly there is=
 no new=20
> BIOS for 08E and 10E machines.

Miros=C5=82aw confirmed that cherry-picking the following six patches o=
n top
of your linux-2.6.32.y tree brings his machine back to sanity:

 729df0f848da (ACPICA: Add detection of corrupted/replaced DSDT, 2010-0=
4-01)
 69ec87efa815 (ACPICA: Add subsystem option to force copy of DSDT to lo=
cal
  memory, 2010-04-01)
 43323cb4c4b6 (ACPICA: Update DSDT copy/detection, 2010-04-07)
 aa2110cb1a75 (ACPI: add boot option acpi=3Dcopy_dsdt to fix corrupt DS=
DT,
  2010-04-08)
 cce4f632db20 (ACPI: fix early DSDT dmi check warnings on ia64,
  2010-05-12)
 100cf87788c0 (ACPI: invoke DSDT corruption workaround on all Toshiba
  Satellite, 2010-09-28)

Patches 1-5/6 have been in Debian squeeze since last September and seem
to work well.  Patch 6/6 turns on acpi=3Dcopy_dsdt by default for
additional machines that need it, including Miros=C5=82aw's.

The DMI pattern in 6/6 overreaches a little in my opinion --- it would
be better to look at a BIOS version number or something instead.  But
it is what was done in mainline, and false positives should be
harmless.  I have tested on my PSC16U (which has BIOS 1.60 and doesn't
need the workaround) that I get

 TOSHIBA Satellite detected - force copy of DSDT to local memory

and no other noticeable side-effect.

The patches apply cleanly to linux-2.6.32.y except for patch 2/6,
which has a boring textual conflict with the inverse of 4cdf1a5 (and
the obvious conflict resolution works).

Patches 1-5/6 hit mainline in v2.6.35-rc1~477.  Patch 6/6 is
v2.6.36-rc7~25^2^5.

Anyway, I think these make good candidates for application to the
2.6.32.y longterm tree.  What do you think?

Regards,
Jonathan

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D55;bug=3D598104
> [3] - http://ubuntuforums.org/showthread.php?p=3D9622930#post9622930
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
