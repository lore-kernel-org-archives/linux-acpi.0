From: Daniel Dorau <daniel.dorau-kiZ+YAcFTqyAKZTfuerNgRvVK+yQ3ZXh@public.gmane.org>
Subject: ACPI problem report for Thinkpad X31
Date: Wed, 4 Feb 2004 19:22:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040204182215.GA1536@woodstock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello,
after patiently waiting for the 2.6.2 kernel I just tested whether
S3 suspend got better with 2.6.2. Unfortunately it did not.
What I did:

echo 3 > /proc/acpi/sleep (without X, radeonfb)

System goes into suspend, moon LED is on but LCD backlight stays on.
(actually, my thinkpad is attached to a port replicator with external
monitor attached. So actually, on suspending the backlight switched
on instead of keeping off)
On resume, backlight switches off again and the external monitor on,
moon LED stays on and the whole thing hangs. Guessed that it was USB
still hanging the system on resume (guessed right).

Tried again without USB drivers loaded. Suspend works as above.
Resume now works, but prints two times:

MCE: The hardware reports a non fatal, correctable incident occured on
CPU 0
Bank 1: f200000000000185

However, if I now try to reload ehci_hcd, it oopses - trying to reload
uhci_hcd hangs the whole system. Hmmm. Bad.

At this stage, I didn't tried to go to S4.

Can you give me any hint whether you are knowing about these problems,
know a fix or a mid-term solution for this? I really like my X31 and
it would be really great if I could use S3 and S4 with it.
(The whole speed step thingie with the Pentium M already works great,
thank you).

Best regards,
Daniel

P.S. Please CC me on reply.

-- 
Daniel Dorau
daniel.dorau-kiZ+YAcFTqyAKZTfuerNgRvVK+yQ3ZXh@public.gmane.org



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
