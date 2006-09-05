From: Yu Luming <luming.yu@intel.com>
Subject: Re: Blacklisted system / blacklisting bad
Date: Tue, 5 Sep 2006 14:43:46 +0800
Message-ID: <200609051443.47032.luming.yu@intel.com>
References: <200609031134.33024.dieter.jurzitza@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29470 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750756AbWIEGmr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 02:42:47 -0400
In-Reply-To: <200609031134.33024.dieter.jurzitza@t-online.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dieter Jurzitza <dieter.jurzitza@t-online.de>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

On Sunday 03 September 2006 17:34, Dieter Jurzitza wrote:
> Dear listmembers,
>  I recently got a HP VISUALIZE NT workstation, using 2x 1GHz PIII
> processors (no racing car, but that's not the point). After installat=
ion
> ACPI was always disabled, the on board USB interface did not work (ke=
rnel
> 2.6.11.4 (SuSE linux 9.3)
>
>  I tested using acpi=3Dforce on the commandline and that solved two p=
roblems:
>
I guess this is a pretty old box, and acpi just happen to work.

>  1.) shutdown -h now switches the machine off (should be expected :-)=
:-) )
>  2.) much more important: the onboard USB interface works now.
>
>  After patching dmi_scan.c and removing the blacklist-entry I get the
> following message at boot time:
>
>  <4>PCI: Probing PCI hardware (bus 00)
>  <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>  <4> =A0 =A0ACPI-0234: *** Warning: Wrong _BBN value, please reboot a=
nd using
>  option 'pci=3Dnoacpi'
>  <6>ACPI: PCI _CRS 2 overrides _BBN 0

You are hitting this issue:=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D1662#c42

If everything works fine, please don't  ignore the warning message.

Thanks,
Luming
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
