From: Santiago Garcia Mantinan <manty-gaW6/AuhO2xeoWH0uzbU5w@public.gmane.org>
Subject: Re: acpi breaking synaptics mouse support on Acer Travelmate 260
Date: Wed, 20 Aug 2003 23:02:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030820210235.GD5127@man.beta.es>
References: <20030812221751.GA2432@man.beta.es> <m2ada8drjv.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2ada8drjv.fsf-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Peter Osterlund <petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Actually it is expected to see interrupts for about one second after
> you stop touching the touchpad, if you are using the synaptics driver.

After reading this I went and rechecked the 2.4 behaviour, in fact the
interrupts seem to work more or less the same on 2.6 and 2.4 producing
aproximately the same number of interrupts and stopping both 1 second after.
You are right, when I reported the bug I had tested 2.4 with the normal
driver and not the synaptics driver for X, sorry, I didn't know the X driver
could change the interrupt behaviour.

Well, to sum up, for what I see looking at /proc/interrupts both 2.4 using
the X synaptics driver, and 2.6 using the synaptics driver, produce
aproximately the same interrupt behaviour, however 2.6 looses sync when acpi
is compiled and works ok when acpi is not compiled :-(

Hope this clarifies the thing a little bit, sorry about the inexactitudes in
the first report.

If you need any other info or want me to make any tests just tell me.

Regards...
-- 
Manty/BestiaTester -> http://manty.net


-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
