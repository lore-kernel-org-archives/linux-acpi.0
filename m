From: "PSI-Systems" <x545-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ibm-acpi-0.4
Date: Fri, 24 Sep 2004 11:11:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <002b01c4a216$8a2928f0$6901a8c0@A31>
References: <20040916102610.GU20883@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> This is the fourth alpha release of my ACPI driver for IBM ThinkPad
> laptops. The features currently supported are:
>
>        - Fn key combinations
>        - Bluetooth enable and disable
>        - video output switching, video expansion control
>        - ThinkLight on/off
>        - limited docking and undocking
>        - UltraBay device eject
>
> So far, it has been tested on several T, X and R series ThinkPads. I
> appreciate any user reports, either successful or unsuccessful. Please
> see the included README for more information.
>
> Changes since 0.3:
>
>        - support for video output switching
>        - video expansion control
>        - UltraBase device eject
>        - all commands can be issued as module parameters at insmod time
>        - the hotkey mask can be in a 0xXXXX format
>        - dropped the brightness/LCD off feature, didn't work
It works here (IBM A31 2652-M5G). Can you please reinclude it in 0.5? I'll 
send you a detailed report as soon as I've read the README file.

>        - updated example acpid configuration scripts
>
> The video output control can be used to avoid the annoying flicker and
> video corruption when opening the lid on the X40. See the README for
> details.
>
> The ibm-acpi project now has an official home, thanks to Arno Willig
> <akw-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>:
>
>        http://ibm-acpi.sourceforge.net/

Thx.

Sandro 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
