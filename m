From: "James  Joseph" <janx1-QOiod4cnrWAN+BqQ9rBEUg@public.gmane.org>
Subject: Problems with ACPI, power btns
Date: 27 Sep 2002 09:24:52 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927092452.7003.qmail@webmail5.rediffmail.com>
Reply-To: "James  Joseph" <janx1-QOiod4cnrWAN+BqQ9rBEUg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear Sir,
I have patched my 2.4.18 kernel with acpi-20020918.  There was a 
top-level Makefile.rej but other than that the kernel compiled 
properly and with Debug statements, i think ACPI is initializing.  
I have the following problems:-

1) I wish to use the "Sleep" "Wake Up" and "Power" buttons, but 
when i press them i get (in /var/log/messages):-

kernel:keyboard:unknown scancode e0 5f, e0 63 and e0 5e 
respectively for the above keys.  I'm using the default keymap.  
What should i change to make the kernel recognize these scan 
codes.  Or should i just install the acpi daemon.  I have not 
installed the ospm deamon, is it required?

2) I am forced to give pci=noacpi since my NVIDIA Detonater 
drivers crash if i have it enabled.  Is there any little patch i 
can apply to my video drivers to fix this?

3) When i cat /proc/acpi/events i get nothing. (I'm guessing that 
is just because of problem 1.

Please help!
James
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
