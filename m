From: Constantinos Antoniou <costas-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Subject: General ACPI/Linux question
Date: 25 Jan 2003 20:54:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043546064.14472.9.camel@nefeli>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

I have a laptop (Compaq Presarion 1700T) and would really really like to
have some ACPI support (battery status is very important, suspend to ram
or disk - anything faster than reboot- would be very very useful and
welcome). 

I have not tried every possible trick, and in any case I am hoping to
get some things working this year... either with the introduction of
ACPI in RH8.1 or otherwise (ok, this is not flame-bait. Let me move on
:)) This is not a system/problem specific post, however.

My question is: One of the most usual things I see in the various
newsgroup posts is that DSDT tables are buggy, and people need to
disassemble them, edit them, replace them etc etc. However, windows
power management on the same machines works. So what is the situation? 

The way I (don't) understand it, the ACPI implementation expects some
things to be defined correctly in the DSDT table. However, some OSes
manage to work with whatever is there.

And to go one step further, if I change this DSDT thingie, will the ACPI
functionality in the other OSes still work? So, would an option be to be
more lenient (I understand that there are standards and people should
respect them...)

Thanks in advance and please be considerate in the replies - IANA ACPI
expert.

Costas


-- 
Constantinos Antoniou
Ph.D. Candidate
Massachusetts Institute of Technology
Intelligent Transportation Systems Program
77 Massachusetts Ave., NE20-208, Cambridge, MA 02139
(T) 617-252-1113 * (F) 617-252-1130 * (email) costas-3s7WtUTddSA@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
