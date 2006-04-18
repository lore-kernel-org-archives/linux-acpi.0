From: "Garry T. Williams" <gtwilliams@gmail.com>
Subject: Re: acpi function test suite 0.1 and test results
Date: Mon, 17 Apr 2006 23:29:08 -0400
Message-ID: <200604172329.08968.gtwilliams@gmail.com>
References: <D352FD896397D04482B87731BD4DBE7F4111E9@bjsmsx401nb>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.225]:14172 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751394AbWDRD3Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 23:29:16 -0400
Received: by wproxy.gmail.com with SMTP id i2so200030wra
        for <linux-acpi@vger.kernel.org>; Mon, 17 Apr 2006 20:29:15 -0700 (PDT)
In-Reply-To: <D352FD896397D04482B87731BD4DBE7F4111E9@bjsmsx401nb>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ling L" <ling.l.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, "Zhang, Kexin" <kexin.zhang@intel.com>, "Luo, Zhenlin" <zhenlin.luo@intel.com>

On Monday 17 April 2006 22:18, Yu, Ling L wrote:
> All
> I and Kexin Zhang wrote some ACPI function test suite, please download
> it from
> http://acpi.sourceforge.net/validation/testcases/acpi-test-0.1.tar.gz 
> (which also includes the ABAT0.2 I published before)

I thought you should know that this test suite hung my laptop, forcing a 
complete power off to recover.

Here's the details:

Hardware: Sony Vaio FS640/W

$ uname -a
Linux tfr 2.6.16-1.2080_FC5 #1 Tue Mar 28 03:38:34 EST 2006 i686 i686 
i386 GNU/Linux
$

This system was *upgraded* from FC4.

Here's where it hung: (I got this by running the test suite as a normal 
user instead of root.)


*******************************************************
*           Test ACPI drivers                         *
*******************************************************

-------------------------------------------------------
Driver      State       Action      Results
ac          loaded      verifying   PASS



By the way, I do not get a AC adapter event from acpid on this machine.  
I do get a battery event and the battery information in /proc/acpi 
yields the AC adapter status.

I load the sony_acpi module and run the fsfn daemon for Fn key support.

Before that, this might be of interest (*not* run as root):



Driver      State       Device      Item         Information
------      -----       ------      ----         -----------
ac          loaded      NO
battery     loaded      NO
button      loaded      lid/LID0    info         type: Lid Switch
                                    state        state: open
                        power/PWRB  info         type: Power Button (CM)
                        power/PWRF  info         type: Power Button (FF)
ec          build-in    NO
fan         build-in    NO
power       build-in    NO
processor   build-in    NO
thermal     build-in    NO
video       loaded      GFX0        DOS          DOS setting: <1>
                                    POST         <not supported>
                                    POST_info    <not supported>
                                    ROM          <TODO>
                                    info         Switching heads: yes
                                                 Video ROM: yes
                                                 Device to be POSTed on 
                                                 boot:
                                                    no
                        GFX0/CRT    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0100
                                                 type: CRT
                                                 known by bios: no
                                    state        state: 0x1d
                                                 query: 0x00
                        GFX0/DVI    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0320
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x1d
                                                 query: 0x00
                        GFX0/LCD    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0410
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x1f
                                                 query: 0x00
                        GFX0/TV     EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0240
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x1d
                                                 query: 0x00
                        NGFX        DOS          DOS setting: <1>
                                    POST         <not supported>
                                    POST_info    <not supported>
                                    ROM          <TODO>
                                    info         Switching heads: yes
                                                 Video ROM: no
                                                 Device to be POSTed on 
                                                 boot:
                                                    no
                        NGFX/CRT    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0100
                                                 type: CRT
                                                 known by bios: no
                                    state        state: 0x0d
                                                 query: 0x00
                        NGFX/DVI    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0111
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x0d
                                                 query: 0x00
                        NGFX/LCD    EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0118
                                                 type: UNKNOWN
                                                 known by bios: no
                                    state        state: 0x0f
                                                 query: 0x00
                        NGFX/TV     EDID         <not supported>
                                    brightness   <not supported>
                                    info         device_id: 0x0200
                                                 type: TVOUT
                                                 known by bios: no
                                    state        state: 0x0d
                                                 query: 0x00
-------------------------------------------------------



Let me know, if you would like any additional information.

-- 
Garry T. Williams --- +1 678 656-4579
