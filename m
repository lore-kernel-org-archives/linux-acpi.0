From: Martin Lorenz <martin-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Subject: kern 2.6.1 - suspend/resume still malfunctioning
Date: Thu, 15 Jan 2004 14:10:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40069161.4040703@lorenz.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Dear all,

well I am playing around to get suspend/resume working on my PC-MM10 for
quite a while now, and have run from one failing into the next...

lately I switched to vanilla 2.6.1 kernel to give it another try.

it somehow got better than before:
I can successfully resume now and the console is reactive again.
thats a real improvement!

but about a second after resume (when I hit the enter key the third
time) I got an Oops, that took about five seconds or more to scroll over
the screen (needless to say, that I could not read a word of what it was
saying) and ended up complaining about a panic in the interrupt handler.

maybe you can just tell me a patch, i could not find by myself...
I tried to go through the archive, but sf.net tells me, there would be
no archive for acpi-devel.

or is it a dsdt issue, and I should rather fix my dsdt? ...I'm afraid
i'd need some help in that case too.

all the data, i reported about my laptop is recorded with bug #1773
http://bugme.osdl.org/show_bug.cgi?id=1773

do you need anything else?
i am also willing and able to do some hacking too, but i don't quite
know where to start looking at.

greets and thanks
mlo
-- 
martin lorenz
--
	They that can give up essential liberty
	to obtain a little temporary safety
	deserve neither liberty nor safety.
				-- Benjamin Franklin




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
