From: Zaerc <laptop-5i3f5mHTS3sAvxtiuMwx3w@public.gmane.org>
Subject: keventd running wild on an asus m2400n
Date: Wed, 7 May 2003 07:51:04 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.10.10305070529120.17162-100000@Adrameleck.home.Zaerc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


Hello,


I'm trying to install Mandrake-9.1 on an ASUS M2400N laptop for a friend.
But after a short while, keventd starts eating up all the available cpu
time, only when ACPI is enabled.  

Because Mandrake tend to use weirdly patched kernels I've decided to patch
up my own, trying linux-2.4.21-rc1 with the acpi-20030424-2.4.21-rc1 patch
with the same results...  

An odd side effect is that ALSA wont be able to initialize the soundcard
when ACPI is disabled with acpi=off.  

Apart from these problems power management seems to be working just fine.
The only thing similar I could find while searching the web were a few
mails which sugested this ocured because the cpu gets hot, I'm refering to
the "[ACPI] C1VN, ACPI and ESD/ASD = const CPU" thread on this mailing
list on 2002.08.27.  BTW I haven't seen a dramatic increase in acpi
interrupts (/proc/interrupts), or any events (/proc/acpi/event)

I also tried linux-2.4.20 with the acpi-20021212-2.4.20 patch which had a 
similar problem only this time the troubling process was kacpidpc and it 
seems to die and restart very fast thus resulting in 100% cpu utilization 
as well.

To cut a long story short, I'm sort of at the end of my rope here.  I have
little hope of getting this working since I'll have to return the laptop
tomorow so it can be lobotomized with another OS (you know the one).
Meanwhile I'd like to be of some assistance to you developers, just in
case you might be interested.

The laptop is an ASUS M2400N with an 1.3 GHz Intel Pentium M processor
(centrino), AMIBIOS Date: 03/26/03 Version: 0203 (although when you enter
the bios setup it says v02.33) and the thing that really baffles me is
that it says "EVALUATION COPY, NOT FOR SALE" for a few seconds when
booting up?!?  So I wouldn't be surprised if that is the root of all these
problems.

If anyone has more suggestions on things to try or if someone would like
more info please let me know, a CC would be nice (and probably quicker)
since I'm not on the mailinglist.


With kind regards, Zaerc.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
