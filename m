From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: RE: Gateway 200X (again) - No power button events
Date: Sat, 24 Jan 2004 14:58:47 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074974327.5696.3.camel@localhost>
References: <F760B14C9561B941B89469F59BA3A84702C9323C@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C9323C-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi again,

   I created a bug for this, but I think I screwed something up, because
it's not coming to acpi-bugzilla. In case anyone is interested, it's bug
1920.

   http://bugzilla.kernel.org/show_bug.cgi?id=1920

   Sorry for the trouble - guess I still have to work out proper
bugzilla usage.

   Thanks,
    Greg


On Tue, 2004-01-20 at 19:23, Grover, Andrew wrote:
>  
> > From: Greg Sarjeant [mailto:greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org] 
> > Aha! That did the trick.
> 
> > And now dmesg reports:
> > So, it is picking up the Control Method Power Button, and I get events
> > from it now. Outstanding.
> 
> > Is this something that might find its way into the main kernel tree?
> > Should I submit a bug for this behavior?
> 
> Yes open a bug. Sounds like if both are present, CM should be preferred
> over FF. This is against what the spec says, so this may come down to a
> judgment call by Len. I don't know how common this problem is.
> 
> Regards -- Andy
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
