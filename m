From: "Alexander Isacson" <alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org>
Subject: Re: Please, please help me enable a serial port.
Date: Thu, 27 Nov 2003 17:02:50 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <10686.192.176.33.6.1069948970.squirrel@firewall.isacson.dyndns.info>
Reply-To: alexander-O4oeKNg1Q5OZuzBka8ofvg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thank you for taking your time to help me. I really appreciate it.

The port is an internal serial port that recieves signals from a
"pen"-pointing device. The problem is that the serial port is not active
on boot-up but has to be enabled through ACPI. There is a XFree driver
that works with the pen as soon as the signals from the device are sent t=
o
/dev/ttyS0.

I've had the pen up and running under kernel 2.4 but I was forced to
switch to 2.6 to get my WLAN working. All I need to do is enable the
serial port and I should be good to go.

Thanks again for you help.

/Alexander

> On Thu, Nov 27, 2003 at 09:09:19AM +0100, Alexander Isacson wrote:
>> Hello all.
>>
>> I'm in desperate need of help to enable a serial port on the Compaq ta=
ble
>> PC TC1000. I had it working with kernel 2.4.22 but I had to upgrade th=
e
kernel to 2.6.0-test10 to make the WLAN drivers for my new card work.
The
>> TC1000 will be used to remotely operate a small robot as part of my ma=
ster
>> thesis.
>>
>> The driver I was using before is called fpi2002 and I found it here:
http://linux-tablet-pc.dhs.org/. I attached it below along with the
readme. All it does is enable /dev/ttyS0. I'm no kernel programmer so
this
>> is like rocket-science to me. I also attached the compilation error I =
get
>> when trying to recompile the driver for 2.6.0-test10
>>
>> I have enabled the kernel option that states "8259/16550 device discov=
ery
>> via ACPI namespace" but that doesn't seem to enable the port.
>>
>> I have tried to gather as much information as possible to help you hel=
p me
>> get this show back on the road!
>>
>> Regards
>> /Alexander Isacson
>
> That sound like a little dummy kernel module.  It is easy to make it
working in 2.6.  I will look at.
>
> Now, what do you want exactly?  Looking your dsdt, I guess we can do it
in a full ACPI way.
>
> --
> Ducrot Bruno
>
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
>





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
