From: Fred Thiele <ferdy_news-Mmb7MZpHnFY@public.gmane.org>
Subject: AC/Battery problems on Toshiba SatPro L10-101
Date: Mon, 11 Jul 2005 09:23:38 +0200
Message-ID: <20050711072338.GB9911@w0t4n.th0r.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

at first I want to say hello to you all. This is my first mail to
this list, and I hope there will be success in solving my problems
while beeing _on_ the list.

Last week I bought a relatively cheap Toshiba SatPro L10 with an
Pre-Installed M$ WXp. So I quickly decided to put a real OS on it.
What I tried was 

a) Debian Sarge (netinstall)
   - freeze after booting, somehow in context of the integrated
     modem, with both kernel 2.4 and 2.6 on that release

b) FreeBSD (actual release)
   - was to messy to configure (sorry...) so i decided to stay with
     linux

c) finally GentooLinux
   - this is what i actually run now, run on my desktop and run
     everywhere a friend asks me to help him with installing linux
     ;)

In the kernel-config  (using 2.6.12) i've choosen every needed stuff
to get Powermanagment working. This is, what actually works:

* Softwaresuspend

ACPI:
* Button
* Processor/Thermal (Fans are switched on if a temperature threshold
  is reached)

What does not work is AC/Battery Status, Charge Status, current
capacity of the battery. I further cannot control the fans myself (I
tried to switch on the second fan: 

    echo -n 1 > /proc/acpi/fan/FAN1/state
    echo off > ..

Well, this is not especially wanted. But to have informationen of
the current power ressource and capacity would be of importance.
What I had not looked in more deeply is video stuff.

Yesterday i read into DSDT issues and read the seemingly great howto
of jetblack in the gentoo forums:

    http://forums.gentoo.org/viewtopic.php?t=122145

There I read about even Toshibas (as member of the guys that
specified the ACPI) uncompliance to its specs. I tried to fix the
dsd-table using iasl -d and iasl -tc and removed three warnings. I
even read some of the ACPI Specs and the only one regarding Battery
in the dsdt i found here (with comments made by myself):

Device (SBS0)
{
    Name (_HID, "ACPI0002")
    Name (_SBS, 0x01) // Indicate support for one battery
}

But no single information about _BIF or _BST (static information and
current battery status)- thise Objects are _missing_ in the dsdt.

But anyhow in WinXp those information is extracted, constructed,
gained- i dont know... This would be one of my questions: Can I
simply add the missing Objects in the dsdt, how do get informationen
about the used hardware and the like?

What would you suggest me to do in this situation, any hints?

-- 
Best regards,

Fred Thiele


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
