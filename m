From: jgluckca-VsqqI1RANlHk1uMJSBkQmQ@public.gmane.org (John)
Subject: Question on ACPI and laptop
Date: Tue, 03 Feb 2004 12:58:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5F88A601.367D718E.009D6C5C@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

My first time posting here...

I have a problem that I'm trying to find a solution to...

When Linux starts, the startup script checks to see if the filesystem is due to be checked. If I'm running on AC, it's fine to check the filessystem. However, on batteries, I want to prevent the check from happening.

I'm running a 2.6 series kernel.

Once everything is up and ruuning, the /proc filesystem is mounted and I could do something like this in a script:

# If runninng on batteries, /proc/acpi/ac_adapter/ACAD/state
# will have a line that reads: "state:                   off-line"
# We use this to avoid a fsck if on batteries.
# The next time we go to AC power, the fsck will get done.

if [ -f /proc/acpi/ac_adapter/ACAD/state ]; then
   ac_state=$(grep -o 'off-line' /proc/acpi/ac_adapter/ACAD/state)
     echo "AC adapter is $ac_state"
else
     echo "AC adapter state file not found"                
fi

Unfortunately, the root filesystem is R/O at this time and the check is done before /proc is mounted, so that won't work.

Next I looked at the kernel files to see what it does. I founnd a include/linux/acpi.h which seems to interface with the ACPI subsystem but I can't seem to find any doc on this.

I poked around in the kernel and found various functions driver/acpi/ac.c but I don't think these are avialable as system calls. So.. I can't write a C program to get the ac adapter state.

If anyone cann tell me how to get the ac adapter state __before__ /proc is mounted it would be greatly appreciated. It appears that there is an interface in $LINUX/include/linux/acpi.h but there is no documentation in it.

Please cc my e-mail as I'm not subscribed to this list.

Thanks

John



-- 
The past is history
The future is a mystery
Now is a gift
That's why it's called the present


__________________________________________________________________
New! Unlimited Netscape Internet Service.
Only $9.95 a month -- Sign up today at http://isp.netscape.com/register
Act now to get a personalized email address!

Netscape. Just the Net You Need.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
