From: Marco Bertola <bertola-fC0AHe2n+mcHBZzjifzFer/b/tBG6AW9@public.gmane.org>
Subject: Fan control on Sony Vaio PCG-NVR23
Date: Mon, 2 Feb 2004 02:01:19 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.33.0402020159310.21474-100000@maxwell.mathstat.concordia.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 (Athlon 1.5Ghz, 256Mb, 30Gb, nVidia Geforce 4)

 Ok here is it:
 under linux the fan is whirring constantly (very annoying).
 After trying around I found a useful bug.

 echo 5 > /proc/acpi/sleep

 This normally should turn off the machine but instead it > seems as if puts
 the cpu in some "cooler" mode, the temperature drops to 56-57
 and the fan
 turns off (and back on when temp goes up). The computer becomes really
 quiet (even more than in windoze!)
 No appreciable performance loss (it is not a throttling state change).

 In other words ACPI seems to be doing what it is supposed to do

 This happens ONLY with kernel 2.4.21-0.13mdk (out-of-the box
 Mandrake 9.1)
              ^^^^
 there are drawbacks: firewire (raw1394)
  port is broken with acpi, I have to reboot
 with acpi=off if I want to use it (DV input), the mike (yes! the
 microphone!) does not work with acpi, occasionally it hangs (VERY
 rarely, basically only if I play bzflag (?!): but now I have
 ext3 and recovery is as long as a normal reboot. Not too bad!)

 I have tried compiling other kernels (2.4.22, 2.6.0, 2.6.1, you name
 it, with or without APM (which may conflict))
 I have tried Fedora (2.4.22-1.2115.nptl)
 No avail.

 Note that in all these other kernels the acpi support IS
 present, I can
 check the temperature -which NEVER drops below 68, hence the fan not
 stopping, I guess- (the directory /proc/acpi is identical as far as I
 can see)
 And in these kernels the sleepstate 5 does what's supposed to
 do: unceremoniously shut the machine down.

 I would like not to be stuck with Mandrake 9.1, but the noise is
 unbearable otherwise.

 Anybody has any idea of why this happens/how to make it
 happen "the right
 way" (and keeping stability)?


 Thanks
 Marco



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
