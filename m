From: "Don Langworthy" <dbl-t4aQvBRgbK03GDxJruMu3g@public.gmane.org>
Subject: RE: S3 and S4: nothing happens
Date: Mon, 14 Oct 2002 12:58:49 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000301c273bc$1db43370$46ffff0a@DigitalCog>
References: <1034583098.369.40.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1034583098.369.40.camel-s1IKGncK6J2OERECOqmV57dB6IYNvbhm87tLKu7D3g4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: 'Knut Neumann' <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Knut:

See responses below. 

Thanks for your help.

Don Langworthy
dbl-t4aQvBRgbK03GDxJruMu3g@public.gmane.org

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Knut Neumann
> Sent: Monday, October 14, 2002 1:12 AM
> To: Don Langworthy
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] S3 and S4: nothing happens
> 
> Am Son, 2002-10-13 um 23.58 schrieb Don Langworthy:
> > echo 5 > /proc/acpi/sleep causes an immediate ungraceful power off.
> > All other values seem to have no effect on the system power state.
> 
> See my mail on this thread: Only S1/S5 are supported under 2.4
kernels.
> IIRC S5 sudden shutoff is intended. Andrew Grover gave an explanation
> that a few month ago but I do not remember it exactly.
> 
> > I've noticed 3 different behaviors for performance and throttling
(under
> > /proc/acpi/processor).
> >
> > 1 No effect
> > 2 Change state for a few seconds then reverts back to full power
mode 
> > 3 Changes state permanently.
> 
> Could you provide some more details? What exactly happens in what case
> (eg. does echo 1:1 > /proc/acpi/../performance have no effect?)

I've always use echo 1 > /proc/acpi/../performance (is the :1
significant?). 
For example If I run:

echo 1 > /proc/acpi/../performance; cat /proc/../performance

And I'm in state 1 (from above) the results of the cat indicates that
the cpu is still at full power mode (1000 mHz). If I'm in state 2 or 3
then the cat indicates low power mode (700 mHz).  If I wait 2-4 seconds
and cat .../performance again, I see either full power mode (state 2) or
low power mode (state 3). If the low power mode persists for longer that
4 seconds it seems to persist until I change it or reboot.
> 
> > The system seems to pick one behavior at boot time and stick with it
> > until the next boot time.
> 
> Let me get that right: You boot your system and then you find one of
the
> above points in effect and that behaviour does not change until
reboot,
> but then might be different? Surprising.

Yes, you've got it right.  I was also surprised at the behavior.  I'll
continue to monitor the behavior and see if I can pick out any patterns.

> 
> > I'm using the 20020918 patch to the 2.4.18 kernel. I can't get the
> > 20021002 patch to the 2.4.20pre8 kernel to patch (or compile)
cleanly.
> 
> What exactly is the problem? I would need the output of your
> patch/compile attempt to be more helpful :)

I'll run the patch/compile again and send the errors. It may be a few
hours before I can get to it though.

> 
> -Knut
> 
> PS: Did anyone yet try to update the FAQ?  Otherwise I might take an
> evening if someone would correct the english at last.
> 
> --
> Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
> Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
> Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
> fon: +49-211-81-11314                           fax: +49-211-81-13105
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
