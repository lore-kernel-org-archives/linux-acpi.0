From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop: ACPI Exception when a Fn-Key is pressed
Date: Mon, 6 Apr 2009 20:01:55 +0900
Message-ID: <20090406110154.GA25085@kamineko.org>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:54630
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbZDFLB6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2009 07:01:58 -0400
Content-Disposition: inline
In-Reply-To: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rodrigo Luiz <rodrigo@gus-mg.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Sun, Apr 05, 2009 at 09:27:06PM -0300, Rodrigo Luiz wrote:
> Hi.
> 
> I have a Vaio VGN-FW235J and I tried today the latest kernel version
> in git to test the latest changes in sony-laptop.
> 
> When I press any Fn-keys, i.e. brightness control, I received these
> messages in syslog:
> 
> ACPI Error (hwvalid-0186): Denied AML access to port 0x00000080/4
> (DMA1 0x0081-0x0083) [20090320]
> ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by
> Handler for [SystemIO] [20090320]
> ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node
> f7418c30), AE_AML_ILLEGAL_ADDRESS
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPCB.EC__._Q58] (Node f741bc00), AE_AML_ILLEGAL_ADDRESS
> ACPI Error (hwvalid-0186): Denied AML access to port 0x00000080/4
> (DMA1 0x0081-0x0083) [20090320]
> ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by
> Handler for [SystemIO] [20090320]
> ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node
> f7418c30), AE_AML_ILLEGAL_ADDRESS
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPCB.EC__._Q59] (Node f741bc18), AE_AML_ILLEGAL_ADDRESS

Interesting. This is due to a change in current git it was not present
in 2.6.29.

Does booting with acpi_osi=Linux makes things any worse? (it should fix
the above error but might make some other functionality behave
differently).
Or eventually also see if there is a bios upgrade available for your
laptop.

Len,
it looks like most of the vaios define this in global scope:

    OperationRegion (PRT0, SystemIO, 0x80, 0x04)
    Field (PRT0, DWordAcc, Lock, Preserve)
    {   
        P80H,   32
    }

which falls in the DMA1 reserved area in >WinXP.
No idea how windows copes with it if the same restrictions area really
in place.

-- 
mattia
:wq!
