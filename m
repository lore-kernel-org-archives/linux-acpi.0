From: Markus Feldmann <feldmann_markus@gmx.de>
Subject: Re: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Fri, 04 May 2007 18:30:59 +0200
Message-ID: <463B5FC3.9030300@gmx.de>
References: <46370B26.2080704@gmx.de>	 <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>	 <46371966.2020300@gmx.de>	 <8f8ff01d0705010638x5d4d398dk6f754e1f2cd2198a@mail.gmail.com>	 <463982CA.1060806@gmx.de> <8f8ff01d0705030912p1694820by1b61a85604d62916@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:36448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031346AbXEDQai (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2007 12:30:38 -0400
In-Reply-To: <8f8ff01d0705030912p1694820by1b61a85604d62916@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Alexey Starikovskiy schrieb:
> I already received your dsdt.dsl to my mailbox. I answered as well,
> but your provider seem to block whole gmail.com domain.
> Lets try to go without attachements:
> First error -- move Stall() function out of Return().
> Second error -- you have wrong length for optional _PSD object, so
> iasl puts everything after first item as garbage. just delete whole
> Name(_PSD {} from both places, it will ok.
> 
> Regards,
> Alex.
Hi Alex,

i have changed some settings in my gmx account to receive mails from
gmail.
It should work now.

I have moved out Stall(0x0F),
########################
{
	Stall (0x0F)
	Return ()
}
########################

and i have deleted,
###########################
Name (_PSD, Package (0x01)
{
	Package (0x05)
	{
		0x05
		0x00
		0x00000000,
		0x000000FD
	}
})
#############################


But then i got this errors,
#########################################################
dsdt_2.6.21.dsl    20:     Name (_T00, 0x00)
Warning  1097 -                     ^ Unknown reserved name (_T00)

dsdt_2.6.21.dsl  6218:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6232:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6247:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6262:             Acquire (MUTE, 0x0FFF)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6276:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6291:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6306:             Acquire (MUTE, 0x03E8)
Warning  1103 -   Possible operator timeout is ignored ^

dsdt_2.6.21.dsl  6504:     Method (WFZF, 1, NotSerialized)
Warning  1086 -                       ^ Not all control paths return a
value (WFZF)

dsdt_2.6.21.dsl  6520:         #Return ()
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6597:         #Name (_PSD, Package (0x01)
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6598:         #{
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6599:         #    Package (0x05)
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6600:         #    {
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6601:         #        0x05,
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6602:         #        0x00,
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6603:         #        0x00000000,
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6604:         #        0x000000FD
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6605:         #    }
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6606:         #})
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6607:         Zero
Error    4094 -                   ^ syntax error, unexpected PARSEOP_ZERO

dsdt_2.6.21.dsl  6662:         #Name (_PSD, Package (0x01)
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6663:         #{
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6664:         #    Package (0x05)
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6665:         #    {
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6666:         #        0x05,
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6667:         #        0x00,
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6668:         #        0x00000000,
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6669:         #        0x000000FD
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6670:         #    }
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6671:         #})
Error    4094 -                ^ Invalid character (0x23), expecting ASL
keyword or name

dsdt_2.6.21.dsl  6672:         Zero
Error    4094 -                   ^ syntax error, unexpected PARSEOP_ZERO

ASL Input:  dsdt_2.6.21.dsl - 7678 lines, 256455 bytes, 2870 keywords
Compilation complete. 23 Errors, 9 Warnings, 0 Remarks, 701 Optimizations

#########################################################


bye Markus

