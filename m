From: ben lamothe <blamothe-DPNOqEs/LNQ@public.gmane.org>
Subject: Thinkpad T40 Fan
Date: Wed, 4 Feb 2004 06:13:02 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040204061302.7e828f2b.blamothe@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi, I have an IBM Thinkpad T40 and the fan won't shut off.  If the
computer is left idle after power on, after about five minutes the
fan turns on and stays on seemingly for hours.  This behavior is not
exibited in Windows, on the contrary, the fan is almost never on.  Using
the thermal zone driver from acpi, I've noticed that the fan is on for
temperatures as low as 86 degrees.  

I am using kernel 2.6.2-rc2-mm1 and I have acpi, sleep states, battery,
button, fan, processor, thermal zone, and relaxed aml all compiled in,
and I also notice the problem using kernel 2.6.0 and kernel 2.4.23.  I
also have cpu frequency scaling support, all three governors (userspace
as default), cpu frequency table helpers, acpi processor p-states and,
since this a centrino machine, Enhanced speedstep all compiled in my
kernel.  I have tried using both Cpufreqd and Cpudynd to scale the cpu,
which they do smoothly according to /proc/cpuinfo, but the fan still
persistently stays on.  Can anyone help me with this?

Thank you very much,

-ben lamothe



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
