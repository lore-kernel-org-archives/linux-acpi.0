From: Alexander Bruder <anib-La3J9u0raUk@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 5 Aug 2004 19:14:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408051914.39445.anib@anib.de>
References: <1091139240.26511.9.camel@6-allhosts> <yzo7jse5999.fsf@localhost.localdomain> <200408051453.55710.stefandoesinger@gmx.at>
Reply-To: anib-La3J9u0raUk@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408051453.55710.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stefandoesinger-RbZlAiThDcE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> Intel's new graphics chipset probably. Owners of Acer Travelmate 60X told
> me that the video doesn't come back. But in the these case the whole system
> locked up on resume, so we can't tell if the video resume works.

it also happends for the 80x series (in my case 801Lcib) with ATI Technologies 
Inc Radeon R250 Lf [Radeon Mobility 9000] using the framebuffer. 
"echo 3 > /proc/acpi/sleep" and "echo 4 > /proc/acpi/sleep" doesn't work 
because video doesn't come back as described by Stefan. The only reaction is 
the fan which runs like hell and doesn't stop. Same thing with pmdisk and 
suspend to disk ("echo -n disk > /sys/power/state"). All tested with recent 
kernels 2.6.7-2.6.8-rc3 .
But with swsusp2 as the suspend to disk system  ("echo 
> /proc/swsusp/activate" ) on a 2.6.7 kernel the video card recovers!?! 
I don't know much about the whole thing and why swsusp2 can (help) recover(s) 
the video card but perhaps it may help you.  


Alexander


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
