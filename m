From: "greg" <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Wed, 28 Jan 2004 15:07:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040128200719.M75620@morningdave.org>
References: <m3n087khfl.fsf@reason.gnu-hamburg> <401811E8.8060003@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <401811E8.8060003-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

---------- Original Message -----------
From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sent: Wed, 28 Jan 2004 20:47:52 +0100
Subject: Re: [ACPI] PROBLEM: ACPI crashes (2.6.2-rc2-mm1)

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello Georg,
> 
> on 01/28/04 20:21, Georg C. F. Greve wrote:
> > Suspending to disk (S4) suspends just fine. It also finds the file and
> > reads the data back into active memory, as well. But when it comes to
> > the message
> >
> >  "Waiting for DMAs to settle down."
> >
> > the machine suddenly crashes (reboot).
> it seems the same on my M3N, I attached some mails I already sent to
> this list, which solved the problem for S4, maybe you could give it a
> try. IMHO is still an Intel 855GM problem.
> 

I agree with this. I see exactly the same behavior on my Gateway 200X, which
has an Intel 855GM chipset. I'll try the suggestions from the appended emails
later to see if they help.

Thanks,
Greg


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
