From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: Problems with ACPI, power btns
Date: 28 Sep 2002 13:43:17 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033235004.2360.6.camel@darkstar.portugal>
References: <20020927092452.7003.qmail@webmail5.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020927092452.7003.qmail-rGs03M86+Jd1RbMNNJCVHYkgB36zAFJh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: James Joseph <janx1-QOiod4cnrWAN+BqQ9rBEUg@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-09-27 at 05:24, James Joseph wrote:
> Dear Sir,
> I have patched my 2.4.18 kernel with acpi-20020918.  There was a 
> top-level Makefile.rej but other than that the kernel compiled 
> properly and with Debug statements, i think ACPI is initializing.  
> I have the following problems:-

can you send me the Makefile.rej?
> 
> 1) I wish to use the "Sleep" "Wake Up" and "Power" buttons, but 
> when i press them i get (in /var/log/messages):-
> 
> kernel:keyboard:unknown scancode e0 5f, e0 63 and e0 5e 
> respectively for the above keys.  I'm using the default keymap.  
> What should i change to make the kernel recognize these scan 
> codes.  Or should i just install the acpi daemon.  I have not 
> installed the ospm deamon, is it required?
> 
yes, you can try install acpi daemon and add some scripts to acpid
(http://codecs.home.sapo.pt/acpi/index.html at end of the page)
and see if you can get events.

> 2) I am forced to give pci=noacpi since my NVIDIA Detonater 
> drivers crash if i have it enabled.  Is there any little patch i 
> can apply to my video drivers to fix this?
> 

try to search in this mailing list for NVIDIA patches I think they have 
one...
> 3) When i cat /proc/acpi/events i get nothing. (I'm guessing that 
> is just because of problem 1.
> 

> Please help!
> James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
